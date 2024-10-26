import 'package:flutter/material.dart';
import 'package:todoapp/shared/components.dart';
import 'package:todoapp/shared/constants.dart';

class NewTasksScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context,index) => buildTaskItem(),
        separatorBuilder: (context,index) => Container(
          width: double.infinity,
          height: 1.0,
          color: Colors.grey[300],
        ),
        itemCount: tasks.length,
    );
  }
}
