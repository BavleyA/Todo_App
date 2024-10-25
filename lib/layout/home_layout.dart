import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:todoapp/modules/done_tasks/done_tasks_screen.dart';
import 'package:todoapp/modules/new_tasks/new_tasks_screen.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
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

  late Database database;

  @override
  void initState() {
    super.initState();
    createDatabase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[currentIndex],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          insertIntoDatabase();
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
            ),
            label: 'tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.check_circle_outline,
            ),
            label: 'done',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.archive_outlined,
            ),
            label: 'archived',
          ),
        ],
      ),
    );
  }


  void createDatabase() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database,version)
      {
        print('Data Base Created');
        // create tables
        database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT , time TEXT , status TEXT)').then((value) {
          print('table created');
        }).catchError((error){
          print('error while creating table ${error.toString()}');
        });

      },

      onOpen: (database){
        print('DataBase opened');
      },
    );
  }

  Future<void> insertIntoDatabase() async {
    await database.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO tasks(title,time,status) VALUES("first task" , "891","new")'
      ).then((value) {
        print('$value Inserted successfully');
      }).catchError((error) {
        print('error while inserting record ${error.toString()}');
      });
      return null;
    });
  }
}
