import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:recycle_hub/bloc/profile_bloc/profile_bloc.dart';
import 'package:recycle_hub/bloc/profile_bloc/store_bloc.dart';
import 'package:recycle_hub/style/theme.dart';

class StoreScreen extends StatefulWidget {
  final Function onBackCall;
  const StoreScreen({
    Key key,
    @required this.onBackCall,
  }) : super(key: key);
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  int _selected = 0;

  GridView _goodsGridView;

  @override
  void initState() {
    _goodsGridView = GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      children: [
        Container(
          decoration: BoxDecoration(
            color: kColorWhite,
            borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          child: Column(
            children: [
              Icon(
                Icons.access_alarm_rounded,
                size: 50,
                color: kColorGreyDark,
              ),
              SizedBox(height: 5,),
              Text("Название товара", style: TextStyle(
                color: kColorBlack,
                fontFamily: 'GillroyMeduim',
                fontSize: 14,
              ),),
              SizedBox(height: 5,),
              Text("400 гр", style: TextStyle(
                color: const Color(0xFF8B8B97),
                fontFamily: 'GillroyMeduim',
                fontSize: 14,
              ),),
              SizedBox(height:5),
              Text("Название товара", style: TextStyle(
                color: kColorBlack,
                fontFamily: 'GillroyMeduim',
                fontSize: 14,
                fontWeight: FontWeight.bold
              ),)
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: kColorWhite,
            borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          child: Column(
            children: [
              Icon(
                Icons.access_alarm_rounded,
                size: 50,
                color: kColorGreyDark,
              ),
              SizedBox(height: 5,),
              Text("Название товара", style: TextStyle(
                color: kColorBlack,
                fontFamily: 'GillroyMeduim',
                fontSize: 14,
              ),),
              SizedBox(height: 5,),
              Text("400 гр", style: TextStyle(
                color: const Color(0xFF8B8B97),
                fontFamily: 'GillroyMeduim',
                fontSize: 14,
              ),),
              SizedBox(height:5),
              Text("Название товара", style: TextStyle(
                color: kColorBlack,
                fontFamily: 'GillroyMeduim',
                fontSize: 14,
                fontWeight: FontWeight.bold
              ),)
            ],
          ),
        ),Container(
          decoration: BoxDecoration(
            color: kColorWhite,
            borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          child: Column(
            children: [
              Icon(
                Icons.access_alarm_rounded,
                size: 50,
                color: kColorGreyDark,
              ),
              SizedBox(height: 5,),
              Text("Название товара", style: TextStyle(
                color: kColorBlack,
                fontFamily: 'GillroyMeduim',
                fontSize: 14,
              ),),
              SizedBox(height: 5,),
              Text("400 гр", style: TextStyle(
                color: const Color(0xFF8B8B97),
                fontFamily: 'GillroyMeduim',
                fontSize: 14,
              ),),
              SizedBox(height:5),
              Text("Название товара", style: TextStyle(
                color: kColorBlack,
                fontFamily: 'GillroyMeduim',
                fontSize: 14,
                fontWeight: FontWeight.bold
              ),)
            ],
          ),
        )
      ],
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Магазин",
          style: TextStyle(
              color: kColorWhite,
              fontFamily: 'GillRoyMedium',
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: kColorWhite,
            size: 25,
          ),
          onPressed: () =>
              widget.onBackCall(),
        ),
      ),
      body: Container(
        color: const Color(0xFFF2F2F2),
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: ScreenUtil().screenHeight,
            width: ScreenUtil().screenWidth,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                        border: Border.all(color: kColorGreen, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        /*Expanded(
                          child: GestureDetector(
                            onTap: () {
                              storeTabBarBloc.mapEventToState(StoreStates.GOODS);
                              setState(() {
                                _selected = 0;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      _selected == 0 ? kColorGreen : kColorWhite,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      bottomLeft: Radius.circular(4))),
                              child: Center(
                                child: Text(
                                  "Товары",
                                  style: TextStyle(
                                    color: _selected == 0
                                        ? kColorWhite
                                        : kColorGreen,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        VerticalDivider(
                          color: kColorGreen,
                          width: 1,
                        ),*/
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              storeTabBarBloc
                                  .mapEventToState(StoreStates.SERVICES);
                              setState(() {
                                _selected = 0;
                              });
                            },
                            child: Container(
                              color: _selected == 0 ? kColorGreen : kColorWhite,
                              child: Center(
                                child: Text(
                                  "Услуги",
                                  style: TextStyle(
                                    color: _selected == 0
                                        ? kColorWhite
                                        : kColorGreen,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        VerticalDivider(
                          color: kColorGreen,
                          width: 1,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              storeTabBarBloc.mapEventToState(StoreStates.TOEAT);
                              setState(() {
                                _selected = 1;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      _selected == 1 ? kColorGreen : kColorWhite,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(4),
                                      bottomRight: Radius.circular(4))),
                              child: Center(
                                child: Text(
                                  "Поесть",
                                  style: TextStyle(
                                    color: _selected == 1
                                        ? kColorWhite
                                        : kColorGreen,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 400,
                  child: StreamBuilder(
                    stream: storeTabBarBloc.subject,
                    initialData: storeTabBarBloc.defaultState,
                    builder: (BuildContext context, AsyncSnapshot<StoreStates> snapshot){
                      if(snapshot.hasData){
                        if(snapshot.data == StoreStates.TOEAT){
                          return Padding(
                            padding: EdgeInsets.all(15),
                            child: _goodsGridView,
                          );
                        }
                        return Container();
                      }else{
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
