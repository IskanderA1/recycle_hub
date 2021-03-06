import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_star_rating/flutter_star_rating.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:recycle_hub/bloc/map_screen_blocs/marker_info_bloc.dart';
import 'package:recycle_hub/bloc/map_screen_blocs/markers_collection_bloc.dart';
import 'package:recycle_hub/custom_icons.dart';
import 'package:recycle_hub/model/map_models.dart/marker.dart';
import 'package:recycle_hub/model/map_responses/markers_response.dart';
import 'package:recycle_hub/screens/tabs/map/filter_detail_screen.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/bottom_sheet_body.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/loader_widget.dart';
import 'package:recycle_hub/style/theme.dart';
import 'methods/header_builder.dart';
import 'methods/pre_information_container.dart';
import 'widgets/working_days_widget.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  CameraPosition cameraPosition;
  LatLng initLatLng;

  Future<String> getCurrentPosition() async {
    LocationData currentLocation;

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
  CameraPosition _camera;
  List<Widget> _list;

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
    _list = markersCollectionBloc.collection.markers.markers
        .map((item) => MarkerCardWidget(
              index: item.hashCode,
              marker: item,
              list: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                childAspectRatio: 8 / 2,
                physics: NeverScrollableScrollPhysics(),
                children: item.acceptTypes
                    .map((acceptsItem) => Container(
                          height: 10,
                          decoration: BoxDecoration(
                              color: kColorWhite,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: AutoSizeText(
                              "  ${acceptsItem.name}  ",
                              style: TextStyle(
                                  fontFamily: 'GilroyMedium', fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ))
        .toList();
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
              } else if (snapshot.data is MarkerCollectionResponseEmptyList) {
                return GoogleMap(
                    mapType: _currentMapType,
                    initialCameraPosition: cameraPosition,
                    onCameraMove: (CameraPosition camera) {
                      _camera = camera;
                    },
                    onMapCreated: (GoogleMapController controller) {
                      if (!_controller.isCompleted) {
                        _controller.complete(controller);
                      }
                    },
                    myLocationButtonEnabled: false,
                    myLocationEnabled: true,
                    zoomControlsEnabled: false,
                    compassEnabled: false);
              }
              return GoogleMap(
                  mapType: _currentMapType,
                  initialCameraPosition: cameraPosition,
                  onCameraMove: (CameraPosition camera) {
                    _camera = camera;
                  },
                  onMapCreated: (GoogleMapController controller) {
                    if (!_controller.isCompleted) {
                      _controller.complete(controller);
                    }
                  },
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  compassEnabled: false,
                  markers: Set<Marker>.from(
                      snapshot.data.markers.markers.map((marker) => new Marker(
                            markerId: MarkerId(marker.id),
                            //anchor: Offset(5, 5),
                            consumeTapEvents: true,

                            /*Цвет можно поменять здесь */
                            icon: BitmapDescriptor.defaultMarkerWithHue(4),
                            onTap: () {
                              markerInfoFeedBloc.pickEvent(Mode.INFO);
                              showStickyFlexibleBottomSheet(
                                  initHeight: 0.4,
                                  minHeight: 0.40,
                                  maxHeight: 0.85,
                                  context: context,
                                  headerHeight: 60,
                                  isExpand: false,
                                  /*decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          topRight: Radius.circular(40)),
                                      shape: BoxShape.rectangle,
                                      color: kColorWhite),*/
                                  decoration: ShapeDecoration(
                                    color: kColorWhite,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        topRight: Radius.circular(40),
                                      ),
                                    ),
                                  ),
                                  headerBuilder: (context, bottomSheetOffset) {
                                    return buildHeader(
                                        context, bottomSheetOffset);
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
                                  anchors: [0.0, 0.4, 0.85]);
                            },
                            position:
                                LatLng(marker.coords.lat, marker.coords.lng),
                          ))));
            }),
      ),

      ///Кнопка определения местоположения
      Positioned(
        top: (MediaQuery.of(context).size.height) / 2,
        right: 20,
        child: Container(
          height: 40,
          width: 40,
          child: FloatingActionButton(
            heroTag: null,
            onPressed: _currentLocation,
            shape: CircleBorder(side: BorderSide(color: kColorWhite, width: 5)),
            backgroundColor: kColorWhite,
            child: Icon(
              LofOut.location,
              size: 20,
              color: kColorBlack,
            ),
          ),
        ),
      ),

      ///Кнопка изменения направления
      Positioned(
        top: (MediaQuery.of(context).size.height - 100) / 2 - 60,
        right: 20,
        child: Container(
          width: 40,
          height: 40,
          child: FloatingActionButton(
            heroTag: null,
            backgroundColor: kColorBlack,
            //foregroundColor: kColorBlack,
            onPressed: northSouth,
            shape: CircleBorder(side: BorderSide(color: kColorWhite, width: 5)),
            child: Icon(
              Icons.explore,
              size: 40,
              color: kColorWhite,
            ),
          ),
        ),
      ),

      ///Зум +
      Positioned(
        top: 15,
        right: 20,
        child: Container(
          height: 40,
          width: 40,
          child: FloatingActionButton(
            heroTag: null,
            backgroundColor: kColorWhite,
            shape:
                CircleBorder(side: BorderSide(color: kColorWhite, width: 1.5)),
            onPressed: zoomIncrement,
            child: FaIcon(
              FontAwesomeIcons.plus,
              size: 16,
              color: kColorBlack,
            ),
          ),
        ),
      ),

      ///ZOOM -
      Positioned(
        top: 60,
        right: 20,
        child: Container(
          height: 40,
          width: 40,
          child: FloatingActionButton(
            heroTag: null,
            backgroundColor: kColorWhite,
            shape:
                CircleBorder(side: BorderSide(color: kColorWhite, width: 1.5)),
            onPressed: zoomDecrement,
            child: FaIcon(
              FontAwesomeIcons.minus,
              size: 16,
              color: kColorBlack,
            ),
          ),
        ),
      ),

      ///Маркеры списком
      Positioned(
        bottom: 80,
        left: 20,
        child: Container(
          height: 30,
          width: 100,
          child: FloatingActionButton.extended(
            heroTag: null,
            backgroundColor: kColorWhite,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: kColorWhite, width: 2),
                borderRadius: BorderRadius.circular(50)),
            onPressed: () {
              return showStickyFlexibleBottomSheet<void>(
                  initHeight: 0.4,
                  minHeight: 0.40,
                  maxHeight: 0.85,
                  context: context,
                  headerHeight: 40,
                  /*decoration: const BoxDecoration(
                    color: kColorWhite,
                    //shape: BoxShape.rectangle
                  ),*/
                  headerBuilder: (context, bottomSheetOffset) {
                    return buildHeaderAnimated(context, bottomSheetOffset);
                  },
                  builder: (BuildContext context, offset) {
                    return SliverChildListDelegate(
                      <Widget>[
                        MarkersListWidget(
                          list: _list,
                        )
                      ],
                    );
                  },
                  anchors: [0.0, 0.4, 0.85]);
            },
            icon: Icon(
              Icons.menu,
              color: kColorBlack,
              size: 20,
            ),
            label: Text(
              "Список",
              style: TextStyle(
                  color: kColorBlack,
                  fontFamily: "GilroyMedium",
                  fontWeight: FontWeight.w600,
                  fontSize: 11),
            ),
          ),
        ),
      ),
    ]);
  }

  void northSouth() async {
    GoogleMapController zController = await _controller.future;
    var currentZoomLevel = await zController.getZoomLevel();

    currentZoomLevel = currentZoomLevel;
    zController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _camera.target,
          zoom: currentZoomLevel,
        ),
      ),
    );
  }

  void zoomIncrement() async {
    GoogleMapController zController = await _controller.future;
    var currentZoomLevel = await zController.getZoomLevel();

    currentZoomLevel = currentZoomLevel + 2;
    zController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _camera.target,
          zoom: currentZoomLevel,
        ),
      ),
    );
  }

  void zoomDecrement() async {
    GoogleMapController zController = await _controller.future;
    var currentZoomLevel = await zController.getZoomLevel();

    currentZoomLevel = currentZoomLevel - 2;
    zController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _camera.target,
          zoom: currentZoomLevel,
        ),
      ),
    );
  }
}

