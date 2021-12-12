import 'package:uhave_project/HomePage.dart';
import 'package:flutter/material.dart';

import 'Calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "calendar",
      home: HomePage(),
      //routes: {'/calendar': (_) => Calendar()},
      //bu örnekte static veriler sadece transfer edilir sayfalar arasında
      //onGenerateRoute: (settings){},
    );
  }
}
