import 'package:flutter/material.dart';
import 'package:todoapp/shared/cubit/cubit.dart';

Widget buildTaskItem (Map model ,context) => Padding (
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      CircleAvatar(
        radius: 40.0,
        child: Text(
          '${model['time']}',
        ),
      ),
      SizedBox(width: 20.0,),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${model['title']}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Text(
              '${model['date']}',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      SizedBox(width: 20.0,),
      IconButton(
          onPressed: ()
          {
            AppCubit.get(context).updateData(
                status: 'done',
                id: model['id']);
          },
          icon: Icon(
           Icons.check_circle,
            color: Colors.green,
          ),
      ),
      IconButton(
        onPressed: (){
          AppCubit.get(context).updateData(
              status: 'archived',
              id: model['id']);
        },
        icon: Icon(
          Icons.archive,
          color: Colors.black45,
        ),
      ),
    ],
  ),
);