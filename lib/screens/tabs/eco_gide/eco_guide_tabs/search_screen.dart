import 'package:flutter/material.dart';
import 'package:recycle_hub/bloc/eco_guide_blocs/eco_menu_bloc.dart';


class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
          title: Text("Поиск"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_sharp),
            onPressed: () {
              ecoMenu.backToMenu();
            },
          ),
        ),
        body: Container(
          child: Container(
            padding: EdgeInsets.only(left: 5, right: 5, top: 8),
            child: TextField(
              controller: _searchController,
              decoration: inputDecorWidget(),
            ),
          ),
        ),
      ),
    );
  }
}

InputDecoration inputDecorWidget() {
  return InputDecoration(
      prefixIcon: Icon(
        Icons.search,
        color: Color(0xFF62C848),
        size: 30,
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
