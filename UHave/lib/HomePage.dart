import 'package:flutter/material.dart';
import 'package:uhave_project/form.dart';
import 'package:uhave_project/modules/category.dart';
import 'package:uhave_project/multi_form.dart';

import 'Calendar.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool pressed= false;
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Categories',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        accentColor: Colors.greenAccent,
      ),
      home: MultiForm(),
      );
  }
}