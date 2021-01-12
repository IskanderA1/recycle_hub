import 'package:flutter/material.dart';
import 'package:recycle_hub/bloc/garb_collection_type_bloc.dart';
import 'package:recycle_hub/bloc/marker_work_mode_bloc.dart';

GarbageCollectionTypeBloc garbageCollBloc = GarbageCollectionTypeBloc();
MarkerWorkModeBloc markerWorkModeBloc = MarkerWorkModeBloc();

class MapFilterDetailScreen extends StatefulWidget {
  @override
  _MapFilterDetailScreenState createState() => _MapFilterDetailScreenState();
}

class _MapFilterDetailScreenState extends State<MapFilterDetailScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text("Фильтр"),
            centerTitle: true,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
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
                  alignment: Alignment.center,
                  child: Text("Список"),
                ),
              )
            ],
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
                        child: Text("Платный приём",
                            softWrap: true,
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
                        alignment: Alignment.center,
                        child: Text("Бесплатный приём",
                            softWrap: true,
                            style: TextStyle(
                                color: snapshot.data == MODE.FREE
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
                      onTap: () => markerWorkModeBloc.pickEvent(MODE.ROUND),
                      child: Container(
                        color: snapshot.data == MODE.ROUND
                            ? Color(0xFF62C848)
                            : Color(0xFFFFFFFF),
                        alignment: Alignment.center,
                        child: Text("Круглосуточно",
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
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => markerWorkModeBloc.pickEvent(MODE.PARTNERS),
                      child: Container(
                        color: snapshot.data == MODE.PARTNERS
                            ? Color(0xFF62C848)
                            : Color(0xFFFFFFFF),
                        alignment: Alignment.center,
                        child: Text("Партнёры",
                            softWrap: true,
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
