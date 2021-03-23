import 'dart:async';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_star_rating/flutter_star_rating.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
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
import '../../../bloc/map_screen_blocs/markers_collection_bloc.dart';
import '../../../model/map_models.dart/marker.dart';
import '../../../style/theme.dart';
import 'methods/header_builder.dart';
import 'methods/pre_information_container.dart';
import 'widgets/working_days_widget.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  CameraPosition cameraPosition;

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

  AppBar mapScreenAppBar() {
    return AppBar(
      title: Text(
        "RecycleHub",
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
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
  Future<String> getCurrentPosition() async {
    LocationData currentLocation;

    var location = new Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }
    setState(() {
      cameraPosition = CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 12,
      );
    });
    return "Ok";
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
  List<Widget> _list;
  ClusterManager<CustMarker> clusterManager;
  Iterable<ClusterItem> _items;
  Set<Marker> markers;
  StreamSubscription streamSubscription;

  @override
  void initState() {
    cameraPosition = widget.cameraPosition;
    markersCollectionBloc.loadMarkers(cameraPosition.target, cameraPosition.zoom);
    streamSubscription = markersCollectionBloc.stream.listen((event) {
      if(event is MarkersCollectionResponseOk){
        setState(()  {
           //markers = await _getMarkers(Cluster(event.markers.markers.map((markItem) => ClusterItem(LatLng(markItem.coords.lat, markItem.coords.lng), item: markItem))));
           _items = event.markers.markers.map((markItem) => ClusterItem(LatLng(markItem.coords.lat, markItem.coords.lng), item: markItem)).toList();
          _list = event.markers.markers.map((item) => MarkerCardWidget(
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
        });
        clusterManager.setItems(_items);
        //event.markers.markers.map((markItem) => ClusterItem(LatLng(markItem.coords.lat, markItem.coords.lng), item: markItem));
      }else{
        setState(() {
        _items = List<ClusterItem<CustMarker>>.empty();
        _list = List.empty();
        });
        clusterManager.setItems(_items);
      }
    },);
    //_currentLocation();
    //_ls = Hive.box('markers').get('markersList');
    //_items = _ls.map((markItem) => ClusterItem(LatLng(markItem.coords.lat, markItem.coords.lng), item: markItem)).toList();
    clusterManager = ClusterManager<CustMarker>(
      _items,
      _updateMarkers,
      markerBuilder: _markerBuilder,
      initialZoom: cameraPosition.zoom,
      stopClusteringZoom: 17.0,
      levels: [4, 6, 8, 10, 12, 14, 15, 16],
      extraPercent: 0.2,
    );
    super.initState();
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  void _updateMarkers(Set<Marker> markers) {
    print('Updated ${markers.length} markers');
    setState(() {
      this.markers = markers;
    });
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
        child: GoogleMap(
                  mapType: _currentMapType,
                  initialCameraPosition: cameraPosition,
                  onCameraMove: clusterManager.onCameraMove,
                  onCameraIdle: clusterManager.updateMap,
                  onMapCreated: (GoogleMapController controller) {
                    if (!_controller.isCompleted) {
                      _controller.complete(controller);
                    }
                    clusterManager.setMapController(controller);
                  },
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  compassEnabled: false,
                  markers: markers)
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

  Future<Marker> Function(Cluster<CustMarker>) get _markerBuilder =>
      (cluster) async {
        return Marker(
          markerId: MarkerId(cluster.getId()),
          position: cluster.location,
          onTap: () {
            if(cluster.items.length == 1){
markerInfoFeedBloc.pickEvent(Mode.INFO);
                              showStickyFlexibleBottomSheet(
                                  initHeight: 0.45,
                                  minHeight: 0.45,
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
                                            offset: offset, marker: cluster.items.first),
                                        BuildBody(marker: cluster.items.first),
                                      ],
                                    );
                                  },
                                  anchors: [0.0, 0.45, 0.85]);
            }
          },
          icon: await _getMarkerBitmap(cluster.isMultiple ? 125 : 75,
              text: cluster.isMultiple ? cluster.count.toString() : null),
        );
      };

  Future<BitmapDescriptor> _getMarkerBitmap(int size, {String text}) async {
    if (kIsWeb) size = (size / 2).floor();

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = kColorGreen;
    final Paint paint2 = Paint()..color = Colors.white;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(
            fontSize: size / 3,
            color: Colors.white,
            fontWeight: FontWeight.normal),
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png) as ByteData;

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }

  void northSouth() async {
    GoogleMapController zController = await _controller.future;
    var currentZoomLevel = await zController.getZoomLevel();

    currentZoomLevel = currentZoomLevel;
    zController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: cameraPosition.target,
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
          target: cameraPosition.target,
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
          target: cameraPosition.target,
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
