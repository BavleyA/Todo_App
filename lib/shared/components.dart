import 'package:flutter/material.dart';

Widget buildTaskItem () => Padding (
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      CircleAvatar(
        radius: 40.0,
        child: Text(
          '02:00 PM',
        ),
      ),
      SizedBox(width: 20.0,),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Task title',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          Text(
            '26 oct 2024',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ],
  ),
);