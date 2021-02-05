import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycle_hub/bloc/map_screen_blocs/markers_collection_bloc.dart';
import 'package:recycle_hub/model/map_responses/markers_response.dart';
import 'package:recycle_hub/screens/tabs/map/filter_detail_screen.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/bottom_sheet_body.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/loader_widget.dart';
import 'package:recycle_hub/style/theme.dart';
import 'package:location/location.dart';
import 'methods/header_builder.dart';
import 'methods/pre_information_container.dart';

class MapScreen extends StatefulWidget {
  /*final Widget child;
  MapScreen({this.child});*/
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  CameraPosition cameraPosition;
  LatLng initLatLng;

  Future<String> getCurrentPosition() async {
    LocationData currentLocation;
    GoogleMapController controller;
    var location = new Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }
    setState(() {
      initLatLng = LatLng(currentLocation.latitude, currentLocation.longitude);
      cameraPosition = CameraPosition(
        target: initLatLng,
        zoom: 12,
      );
    });
    return "Ok";
  }

  @override
  void initState() {
    super.initState();
  }

  AppBar mapScreenAppBar() {
    return AppBar(
      title: Text("RecycleHub"),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getCurrentPosition(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: mapScreenAppBar(),
            body: MyGoogleMapWidget(
              cameraPosition: cameraPosition,
            ),
          );
        } else {
          return LoaderWidget();
        }
      },
    );
  }
}

class MyGoogleMapWidget extends StatefulWidget {
  final CameraPosition cameraPosition;
  MyGoogleMapWidget({this.cameraPosition});
  @override
  _MyGoogleMapWidgetState createState() => _MyGoogleMapWidgetState();
}

class _MyGoogleMapWidgetState extends State<MyGoogleMapWidget> {
  Completer<GoogleMapController> _controller = Completer();
  MapType _currentMapType = MapType.normal;
  CameraPosition cameraPosition;

  @override
  void initState() {
    cameraPosition = widget.cameraPosition;
    super.initState();
  }

  void _currentLocation() async {
    LocationData currentLocation;
    GoogleMapController controller;
    var location = new Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }

    controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 17.0,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        child: StreamBuilder<MarkersCollectionResponse>(
            stream: markersCollectionBloc.stream,
            initialData: markersCollectionBloc.defaultItem,
            builder:
                (context, AsyncSnapshot<MarkersCollectionResponse> snapshot) {
              if (snapshot.data is MarkerCollectionResponseWithError ||
                  snapshot.data is MarkerCollectionResponseLoading) {
                return LoaderWidget();
              }
              print("Список получен");
              return GoogleMap(
                  mapType: _currentMapType,
                  initialCameraPosition: cameraPosition,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  markers: Set<Marker>.from(
                      snapshot.data.markers.markers.map((marker) => new Marker(
                            markerId: MarkerId(marker.id),
                            //anchor: Offset(5, 5),
                            consumeTapEvents: true,

                            /*Цвет можно поменять здесь */
                            icon: BitmapDescriptor.defaultMarkerWithHue(4),
                            onTap: () => showStickyFlexibleBottomSheet(
                                initHeight: 0.4,
                                minHeight: 0.40,
                                maxHeight: 0.85,
                                context: context,
                                headerHeight: 60,
                                headerBuilder: (context, bottomSheetOffset) {
                                  return buildHeader(
                                      context, bottomSheetOffset, marker);
                                },
                                builder: (context, offset) {
                                  return SliverChildListDelegate(
                                    <Widget>[
                                      AnimatedPreInformationContainer(
                                          offset: offset, marker: marker),
                                      BuildBody(marker: marker),
                                    ],
                                  );
                                },
                                anchors: [0.0, 0.4, 0.85]),
                            position:
                                LatLng(marker.coords.lat, marker.coords.lng),
                          ))));
            }),
      ),
      /*Кнопка определения местоположения */
      Positioned(
        bottom: 30,
        right: 10,
        top: 600,
        child: GestureDetector(
          onTap: _currentLocation
          /*() async {
            LatLng newLatLng = await getUserLocation();
            //setState(() {
             // latLng = newLatLng;
            //});
          }*/
          ,
          child: Container(
            height: 40,
            width: 40,
            //color: kColorGreen,
            decoration:
                BoxDecoration(color: kColorBlack, shape: BoxShape.circle),
            child: CircleAvatar(
              backgroundColor: kColorWhite,
              foregroundColor: kColorWhite,
              child: Icon(
                Icons.my_location_outlined,
                size: 30,
                color: kColorGreen,
              ),
            ),
          ),
        ),
      ),
      /*Кнопка изменения направления */
      Positioned(
        top: 30,
        left: 10,
        child: GestureDetector(
          onTap: northSouth,
          child: Container(
            height: 40,
            width: 40,
            //color: kColorGreen,
            decoration:
                BoxDecoration(color: kColorBlack, shape: BoxShape.circle),
            child: CircleAvatar(
              backgroundColor: kColorWhite,
              foregroundColor: kColorWhite,
              child: Icon(
                Icons.explore,
                size: 30,
                color: kColorGreen,
              ),
            ),
          ),
        ),
      ),
      /*Зум + */
      Positioned(
        top: 30,
        right: 10,
        child: GestureDetector(
          onTap: zoomIncrement
          /*() async {
            LatLng newLatLng = await getUserLocation();
            //setState(() {
             // latLng = newLatLng;
            //});
          }*/
          ,
          child: Container(
            height: 40,
            width: 40,
            //color: kColorGreen,
            decoration:
                BoxDecoration(color: kColorBlack, shape: BoxShape.circle),
            child: CircleAvatar(
              backgroundColor: kColorWhite,
              foregroundColor: kColorWhite,
              child: FaIcon(
                FontAwesomeIcons.plusCircle,
                size: 30,
                color: kColorGreen,
              ),
            ),
          ),
        ),
      ),
      /*ZOOM - */
      Positioned(
        top: 70,
        right: 10,
        child: GestureDetector(
          onTap: zoomDecrement,
          child: Container(
            height: 40,
            width: 40,
            //color: kColorGreen,
            decoration:
                BoxDecoration(color: kColorBlack, shape: BoxShape.circle),
            child: CircleAvatar(
              backgroundColor: kColorWhite,
              foregroundColor: kColorWhite,
              child: FaIcon(
                FontAwesomeIcons.minusCircle,
                size: 30,
                color: kColorGreen,
              ),
            ),
          ),
        ),
      )
    ]);
  }

  void northSouth() async {
    double screenWidth = MediaQuery.of(context).size.width *
        MediaQuery.of(context).devicePixelRatio;
    double screenHeight = (MediaQuery.of(context).size.height - 90) *
        MediaQuery.of(context).devicePixelRatio;

    double middleX = screenWidth / 2;
    double middleY = screenHeight / 2;
    GoogleMapController zController = await _controller.future;
    LatLng latLng = await zController
        .getLatLng(ScreenCoordinate(x: middleX.toInt(), y: middleY.toInt()));
    var currentZoomLevel = await zController.getZoomLevel();

    currentZoomLevel = currentZoomLevel;
    zController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latLng,
          zoom: currentZoomLevel,
        ),
      ),
    );
  }

  void zoomIncrement() async {
    double screenWidth = MediaQuery.of(context).size.width *
        MediaQuery.of(context).devicePixelRatio;
    double screenHeight = MediaQuery.of(context).size.height *
        MediaQuery.of(context).devicePixelRatio;

    double middleX = screenWidth / 2;
    double middleY = screenHeight / 2;
    GoogleMapController zController = await _controller.future;
    LatLng latLng = await zController
        .getLatLng(ScreenCoordinate(x: middleX.toInt(), y: middleY.toInt()));
    var currentZoomLevel = await zController.getZoomLevel();

    currentZoomLevel = currentZoomLevel + 0.5;
    zController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latLng,
          zoom: currentZoomLevel,
        ),
      ),
    );
  }

  void zoomDecrement() async {
    double screenWidth = MediaQuery.of(context).size.width *
        MediaQuery.of(context).devicePixelRatio;
    double screenHeight = MediaQuery.of(context).size.height *
        MediaQuery.of(context).devicePixelRatio;

    double middleX = screenWidth / 2;
    double middleY = screenHeight / 2;
    GoogleMapController zController = await _controller.future;
    LatLng latLng = await zController
        .getLatLng(ScreenCoordinate(x: middleX.toInt(), y: middleY.toInt()));
    var currentZoomLevel = await zController.getZoomLevel();

    currentZoomLevel = currentZoomLevel - 0.5;
    zController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latLng,
          zoom: currentZoomLevel,
        ),
      ),
    );
  }
}
