import 'package:provider/provider.dart';
import 'package:uhave_project/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:uhave_project/services/notification.dart';

import 'Calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Monteserat'),
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
      providers: [ChangeNotifierProvider(create: (_) => NotificationService())],
    );
  }
}
