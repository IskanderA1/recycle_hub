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
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: customDrawer,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _drawerKey.currentState.openDrawer();
            navBarStateBloc.pickState(1); //hide bottom nav bar
          },
        ),
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
      body: Stack(
        children: [
          _googleMap(),
        ],
      ),
    );
  }

  Widget _googleMap() {
    return Container(
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
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
  /*Marker firstMaeker(){
    return Marker(
      markerId: MarkerId("firstMarker",
      ),)
  }*/
}
