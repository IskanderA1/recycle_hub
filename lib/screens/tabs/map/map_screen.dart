import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:recycle_hub/api/services/points_service.dart';
import 'package:recycle_hub/api/services/user_service.dart';
import 'package:recycle_hub/bloc/map/map_bloc.dart';
import 'package:recycle_hub/custom_icons.dart';
import 'package:recycle_hub/helpers/distance_helper.dart';
import 'package:recycle_hub/icons/app_bar_icons_icons.dart';
import 'package:recycle_hub/icons/nav_bar_icons_icons.dart';
import 'package:recycle_hub/model/map_models.dart/accept_types.dart';
import 'package:recycle_hub/model/map_models.dart/marker.dart';
import 'package:recycle_hub/screens/tabs/map/filter_detail_screen.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/bottom_sheet_container.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/loader_widget.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/markers_list_widget.dart';
import 'package:recycle_hub/elements/bottom_sheet.dart';
import 'package:recycle_hub/style/theme.dart';
import 'methods/header_builder.dart';
import 'methods/pre_information_container.dart';
import 'dart:developer' as developer;

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  CameraPosition cameraPosition = CameraPosition(target: LatLng(55.7985293, 49.1156465), zoom: 12.1);
  final Completer<GoogleMapController> _controller = Completer();
  MapBloc mapBloc;

  @override
  void initState() {
    getCurrentPosition();
    mapBloc = GetIt.I.get<MapBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mapScreenAppBar(),
      body: BlocBuilder(
        bloc: mapBloc,
        buildWhen: (previous, current) {
          if (previous is MapStateError) {
            developer.log("Got previous map screen error: ${previous.discription}", name: 'map.map_screen');
            return true;
          }
          if (current is MapStateError) {
            developer.log("Got current map screen error: ${current.discription}", name: 'map.map_screen');
            return false;
          }

          if (previous is MapStateLoaded && current is MapStateLoaded) {
            /* if (previous.markers == null || current.markers == null) {
                return true;
              }
              return previous.markers.length != current.markers.length; */
            return true;
          }
          return true;
        },
        builder: (context, state) {
          developer.log("Map rebuilds with: ${state.runtimeType}", name: 'screens.tabs.map.map_screen');
          if (state is MapStateLoaded) {
            return GoogleMapWidget(cameraPosition: cameraPosition, state: state, mapController: _controller);
          } else {
            return LoaderWidget();
          }
        },
      ),
    );
    /*return FutureBuilder<String>(
      future: getCurrentPosition(),
      builder: (context, snapshot) {
        developer.log("FutureBuilderState: ${snapshot.connectionState}",
            name: 'screens.tabs.map.map_screen');
        if (snapshot.hasData) {
          );
        } else {
          return LoaderWidget();
        }
      },
    );*/
  }

  AppBar mapScreenAppBar() {
    return AppBar(
      title: Text(
        "Карта",
        /* style: TextStyle(fontWeight: FontWeight.w700), */
        //textAlign: TextAlign.center,
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: kColorWhite,
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.filter_alt,
            color: kColorWhite,
            size: 20,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return BlocProvider.value(
                  value: mapBloc,
                  child: MapFilterDetailScreen(),
                );
              }),
            );
          },
        )
      ],
    );
  }

  Future<String> getCurrentPosition() async {
    LocationData currentLocation;

    var location = new Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }
    cameraPosition = CameraPosition(
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
      zoom: 12.1,
    );
    developer.log("User location: ${currentLocation.toString()}", name: 'screens.tabs.map.map_screen');
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
    return "Ok";
  }
}

class GoogleMapWidget extends StatefulWidget {
  GoogleMapWidget({Key key, @required this.cameraPosition, @required this.state, @required this.mapController}) : super(key: key);
  final CameraPosition cameraPosition;
  final MapStateLoaded state;
  final Completer<GoogleMapController> mapController;

  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  final MapType _currentMapType = MapType.normal;

  Set<Marker> markers = Set<Marker>();
  List<FilterType> filters = PointsService().filters;

  MapBloc mapBloc;
  GoogleMapController googleMapController;

