import 'package:flutter/material.dart';

Widget buildTaskItem (Map model) => Padding (
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
      Column(
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
    ],
  ),
);