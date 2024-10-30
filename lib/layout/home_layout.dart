import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:todoapp/modules/done_tasks/done_tasks_screen.dart';
import 'package:todoapp/modules/new_tasks/new_tasks_screen.dart';
import 'package:todoapp/shared/constants.dart';
import 'package:todoapp/shared/cubit/cubit.dart';
import 'package:todoapp/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {

  var scaffoldKy = GlobalKey<ScaffoldState>();
  var formKy = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create:  (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context , AppStates state) {
          if(state is AppInsertDBState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context , AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKy,
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: ()
              {
                if(cubit.isbotSheetShown){
                  if(formKy.currentState!.validate()){
                    cubit.insertIntoDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text
                    );
                  }
                }
                else
                {
                  scaffoldKy.currentState?.showBottomSheet(
                        (context) => Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(20.0,),
                      child: Form(
                        key: formKy,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: titleController,
                              keyboardType: TextInputType.text,
                              validator: (value){
                                if(value.toString().isEmpty){
                                  return 'Title must not be empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Task Title',
                                prefixIcon: Icon(
                                  Icons.title,
                                ),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 15.0,),
                            TextFormField(
                              controller: timeController,
                              keyboardType: TextInputType.datetime,
                              onTap: (){
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  timeController.text = value!.format(context).toString();
                                  print(value.format(context));
                                });
                              },
                              validator: (value){
                                if(value.toString().isEmpty){
                                  return 'time must not be empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Task Time',
                                prefixIcon: Icon(
                                  Icons.timer_outlined,
                                ),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 15.0,),
                            TextFormField(
                              controller: dateController,
                              keyboardType: TextInputType.datetime,
                              onTap: (){
                                showDatePicker(
                                  context: context,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2030-12-31'),
                                ).then((value) {
                                  dateController.text = DateFormat.yMMMd().format(value!);
                                });
                              },
                              validator: (value){
                                if(value.toString().isEmpty){
                                  return 'date must not be empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Task Date',
                                prefixIcon: Icon(
                                  Icons.calendar_today,
                                ),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    elevation: 50.0,
                  ).closed.then((value) {
                    
                    cubit.changeButtomSheetState(
                        isShow: false,
                        icon: Icons.edit
                    );
                  });
                  cubit.changeButtomSheetState(
                      isShow: true,
                      icon: Icons.add
                  );
                }
              },

              child: Icon(
                cubit.fabIcon,
              ),
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeIndex(index);
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
        },
      ),
    );
  }

}