  List<Widget> _list;
  ClusterManager<CustMarker> clusterManager;
  Iterable<ClusterItem> _items;
  CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(55.4727, 49.0652),
  );
  StreamSubscription<MapState> _mapSub;
  LatLng _userLocation;

  void _updateMarkers(Set<Marker> markers) {
    print('Updated ${markers.length} markers');
    setState(() {
      this.markers = markers;
    });
  }

  @override
  void initState() {
    _userLocation = LatLng(widget.cameraPosition.target.latitude, widget.cameraPosition.target.longitude);

    _items = widget.state.markers
        .map(
          (markItem) => ClusterItem(LatLng(markItem.coords[0], markItem.coords[1]), item: markItem),
        )
        .toList();
    clusterManager = ClusterManager<CustMarker>(
      _items,
      _updateMarkers,
      markerBuilder: _markerBuilder,
      initialZoom: widget.cameraPosition.zoom,
      stopClusteringZoom: 12,
      levels: [4, 6, 8, 10, 12],
      extraPercent: 0.8,
    );
    clusterManager.onCameraMove(_cameraPosition);
    clusterManager.setItems(_items);
    _mapSub = GetIt.I.get<MapBloc>().stream.listen((state) {
      if (state is MapStateLoaded && mounted) {
        setState(() {
          _items = state.markers
              .map(
                (markItem) => ClusterItem(LatLng(markItem.coords[0], markItem.coords[1]), item: markItem),
              )
              .toList();
        });
        clusterManager.setItems(_items);
      }
    });
    PointsService().loadAcceptTypes().then((value) {
      setState(() {
        filters = value;
      });
      _list = widget.state.markers.map((item) {
        double ddist = distanceInKm(
          UserService().location,
          Point(item.coords[0], item.coords[1]),
        );
        String dist = '';
        if (ddist < 0) {
          dist = ddist.toStringAsFixed(3).split('.').last + ' м';
        } else {
          dist = ddist.toStringAsFixed(1).toString() + ' км';
        }
        return MarkerCardWidget(
            index: item.hashCode,
            marker: item,
            distance: dist,
            onTap: () {
              if (googleMapController != null) {
                CameraUpdate cameraUpdate = CameraUpdate.newLatLngZoom(LatLng(item.coords[0], item.coords[1]), 17);
                googleMapController.animateCamera(cameraUpdate);
              }
              showStickyFlexibleBottomSheet(
                  initHeight: 0.2,
                  minHeight: 0.2,
                  maxHeight: 0.85,
                  context: context,
                  headerHeight: 40,
                  isExpand: false,
                  decoration: const ShapeDecoration(
                    color: kColorWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                  ),
                  headerBuilder: (context, bottomSheetOffset) {
                    return AnimatedHeader(bottomSheetOffset: bottomSheetOffset);
                  },
                  builder: (context, offset) {
                    return SliverChildListDelegate(
                      <Widget>[
                        AnimatedPreInformationContainer(
                          offset: offset,
                          marker: item,
                          filters: filters.isNotEmpty ? filters.where((element) => item.acceptTypes.contains(element.id)).toList() : [],
                          userPoint: Point(_userLocation.latitude, _userLocation.longitude),
                        ),
                        BuildBody(
                          marker: item,
                          filters: filters.isNotEmpty ? filters.where((element) => item.acceptTypes.contains(element.id)).toList() : [],
                        ),
                      ],
                    );
                  },
                  anchors: [0.0, 0.2, 0.85]);
            },
            filters: filters.isNotEmpty
                ? filters
                    .where(
                      (element) => item.acceptTypes.contains(element.id),
                    )
                    .toList()
                : []);
      }).toList();
    });
    super.initState();
  }

  List<IconData> icons = [Icons.ac_unit, Icons.account_balance, Icons.adb, Icons.add_photo_alternate, Icons.format_line_spacing];

  void _currentLocation() async {
    LocationData locationData;
    GoogleMapController controller;
    var location = new Location();
    try {
      locationData = await location.getLocation();
    } catch (e) {
      locationData = null;
    }
    if (_userLocation != null) {
      _userLocation = LatLng(locationData.latitude, locationData.longitude);
      controller = await widget.mapController.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            bearing: 0,
            target: LatLng(_userLocation.latitude, _userLocation.longitude),
            zoom: 15.0,
          ),
        ),
      );
    }
  }

  void _onCameraMove(CameraPosition position) {
    clusterManager.onCameraMove(position);
    _cameraPosition = position;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        child: GoogleMap(
          mapType: _currentMapType,
          initialCameraPosition: widget.cameraPosition,
          onCameraMove: _onCameraMove,
          onCameraIdle: clusterManager.updateMap,
          onMapCreated: (GoogleMapController controller) {
            if (!widget.mapController.isCompleted) {
              widget.mapController.complete(controller);
            }
            clusterManager.setMapController(controller);
            this.googleMapController = controller;
            setState(() {});
          },
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          compassEnabled: false,
          markers: markers,
        ),
      ),

      ///Кнопка определения местоположения
      Positioned(
        top: (MediaQuery.of(context).size.height) / 2 - 55,
        right: 20,
        child: Container(
          height: 40,
          width: 40,
          child: FloatingActionButton(
            heroTag: null,
            onPressed: _currentLocation,
            shape: CircleBorder(
              side: BorderSide(color: kColorWhite, width: 5),
            ),
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
            shape: CircleBorder(
              side: BorderSide(color: kColorWhite, width: 5),
            ),
            child: Icon(
              Icons.explore,
              size: 40,
              color: kColorWhite,
            ),
          ),
        ),
      ),

      /*  ///Зум +
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
                CircleBorder(side: BorderSide(color: kColorWhite, width: 1.5),),
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
                CircleBorder(side: BorderSide(color: kColorWhite, width: 1.5),),
            onPressed: zoomDecrement,
            child: FaIcon(
              FontAwesomeIcons.minus,
              size: 16,
              color: kColorBlack,
            ),
          ),
        ),
      ), */

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
              borderRadius: BorderRadius.circular(kBorderRadius),
            ),
            onPressed: () {
              return showStickyFlexibleBottomSheet<void>(
                  initHeight: 0.4,
                  minHeight: 0.40,
                  maxHeight: 0.85,
                  context: context,
                  headerHeight: 40,
                  decoration: const BoxDecoration(
                    color: kColorWhite,
                    //shape: BoxShape.rectangle
                  ),
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
            label: Text(
              "Список",
              style: TextStyle(color: kColorBlack, fontFamily: "GilroyMedium", fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
        ),
      ),
    ]);
  }

  Future<Marker> Function(Cluster<CustMarker>) get _markerBuilder => (cluster) async {
        bool hasFree = false;
        bool hasPartner = false;
        List<CustMarker> items = cluster.items != null ? cluster.items.toList() : List<CustMarker>.empty();
        PTYPE type;

        for (int i = 0; i < items.length; i++) {
          if (items[i].paybackType == 'partner') {
            hasPartner = true;
          } else if (items[i].paybackType == 'free') {
            hasFree = true;
          }
          if (hasPartner && hasFree) break;
        }

        if (hasFree) {
          if (hasPartner) {
            type = PTYPE.multi;
          } else {
            type = PTYPE.free;
          }
        } else {
          if (hasPartner) {
            type = PTYPE.partner;
          } else {
            type = PTYPE.free;
          }
        }
        return Marker(
          markerId: MarkerId(
            cluster.getId(),
          ),
          position: cluster.location,
          onTap: () {
            if (cluster.items.length == 1) {
              showStickyFlexibleBottomSheet(
                  initHeight: 0.2,
                  minHeight: 0.2,
                  maxHeight: 0.85,
                  context: context,
                  headerHeight: 40,
                  isExpand: false,
                  decoration: const ShapeDecoration(
                    color: kColorWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                  ),
                  headerBuilder: (context, bottomSheetOffset) {
                    return AnimatedHeader(bottomSheetOffset: bottomSheetOffset);
                  },
                  builder: (context, offset) {
                    return SliverChildListDelegate(
                      <Widget>[
                        AnimatedPreInformationContainer(
                          offset: offset,
                          marker: cluster.items.first,
                          filters: filters.isNotEmpty
                              ? filters
                                  .where(
                                    (element) => cluster.items.first.acceptTypes.contains(element.id),
                                  )
                                  .toList()
                              : [],
                          userPoint: Point(_userLocation.latitude, _userLocation.longitude),
                        ),
                        BuildBody(
                          marker: cluster.items.first,
                          filters: filters.isNotEmpty
                              ? filters
                                  .where(
                                    (element) => cluster.items.first.acceptTypes.contains(element.id),
                                  )
                                  .toList()
                              : [],
                        ),
                      ],
                    );
                  },
                  anchors: [0.0, 0.2, 0.85]);
            }
          },
          icon: await _getMarkerBitmap(cluster.isMultiple ? 125 : 75, text: cluster.isMultiple ? cluster.count.toString() : null, type: type),
        );
      };

  Future<BitmapDescriptor> _getMarkerBitmap(int size, {String text, @required PTYPE type}) async {
    if (kIsWeb) size = (size / 2).floor();

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    Paint paint1 = Paint();
    Paint paint2 = Paint();
    Paint paint3 = Paint();

    if (type == PTYPE.free) {
      paint1.color = kColorPink;
      paint2.color = Colors.white;
      paint3.color = kColorPink;
    } else if (type == PTYPE.partner) {
      paint1.color = kColorGreen;
      paint2.color = Colors.white;
      paint3.color = kColorGreen;
    } else {
      paint1.color = kColorPink;
      paint2.color = Colors.white;
      paint3.color = kColorGreen;
    }

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint3);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(fontSize: size / 3, color: Colors.white, fontWeight: FontWeight.normal),
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(
      data.buffer.asUint8List(),
    );
  }

  void northSouth() async {
    GoogleMapController zController = await widget.mapController.future;
    var currentZoomLevel = await zController.getZoomLevel();

    zController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _cameraPosition.target,
          zoom: currentZoomLevel,
        ),
      ),
    );
  }

  void zoomIncrement() async {
    GoogleMapController zController = await widget.mapController.future;
    var currentZoomLevel = await zController.getZoomLevel();

    currentZoomLevel = currentZoomLevel + 2;
    zController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: widget.cameraPosition.target,
          zoom: currentZoomLevel,
        ),
      ),
    );
  }

  void zoomDecrement() async {
    GoogleMapController zController = await widget.mapController.future;
    var currentZoomLevel = await zController.getZoomLevel();

    currentZoomLevel = currentZoomLevel - 2;
    zController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: widget.cameraPosition.target,
          zoom: currentZoomLevel,
        ),
      ),
    );
  }
}

