import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:todoapp/modules/done_tasks/done_tasks_screen.dart';
import 'package:todoapp/modules/new_tasks/new_tasks_screen.dart';
import 'package:todoapp/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  List<String> titles =[
    'New Tasks',
    'Done Tasks',
    'late Archived Tasks',
  ];

  void changeIndex (int index){
    currentIndex=index;
    emit(AppChangeBottomNavBar());
  }

  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void createDatabase(){
    openDatabase(
      'todo1.db',
      version: 4,
      onCreate: (database,version)
      {
        print('Data Base Created');
        // create tables
        database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT , time TEXT ,date TEXT, status TEXT)').then((value) {
          print('table created');
        }).catchError((error){
          print('error while creating table ${error.toString()}');
        });

      },

      onOpen: (database){
        getData(database);
        print('DataBase opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDBState());
    });
  }

  Future insertIntoDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) async{
      txn.rawInsert(
          'INSERT INTO tasks(title,time,date,status) VALUES("$title","$time","$date","new")'
      ).then((value) {

        print('$value Inserted successfully');
        emit(AppInsertDBState());

        getData(database);

      }).catchError((error) {
        print('error while inserting record ${error.toString()}');
      });
      return null;
    });
  }

  void getData(database){

    newTasks=[];
    doneTasks=[];
    archivedTasks=[];
    database.rawQuery('SELECT * FROM tasks').then((value)
    {

      value.forEach((element) { 
        if(element['status'] == 'new'){
          newTasks.add(element);
        }
        else  if(element['status'] == 'done'){
          doneTasks.add(element);
        }
        else {
          archivedTasks.add(element);
        }
      });

      emit(AppGetDBState());
    });
  }


  void updateData({
    required String status,
    required int id,
}) async
  {
    database.rawUpdate(
        'UPDATE tasks SET status =? WHERE id = ?',
        ['$status' , id],
    ).then((value) {
      getData(database);
      emit(AppUpdateDBState());

    });

  }

  void DeleteData({
    required int id,
  }) async
  {
    database.rawDelete(
      'DELETE FROM tasks WHERE id = ?',
      [id],
    ).then((value) {
      getData(database);
      emit(AppDeleteDBState());

    });

  }


  bool isbotSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeButtomSheetState({
    required bool isShow,
    required IconData icon,
})
  {
    isbotSheetShown = isShow;
    fabIcon = icon;
    
    emit(AppChangeBottomSheetState());
  }

}