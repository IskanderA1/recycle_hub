import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:recycle_hub/bloc/garb_collection_type_bloc.dart';
import 'package:recycle_hub/bloc/map_screen_blocs/accept_types_collection_bloc.dart';
import 'package:recycle_hub/bloc/marker_work_mode_bloc.dart';
import 'package:recycle_hub/model/map_responses/accept_types_collection_response.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/filter_card_widget.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/loader_widget.dart';
import 'package:recycle_hub/style/theme.dart';

GarbageCollectionTypeBloc garbageCollBloc = GarbageCollectionTypeBloc();
MarkerWorkModeBloc markerWorkModeBloc = MarkerWorkModeBloc();

class MapFilterDetailScreen extends StatefulWidget {
  @override
  _MapFilterDetailScreenState createState() => _MapFilterDetailScreenState();
}

class _MapFilterDetailScreenState extends State<MapFilterDetailScreen> {
  final TextEditingController _searchController = TextEditingController();
  Size size;

  @override
  void initState() {
    acceptTypesCollectionBloc.loadAcceptTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          backgroundColor: Color(0xFFFFFFFF),
          appBar: AppBar(
            title: Text("Фильтр"),
            centerTitle: true,
          ),
          body: Container(
            color: Color(0xFFFFFFFF),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: TextField(
                      controller: _searchController,
                      decoration: inputDecorWidget()),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: _garbCollectTypeWidget(),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: _markerModeCheck(),
                ),
                Expanded(
                  child: Container(
                    child: StreamBuilder(
                      stream: acceptTypesCollectionBloc.stream,
                      initialData: acceptTypesCollectionBloc.defaultItem,
                      builder: (BuildContext context,
                          AsyncSnapshot<AcceptTypesCollectionResponse>
                              snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data
                              is AcceptTypesCollectionResponseLoading) {
                            return LoaderWidget();
                          } else if (snapshot.data
                              is AcceptTypesCollectionResponseWithError) {
                            return Align(
                              alignment: Alignment.center,
                              child: Text(snapshot.data.error),
                            );
                          } else if (snapshot.data
                              is AcceptTypesCollectionResponseOk) {
                            double _size = MediaQuery.of(context).size.width;
                            return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 5,
                                      childAspectRatio: 5 / 4,
                                      crossAxisCount: 2),
                              itemCount:
                                  snapshot.data.acceptTypes.acceptTypes.length,
                              itemBuilder: (context, index) {
                                return FilterCardWidget(
                                    acceptType: snapshot
                                        .data.acceptTypes.acceptTypes[index],
                                    size: _size);
                              },
                            );
                          }
                        } else {
                          return Center(
                            child: Text(snapshot.error),
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {},
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 60,
                          maxWidth: 350,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: kColorGreen,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "Применить",
                              style:
                                  TextStyle(color: kColorWhite, fontSize: 28),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  _markerModeCheck() {
    return StreamBuilder<Object>(
        stream: markerWorkModeBloc.stream,
        initialData: markerWorkModeBloc.defaultItem,
        builder: (context, snapshot) {
          return Container(
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Color(0xFF62C848), width: 1.5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => markerWorkModeBloc.pickEvent(MODE.PAID),
                      child: Container(
                        color: snapshot.data == MODE.PAID
                            ? Color(0xFF62C848)
                            : Color(0xFFFFFFFF),
                        padding: EdgeInsets.zero,
                        alignment: Alignment.center,
                        child: AutoSizeText("Платный приём",
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: snapshot.data == MODE.PAID
                                    ? Color(0xFFFFFFFF)
                                    : Color(0xFF62C848))),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    width: 1,
                    color: Color(0xFFFF62C848),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => markerWorkModeBloc.pickEvent(MODE.FREE),
                      child: Container(
                        color: snapshot.data == MODE.FREE
                            ? Color(0xFF62C848)
                            : Color(0xFFFFFFFF),
                        //alignment: Alignment.center,
                        padding: EdgeInsets.zero,
                        child: Align(
                          alignment: Alignment.center,
                          child: AutoSizeText("Бесплатный приём",
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: snapshot.data == MODE.FREE
                                      ? Color(0xFFFFFFFF)
                                      : Color(0xFF62C848))),
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    width: 1,
                    color: Color(0xFFFF62C848),
                  ),
                  /*Expanded(
                    child: GestureDetector(
                      onTap: () => markerWorkModeBloc.pickEvent(MODE.ROUND),
                      child: Container(
                        color: snapshot.data == MODE.ROUND
                            ? Color(0xFF62C848)
                            : Color(0xFFFFFFFF),
                        alignment: Alignment.center,
                        child: AutoSizeText("Круглосуточно",
                            softWrap: true,
                            style: TextStyle(
                                color: snapshot.data == MODE.ROUND
                                    ? Color(0xFFFFFFFF)
                                    : Color(0xFF62C848))),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    width: 1,
                    color: Color(0xFFFF62C848),
                  ),*/
                  Expanded(
                    child: GestureDetector(
                      onTap: () => markerWorkModeBloc.pickEvent(MODE.PARTNERS),
                      child: Container(
                        color: snapshot.data == MODE.PARTNERS
                            ? Color(0xFF62C848)
                            : Color(0xFFFFFFFF),
                        alignment: Alignment.center,
                        child: AutoSizeText("Партнёры",
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: snapshot.data == MODE.PARTNERS
                                    ? Color(0xFFFFFFFF)
                                    : Color(0xFF62C848))),
                      ),
                    ),
                  )
                ],
              ));
        });
  }

