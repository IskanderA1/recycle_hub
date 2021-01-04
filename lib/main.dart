import 'package:flutter/material.dart';
import 'package:recycle_hub/screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecycleHub',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}
