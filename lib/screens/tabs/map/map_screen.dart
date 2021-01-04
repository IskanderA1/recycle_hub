import 'package:flutter/material.dart';
import 'package:recycle_hub/screens/tabs/map/filter_detail_screen.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("RecycleHub"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.filter_alt),
              onPressed: () {
               Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return MapFilterDetailScreen();
              }),
            );
              },
            )
          ],
        ),
        body: Center(
          child: Text("MapScreen"),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Drawer Header'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {},
              ),
            ],
          ),
        ));
  }
}