  _garbCollectTypeWidget() {
    return StreamBuilder(
      stream: garbageCollBloc.stream,
      initialData: garbageCollBloc.defaultItem,
      builder: (ctx, AsyncSnapshot<GCOLLTYPE> snapshot) {
        return Container(
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: Color(0xFF62C848), width: 1.5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => garbageCollBloc.pickEvent(GCOLLTYPE.RECYCLING),
                  child: Container(
                      color: snapshot.data == GCOLLTYPE.RECYCLING
                          ? Color(0xFF62C848)
                          : Color(0xFFFFFFFF),
                      padding: EdgeInsets.zero,
                      alignment: Alignment.center,
                      child: Text(
                        "Переработка",
                        style: TextStyle(
                          color: snapshot.data == GCOLLTYPE.RECYCLING
                              ? Color(0xFFFFFFFF)
                              : Color(0xFF62C848),
                        ),
                      )),
                ),
              ),
              VerticalDivider(
                width: 1,
                color: Color(0xFFFF62C848),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => garbageCollBloc.pickEvent(GCOLLTYPE.UTILISATION),
                  child: Container(
                      color: snapshot.data == GCOLLTYPE.UTILISATION
                          ? Color(0xFF62C848)
                          : Color(0xFFFFFFFF),
                      padding: EdgeInsets.zero,
                      alignment: Alignment.center,
                      child: Text(
                        "Утилизация",
                        style: TextStyle(
                          color: snapshot.data == GCOLLTYPE.UTILISATION
                              ? Color(0xFFFFFFFF)
                              : Color(0xFF62C848),
                        ),
                      )),
                ),
              ),
              VerticalDivider(
                width: 1,
                color: Color(0xFFFF62C848),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => garbageCollBloc.pickEvent(GCOLLTYPE.BENEFIT),
                  child: Container(
                      color: snapshot.data == GCOLLTYPE.BENEFIT
                          ? Color(0xFF62C848)
                          : Color(0xFFFFFFFF),
                      padding: EdgeInsets.zero,
                      alignment: Alignment.center,
                      child: Text(
                        "Благо",
                        style: TextStyle(
                          color: snapshot.data == GCOLLTYPE.BENEFIT
                              ? Color(0xFFFFFFFF)
                              : Color(0xFF62C848),
                        ),
                      )),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  InputDecoration inputDecorWidget() {
    return InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: Color(0xFF62C848),
          size: 40,
        ),
        hintText: "Что вы хотите сдать?",
        hintStyle: TextStyle(color: Color(0xFF62C848), fontSize: 16.0),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            borderSide: BorderSide(color: Color(0xFF62C848), width: 2.5)),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF62C848), width: 2.5)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF62C848), width: 2.5)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF62C848), width: 2.5)));
  }
}
