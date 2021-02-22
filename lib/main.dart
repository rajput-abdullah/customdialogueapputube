import 'package:customdialogueapputube/checkbox.dart';
import 'package:customdialogueapputube/customDialogueBox.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/CustomDialogueBox',
  routes: {
    '/CustomDialogueBox': (context) => CustomDialogueBox(),

  },
)
);
