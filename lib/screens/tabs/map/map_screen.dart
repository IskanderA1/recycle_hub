import 'package:flutter/material.dart';
import 'package:recycle_hub/bloc/map_screen_blocs/marker_info_bloc.dart';
import 'package:recycle_hub/bloc/map_screen_blocs/markers_collection_bloc.dart';
import 'package:recycle_hub/elements/drawer.dart';
import 'package:recycle_hub/model/map_models.dart/marker.dart';
import 'package:recycle_hub/model/map_responses/markers_response.dart';
import 'package:recycle_hub/screens/tabs/map/filter_detail_screen.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bottom_sheet/bottom_sheet.dart';

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
        drawer: customDrawer);
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
    target: LatLng(55.7887, 49.1221),
    zoom: 12.5,
  );

  return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: StreamBuilder<MarkersCollectionResponse>(
        stream: markersCollectionBloc.stream,
        initialData: markersCollectionBloc.defaultItem,
        builder: (context, AsyncSnapshot<MarkersCollectionResponse> snapshot) {
          if (snapshot.data is MarkerCollectionResponseWithError ||
              snapshot.data is MarkerCollectionResponseLoading) {
            return GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                markers: {});
          }
          print("Список получен");
          return GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              markers: Set<Marker>.from(
                  snapshot.data.markers.markers.map((marker) => new Marker(
                        markerId: MarkerId(marker.id),
                        //anchor: Offset(5, 5),
                        consumeTapEvents: true,

                        /*Цвет можно поменять здесь */
                        icon: BitmapDescriptor.defaultMarkerWithHue(4),
                        onTap: () {
                          showStickyFlexibleBottomSheet(
                              initHeight: 0.4,
                              minHeight: 0.40,
                              maxHeight: 0.85,
                              context: context,
                              headerHeight: 50,
                              headerBuilder: _buildHeader,
                              builder: (context, offset) {
                                return SliverChildListDelegate(<Widget>[
                                  BuildBody(marker: marker),
                                ]);
                              },
                              anchors: [0.0, 0.4, 0.85]);
                        },
                        position: LatLng(marker.coords.lat, marker.coords.lng),
                      ))));
        }),
  );
}

class BuildBody extends StatefulWidget {
  final CustMarker marker;
  BuildBody({this.marker});
  @override
  _BuildBodyState createState() => _BuildBodyState();
}

class _BuildBodyState extends State<BuildBody> {
  int _selectedInd = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      //height: MediaQuery.of(context).size.height * 0.85,
      height: 1400,
      child: SafeArea(
        child: PreferredSize(
          preferredSize: null,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.marker.name,
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    )),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedInd = 0;
                            });
                            markerInfoFeedBloc.pickEvent(Mode.INFO);
                          },
                          child: Text(
                            "ИНФО",
                            style: TextStyle(
                                fontSize: 24,
                                color: _selectedInd == 0
                                    ? Color(0xFF249507)
                                    : Color(0xFF000000)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedInd = 1;
                            });
                            markerInfoFeedBloc.pickEvent(Mode.FEEFBACK);
                          },
                          child: Text(
                            "ОЗЫВЫ",
                            style: TextStyle(
                                fontSize: 24,
                                color: _selectedInd == 1
                                    ? Color(0xFF249507)
                                    : Color(0xFF000000)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                StreamBuilder(
                  stream: markerInfoFeedBloc.stream,
                  initialData: markerInfoFeedBloc.defaultItem,
                  builder: (context, AsyncSnapshot<Mode> snapshot) {
                    if (snapshot.data == Mode.INFO) {
                      return Column(
                        children: [Text("Информация")],
                      );
                    } else {
                      return Column(
                        children: [Text("Отзывы")],
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildHeader(BuildContext context, double bottomSheetOffset) {
  return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(bottomSheetOffset == 0.85 ? 0 : 40),
          topRight: Radius.circular(bottomSheetOffset == 0.85 ? 0 : 40),
        ),
      ),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(
          Icons.drag_handle,
          color: Colors.black54,
        ),
      ]));
}

/*Widget _buildFlexibleBottomSheet(
    BuildContext context, double bottomSheetOffset) {
  return SafeArea(
    child: Material(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35), topRight: Radius.circular(35)),
      child: Container(
        child: Column(
          children: [
            Icon(
              Icons.drag_handle,
              color: Colors.black26,
            ),
            DefaultTabController(
              initialIndex: 0,
              length: 2,
              child: Scaffold(
                body: Column(children: [
                  Container(
                    child: PreferredSize(
                      preferredSize:
                          Size(MediaQuery.of(context).size.width, 200),
                      child: TabBar(
                        tabs: [
                          Tab(
                            child: Text("ИНФО"),
                          ),
                          Tab(
                            child: Text("ОТЗЫВЫ"),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(children: [
                      Text("Some text"),
                      Text("Some text"),
                    ]),
                  )
                ]),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}*/

/*DefaultTabController tabController(ScrollController scrollController) {
  return DefaultTabController(
    length: 2,
    child: Scaffold(
      appBar: AppBar(
        title: Icon(Icons.drag_handle),
        centerTitle: true,
        bottom: TabBar(
          tabs: [
            Tab(
              child: Text("ИНФО"),
            ),
            Tab(
              child: Text("ОТЗЫВЫ"),
            )
          ],
        ),
      ),
      body: TabBarView(children: [
        SingleChildScrollView(
            controller: scrollController,
            child: Center(
                child: Column(
              children: [
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
                Text("Some text"),
              ],
            ))),
        Column(
          children: [
            Text("Some text"),
            Text("Some text"),
            Text("Some text"),
            Text("Some text"),
            Text("Some text"),
          ],
        )
      ]),
    ),
  );
}*/
