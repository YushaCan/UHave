import 'package:flutter/material.dart';

import 'Calendar.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool pressed= false;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Routing to calendar"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'First Page',
              style: TextStyle(fontSize: 50),
            ),
            RaisedButton(
              child: Text("Ev"),
              onPressed: () {
                Navigator.of(context).pushNamed('/calendar');
              },
            ),
            RaisedButton(
              child: Text("Add New Model"),
              onPressed: () {
                setState(() {
                  pressed = true;
                });
              },
            ),
            pressed? Text("the button is pressed") : SizedBox(),
          ],
        ),
      ),
    );
  }
}