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
  List<Map> tasks = [];

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
        getData(database).then((value)
        {
          tasks = value;
          print(tasks);

          emit(AppGetDBState());
        });
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

        getData(database).then((value)
        {
          tasks = value;
          print(tasks);

          emit(AppGetDBState());
        });

      }).catchError((error) {
        print('error while inserting record ${error.toString()}');
      });
      return null;
    });
  }

  Future<List<Map>> getData(database) async{
    return await database.rawQuery('SELECT * FROM tasks');
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