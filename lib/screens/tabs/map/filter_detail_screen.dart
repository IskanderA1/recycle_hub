import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:recycle_hub/bloc/garb_collection_type_bloc.dart';
import 'package:recycle_hub/bloc/map_screen_blocs/accept_types_collection_bloc.dart';
import 'package:recycle_hub/bloc/map_screen_blocs/markers_collection_bloc.dart';
import 'package:recycle_hub/bloc/marker_work_mode_bloc.dart';
import 'package:recycle_hub/model/map_models.dart/accept_types_collection_model.dart';
import 'package:recycle_hub/model/map_models.dart/filter_model.dart';
import 'package:recycle_hub/model/map_responses/accept_types_collection_response.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/filter_card_widget.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/loader_widget.dart';
import 'package:recycle_hub/style/theme.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class MapFilterDetailScreen extends StatefulWidget {
  @override
  _MapFilterDetailScreenState createState() => _MapFilterDetailScreenState();
}

class _MapFilterDetailScreenState extends State<MapFilterDetailScreen> {
  final TextEditingController _searchController = TextEditingController();
  Size size;
  FilterModel currentFilterModel = FilterModel();
  AcceptTypesCollection acceptTypesCollection;
  List<FilterCardWidget> filterCards;
  GarbageCollectionTypeBloc garbageCollBloc = GarbageCollectionTypeBloc();
  MarkerWorkModeBloc markerWorkModeBloc = MarkerWorkModeBloc();
  /*GlobalKey<FilterCardWidgetState> _key =
      GlobalKey<FilterCardWidgetState>(debugLabel: "__myKey__");*/

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
          backgroundColor: kColorWhite,
          appBar: AppBar(
            title: Text("Фильтр"),
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                markersCollectionBloc.loadMarkers();
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back),
            ),
          ),
          body: Container(
            color: Color(0xFFFFFFFF),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: _searchController,
                        decoration: inputDecorWidget(),
                        cursorColor: kColorBlack,
                      ),
                      suggestionsCallback: (str) {
                        return acceptTypesCollection.getPatterns(str);
                      },
                      itemBuilder: (BuildContext context, suggestion) {
                        return ListTile(
                          title: Text(suggestion),
                        );
                      },
                      onSuggestionSelected: (String suggestion) {
                        selectCardByVarName(acceptTypesCollection
                            .getVarNameByKeyWord(suggestion));
                        currentFilterModel.filters.add(acceptTypesCollection
                            .getVarNameByKeyWord(suggestion));
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: _garbCollectTypeWidget(),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: _markerModeCheck(),
                ),
                Expanded(
                  child: Container(
                    child: StreamBuilder(
                      stream: acceptTypesCollectionBloc.stream,
                      //future: acceptTypesCollectionBloc.loadAcceptTypes(),
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
                            filterCards = List<FilterCardWidget>.from(snapshot
                                .data.acceptTypes.acceptTypes
                                .map((x) => FilterCardWidget(
                                      //key: _key,
                                      isSelected: false,
                                      acceptType: x,
                                      size: _size,
                                      onUp: rejectVarName,
                                      onpressed: injectNewVarName,
                                      tapable: true,
                                    )));
                            if (acceptTypesCollection == null) {
                              acceptTypesCollection = snapshot.data.acceptTypes;
                            }
                            return GridView.count(
                              /*gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 5,
                                      childAspectRatio: 5 / 4,
                                      crossAxisCount: 2),
                              itemCount:
                                  snapshot.data.acceptTypes.acceptTypes.length,*/
                              crossAxisCount: 2,
                              childAspectRatio: 5 / 4,
                              children: filterCards,
                              /*itemBuilder: (context, index) {
                                return FilterCardWidget(
                                  acceptType: snapshot
                                      .data.acceptTypes.acceptTypes[index],
                                  size: _size,
                                  onpressed: injectNewVarName,
                                  onUp: rejectVarName,
                                  tapable: true,
                                );
                              },*/
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
                      onTap: () {
                        acceptFilters();
                        Navigator.pop(context);
                      },
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

  selectCardByVarName(String varName) {
    for (int i = 0; i < filterCards.length; i++) {
      if (filterCards[i].acceptType.varName == varName) {
        setState(() {
          //_key.currentState.pressFunc();
        });
      }
    }
  }

  injectNewVarName(String suggestion) {
    this.currentFilterModel.filters.add(suggestion);
  }

  rejectVarName(String suggestion) {
    this.currentFilterModel.filters.remove(suggestion);
  }

  void acceptFilters() {
    print("///////////////////");
    for (int i = 0; i < currentFilterModel.filters.length; i++) {
      print(currentFilterModel.filters[i]);
    }
    print("///////////////////");
    markersCollectionBloc.filterMarkers(currentFilterModel);
  }

  _markerModeCheck() {
    return StreamBuilder<Object>(
        stream: markerWorkModeBloc.stream,
        //initialData: markerWorkModeBloc.defaultItem,
        builder: (context, snapshot) {
          return Container(
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(color: Color(0xFF62C848), width: 1.5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        currentFilterModel.paybackType = "paid";
                        markerWorkModeBloc.pickEvent(MODE.PAID);
                      },
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
                      onTap: () {
                        currentFilterModel.paybackType = "free";
                        markerWorkModeBloc.pickEvent(MODE.FREE);
                      },
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
                      onTap: () {
                        currentFilterModel.paybackType = "partner";
                        markerWorkModeBloc.pickEvent(MODE.PARTNERS);
                      },
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
      //initialData: garbageCollBloc.defaultItem,
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
                  onTap: () {
                    currentFilterModel.recType = "recycle";
                    garbageCollBloc.pickEvent(GCOLLTYPE.RECYCLING);
                  },
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
                  onTap: () {
                    currentFilterModel.recType = "utilisation";
                    garbageCollBloc.pickEvent(GCOLLTYPE.UTILISATION);
                  },
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
                  onTap: () {
                    currentFilterModel.recType = "charity";
                    garbageCollBloc.pickEvent(GCOLLTYPE.BENEFIT);
                  },
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
        focusColor: Color(0xFFF2F2F2),
        fillColor: Color(0xFFF2F2F2),
        hoverColor: Color(0xFFF2F2F2),
        suffixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 15, 5),
          child: Icon(
            Icons.search,
            color: Color(0xFF616161),
            size: 35,
          ),
        ),
        hintText: "Что вы хотите сдать?",
        hintStyle: TextStyle(
          color: Color(0xFF616161).withOpacity(0.6),
          fontSize: 16.0,
        ),
        prefix: SizedBox(width: 15),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide.none));
  }
}
