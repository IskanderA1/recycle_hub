import 'package:flutter/material.dart';
import 'package:recycle_hub/bloc/hide_nav_bar_bloc.dart';
import 'package:recycle_hub/elements/drawer.dart';
import 'package:recycle_hub/screens/tabs/map/filter_detail_screen.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: mapScreenAppBar(context),
        body: googleMap(context),
        drawer: mapScreenDrawer());
  }
}

Drawer mapScreenDrawer() {
  return Drawer(
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
  );
}

AppBar mapScreenAppBar(BuildContext context) {
  return AppBar(
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
  );
}

Widget googleMap(BuildContext context) {
  Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  return Stack(children: [
    Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        markers: {},
      ),
    ),
  ]);
}