enum PTYPE { free, partner, multi }

/* showBarModalBottomSheet(
                context: context,
                builder: (context) {
                  
                },); */
/*Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Material(
                            type: MaterialType.transparency,
                            child: DraggableBottomSheet(
                              previewChild: Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    color: Colors.pink,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),)\),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      width: 40,
                                      height: 6,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(kBorderRadius),),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'Drag Me',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: icons.map((icon) {
                                          return Container(
                                            width: 50,
                                            height: 50,
                                            margin: EdgeInsets.only(right: 16),
                                            child: Icon(
                                              icon,
                                              color: Colors.pink,
                                              size: 40,
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(kBorderRadius),),
                                          );
                                        }).toList(),)
                                  ],
                                ),
                              ),
                              expandedChild: Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    color: Colors.pink,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),),),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'Hey...I\'m expanding!!!',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Expanded(
                                      child: GridView.builder(
                                          itemCount: icons.length,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10,
                                          ),
                                          itemBuilder: (context, index) =>
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),),
                                                child: Icon(
                                                  icons[index],
                                                  color: Colors.pink,
                                                  size: 40,
                                                ),
                                              ),),
                                    )
                                  ],
                                ),
                              ),
                              minExtent: 150,
                              maxExtent:
                                  MediaQuery.of(context).size.height * 0.8,
                              backgroundWidget:
                                  Container(color: Colors.transparent),
                              blurBackground: true,
                            ),
                          ),),);*/

/*Material(
                      color: Colors.white.withOpacity(0),
                      child: DraggableBottomSheet(
                        previewChild: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),),),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: 40,
                                height: 6,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(kBorderRadius),),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Drag Me',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: icons.map((icon) {
                                    return Container(
                                      width: 50,
                                      height: 50,
                                      margin: EdgeInsets.only(right: 16),
                                      child: Icon(
                                        icon,
                                        color: Colors.pink,
                                        size: 40,
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(kBorderRadius),),
                                    );
                                  }).toList(),)
                            ],
                          ),
                        ),
                        expandedChild: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),)),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 30,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Hey...I\'m expanding!!!',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Expanded(
                                child: GridView.builder(
                                    itemCount: icons.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                    ),
                                    itemBuilder: (context, index) => Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(kBorderRadius),),
                                          child: Icon(
                                            icons[index],
                                            color: Colors.pink,
                                            size: 40,
                                          ),
                                        ),),
                              )
                            ],
                          ),
                        ),
                        minExtent: 150,
                        maxExtent: MediaQuery.of(context).size.height * 0.8,
                        backgroundWidget: Container(color: Colors.transparent),
                        blurBackground: true,
                      ),
                    )*/
