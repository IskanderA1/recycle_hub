import 'package:flutter/material.dart';
class MapFilterDetailScreen extends StatefulWidget {
  @override
  _MapFilterDetailScreenState createState() => _MapFilterDetailScreenState();
}

class _MapFilterDetailScreenState extends State<MapFilterDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          title: Text("Фильтр"),
          centerTitle: true,
        ),
        body: Center(
        child: Text("MapFilterDetailScreen"),
      ),
    );
  }
}