class MarkersListWidget extends StatefulWidget {
  //final ScrollController controller;
  //final AsyncSnapshot<MarkersCollectionResponse> snapshot;
  final List<Widget> list;
  const MarkersListWidget({
    Key key,
    this.list,
  }) : super(key: key);

  @override
  _MarkersListWidgetState createState() => _MarkersListWidgetState();
}

class _MarkersListWidgetState extends State<MarkersListWidget> {
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return Container(color: kColorWhite, child: Column(children: widget.list));
  }
}

class MarkerCardWidget extends StatelessWidget {
  final GridView list;
  final int index;
  final CustMarker marker;

  const MarkerCardWidget(
      {Key key,
      @required this.index,
      @required this.marker,
      @required this.list})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(17, 30, 17, 30),
      child: Container(
        //height: 420,
        decoration: BoxDecoration(
            color: index % 2 == 0 ? kColorGreen : kColorPink,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    marker.name,
                    style: TextStyle(
                        color: index % 2 == 0 ? kColorWhite : kColorBlack,
                        fontFamily: "Gilroy",
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  StarRating(
                      rating: 3.5,
                      spaceBetween: 1,
                      starConfig: StarConfig(
                        fillColor: index % 2 == 0 ? kColorWhite : kColorBlack,
                        size: 15,
                        emptyColor: index % 2 == 0 ? kColorGreen : kColorPink,
                        strokeColor: index % 2 == 0 ? kColorWhite : kColorBlack,
                      ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      marker.address,
                      style: TextStyle(
                        color: index % 2 == 0 ? kColorWhite : kColorBlack,
                        fontFamily: "Gilroy",
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Flexible(
                    child: AutoSizeText(
                      "900 м",
                      style: TextStyle(
                          color: index % 2 == 0 ? kColorWhite : kColorBlack,
                          fontFamily: "Gilroy",
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Align(
                alignment: Alignment.center,
                child: WorkingDaysWidget(
                  workingTime: marker.workTime,
                  wColor: index % 2 == 0 ? kColorWhite : kColorBlack,
                  backColor: index % 2 == 0 ? kColorGreen : kColorPink,
                  hasSelection: false,
                  fontSize: 13,
                  size: Size(_size.width - 50, 130),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 4, 15, 4),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        "Принимают на переработку:",
                        style: TextStyle(
                            color: index % 2 == 0 ? kColorWhite : kColorBlack,
                            fontFamily: "Gilroy",
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    ]),
              ),
            ),
            Container(
                height: 60,
                padding: EdgeInsets.fromLTRB(15, 2, 15, 2),
                child: list)
          ],
        ),
      ),
    );
  }
}
