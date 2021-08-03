import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycle_hub/bloc/map_screen_blocs/feedbacks_bloc.dart';
import 'package:recycle_hub/model/map_models.dart/accept_types.dart';
import 'package:recycle_hub/model/map_models.dart/feedbacker_model.dart';
import 'package:recycle_hub/model/map_models.dart/marker.dart';
import 'package:recycle_hub/model/map_responses/feedbacks_collection_response.dart';
import 'package:recycle_hub/screens/tabs/map/methods/pre_information_container.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/loader_widget.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/report_button.dart';
import 'package:recycle_hub/style/theme.dart';
import 'package:flutter_star_rating/flutter_star_rating.dart';
import 'working_days_widget.dart';

///Отрисовка body в bottomsheet
class BuildBody extends StatefulWidget {
  final double offset;
  final CustMarker marker;
  final List<FilterType> filters;
  BuildBody({this.marker, this.offset, @required this.filters});
  @override
  _BuildBodyState createState() => _BuildBodyState();
}

class _BuildBodyState extends State<BuildBody> {
  Size _size;
  int _selected = 0;

  @override
  void initState() {
    feedBacksBloc.loadFeedBacks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            /* Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                child: Text(
                  "Рейтинг",
                  style: TextStyle(color: kColorGreen),
                ),
              ),
            ), */
            /*  Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 5, 16, 10),
                  child: Text(
                    widget.marker.name,
                    style: TextStyle(
                        color: kColorBlack,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                )), */
            /* buildTabBar(), */
            //streamBuilderMethod(_size)
            NewWidget(
                marker: widget.marker, size: _size, filters: widget.filters)
          ],
        ),
      ),
    );
  }

  /* Container buildTabBar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                markerInfoFeedBloc.pickEvent(Mode.INFO);
                _selected = 0;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: _selected == 0 ? kColorGreen : kColorWhite,
                          width: 5,
                          style: BorderStyle.solid))),
              child: Text("ИНФО",
                  style: TextStyle(
                    color: _selected == 0 ? kColorGreen : kColorBlack,
                    fontSize: 18,
                    fontFamily: _selected == 0 ? 'Gilroy' : 'GilroyMedium',
                  ),
                  textAlign: TextAlign.end),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _selected = 1;
                markerInfoFeedBloc.pickEvent(Mode.FEEFBACK);
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: _selected == 1 ? kColorGreen : kColorWhite,
                          width: 5,
                          style: BorderStyle.solid))),
              child: Text(
                "ОТЗЫВЫ",
                style: TextStyle(
                  color: _selected == 1 ? kColorGreen : kColorBlack,
                  fontFamily: _selected == 1 ? 'Gilroy' : 'GilroyMedium',
                  fontSize: 18,
                  //fontWeight: FontWeight.normal
                  //fontStyle: FontStyle.italic
                ),
                textAlign: TextAlign.end,
              ),
            ),
          )
        ],
      ),
    );
  } */

  /* StreamBuilder<Mode> streamBuilderMethod(Size size) {
    return StreamBuilder(
      stream: markerInfoFeedBloc.stream,
      initialData: markerInfoFeedBloc.defaultItem,
      builder: (context, AsyncSnapshot<Mode> snapshot) {
        if (snapshot.data == Mode.INFO) {
          return NewWidget(
            marker: widget.marker,
            size: size,
          );
        } else {
          return FeedBacksView();
        }
      },
    );
  } */
}

class NewWidget extends StatefulWidget {
  const NewWidget(
      {Key key,
      @required this.marker,
      @required this.size,
      @required this.filters})
      : super(key: key);

  final CustMarker marker;
  final Size size;
  final List<FilterType> filters;

  @override
  _NewWidgetState createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  //https://i04.fotocdn.net/s126/e69aeb6043a52824/public_pin_l/2868756737.jpg
  List<Widget> _pictureList;
  Size _size;
  @override
  void initState() {
    _pictureList = widget.marker.externalImages
        .map((img) => CachedNetworkImage(
              placeholder: (BuildContext context, url) => LoaderWidget(),
              imageUrl: "$img",
              errorWidget: (BuildContext context, url, error) =>
                  Icon(Icons.error),
            ))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Column(
      children: [
        myDivider(),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
          child: WorkingDaysWidget(
            workingTime: widget.marker.workTime,
            wColor: kColorBlack,
            backColor: kColorWhite,
            hasSelection: true,
            fontSize: 14,
            size: Size(_size.width - 50, _size.height / 5.5),
          ),
        ),

        myDivider(),

        ///Карты того, что принимают
        /* Padding(
          padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
          child: Column(
            children: [
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.recycle,
                    size: 30,
                    color: Color(0xFF8D8D8D),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Принимают:",
                    style: TextStyle(
                        color: kColorBlack,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'GilroyMedium',
                        fontSize: 16),
                  ),
                ],
              ),
              /*GridView.count(
                childAspectRatio: 5 / 4,
                children: _list,
                crossAxisCount: 2,
                shrinkWrap: true,
                controller: ScrollController(keepScrollOffset: false),
              )*/
            ],
          ),
        ), */
        /* Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 8),
          child: Row(
            children: [
              FaIcon(
                FontAwesomeIcons.recycle,
                size: 30,
                color: Color(0xFF8D8D8D),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Text(
                  "Принимают на переработку:",
                  style: TextStyle(
                      color: kColorBlack,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'GilroyMedium',
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: FilterTypesContainer(
            filters: widget.filters,
            gridSize: 30,
          ),
        ),
        myDivider(), */
        Padding(
            padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
            child: Row(
              children: [
                Icon(
                  Icons.copyright,
                  size: 30,
                  color: widget.marker.paybackType == "partner"
                      ? kColorGreen
                      : kColorPink,
                ),
                SizedBox(
                  width: 15,
                ),
                AutoSizeText(
                  widget.marker.paybackType == "partner"
                      ? "Выдает ЭкоКоины"
                      : "Не выдает ЭкоКоинов",
                  style: TextStyle(
                      color: widget.marker.paybackType == "partner"
                          ? kColorGreen
                          : kColorPink,
                      fontFamily: 'GilroyMedium',
                      fontSize: 18),
                )
              ],
            )),
        myDivider(),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
          child: Row(
            children: [
              FaIcon(
                FontAwesomeIcons.phoneAlt,
                size: 30,
                color: Color(0xFF8D8D8D),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      widget.marker.contacts[0] != null
                          ? widget.marker.contacts[0]
                          : '--',
                      style: TextStyle(
                          color: kColorGreen,
                          fontFamily: 'Gilroy',
                          fontSize: 16),
                    ),
                    AutoSizeText(
                      'Администратор',
                      style: TextStyle(
                          color: kColorBlack,
                          fontFamily: 'GilroyMedium',
                          fontSize: 16),
                    ),
                    Divider(
                      color: Color(0xF2707070),
                      indent: 10,
                      endIndent: 15,
                      thickness: 0.6,
                      height: 15,
                    ),
                    AutoSizeText(
                      widget.marker.contacts[0] != null
                          ? widget.marker.contacts[0]
                          : '--',
                      style: TextStyle(
                          color: kColorGreen,
                          fontFamily: 'Gilroy',
                          fontSize: 16),
                    ),
                    AutoSizeText(
                      'Партнер',
                      style: TextStyle(
                          color: kColorBlack,
                          fontFamily: 'GilroyMedium',
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        myDivider(),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on,
                size: 30,
                color: Color(0xFF8D8D8D),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.marker.address,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                          color: kColorBlack,
                          fontFamily: 'GilroyMedium',
                          fontSize: 16),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: AutoSizeText(
                        "(Построить маршрут)",
                        style: TextStyle(
                            color: kColorGreen,
                            fontFamily: 'Gilroy',
                            fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),

        myDivider(),
        Padding(
          padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.comment,
                        size: 30,
                        color: Color(0xFF8D8D8D),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      AutoSizeText(
                        "Примечание:",
                        style: TextStyle(
                            color: kColorBlack,
                            fontFamily: 'GilroyMedium',
                            fontSize: 16),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Text(
                    widget.marker.description ?? '-',
                    style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 16,
                        color: kColorBlack.withOpacity(0.5),
                        //letterSpacing: 1,
                        fontWeight: FontWeight.normal),
                  ),
                )
              ],
            ),
          ),
        ),
        myDivider(),
        GridView.count(
          crossAxisCount: 1,
          children: _pictureList,
          shrinkWrap: true,
          controller: ScrollController(keepScrollOffset: false),
        ),
        ReportButtonWidget(widget.marker.id),
      ],
    );
  }
}

Divider myDivider() {
  return Divider(
    color: Color(0xF2707070),
    indent: 15,
    endIndent: 15,
    thickness: 0.6,
  );
}

class FeedBacksView extends StatefulWidget {
  @override
  _FeedBacksViewState createState() => _FeedBacksViewState();
}

class _FeedBacksViewState extends State<FeedBacksView> {
  double _rating = 3.3;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        myDivider(),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
          child: StarRating(
            rating: _rating,
            starConfig: StarConfig(
                emptyColor: kColorWhite,
                fillColor: kColorGreen,
                strokeColor: kColorGreen,
                strokeWidth: 3),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
          child: Text(
            "Были здесь? Напишите отзыв",
            style: TextStyle(
                fontFamily: 'Gilroy',
                fontSize: 16,
                color: kColorBlack,
                //letterSpacing: 1,
                fontWeight: FontWeight.normal),
          ),
        ),
        myDivider(),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  children: [
                    Flexible(
                      child: AutoSizeText(
                        "$_rating",
                        style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 24,
                            color: kColorBlack,
                            //letterSpacing: 1,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 12,
                      //width: 30,
                      child: StarRating(
                        rating: _rating,
                        spaceBetween: 0,
                        starConfig: StarConfig(
                            emptyColor: kColorWhite,
                            fillColor: kColorBlack,
                            strokeColor: kColorBlack,
                            strokeWidth: 1,
                            size: 20),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: AutoSizeText(
                  "7 отзывов",
                  style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 16,
                      color: kColorBlack,
                      //letterSpacing: 1,
                      fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
        ),
        myDivider(),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 500,
              child: FeedBacksWidget()),
        ),
      ],
    );
  }
}

class FeedBacksWidget extends StatelessWidget {
  const FeedBacksWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: feedBacksBloc.defaultItem,
      stream: feedBacksBloc.stream,
      builder: (BuildContext context,
          AsyncSnapshot<FeedBackCollectionResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data is FeedBackCollectionResponseLoading) {
            return LoaderWidget();
          } else if (snapshot.data is FeedBackCollectionResponseWithError) {
            return Center(
              child: Text(snapshot.data.error),
            );
          } else if (snapshot.data is FeedBackCollectionResponseOk) {
            return Container(
              //height: 100,
              //width: 100,
              child: ListView.separated(
                  itemCount: snapshot.data.feeds.feedBacks.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, index) {
                    return FeedBackWidget(
                        feedBackerModel: snapshot.data.feeds.feedBacks[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return myDivider();
                  }),
            );
          }
        }
        return LoaderWidget();
      },
    );
  }
}

class FeedBackWidget extends StatelessWidget {
  final FeedBackerModel feedBackerModel;
  const FeedBackWidget({Key key, this.feedBackerModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      width: MediaQuery.of(context).size.width,
      height: 150,
      color: kColorWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    child: CircleAvatar(
                        backgroundColor: kColorGreen,
                        radius: 25,
                        backgroundImage: NetworkImage(
                            "https://sun9-5.userapi.com/impg/wohCRUHC20q6LpsHmffdtIbGv8D09BES50E8tQ/ruLyYmMSm28.jpg?size=400x0&quality=90&sign=f780aeae3765b607e1f2b215b23e4ca4&c_uniq_tag=wSdUiZ1etvWpBKfl0tUvd1_30GB8lKDXlw8L2x1M3bQ&ava=1")),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        "${feedBackerModel.name} ${feedBackerModel.surname}",
                        style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 16,
                            color: kColorGreen,
                            //letterSpacing: 1,
                            fontWeight: FontWeight.normal),
                      ),
                      AutoSizeText(
                        "${feedBackerModel.hisFeedBacksCount} отзыва",
                        style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 12,
                            color: kColorGreyLight,
                            //letterSpacing: 1,
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                ],
              ),
              Container(
                child: StarRating(
                  rating: 3.4,
                  spaceBetween: 1,
                  starConfig: StarConfig(
                      emptyColor: kColorWhite,
                      fillColor: kColorGreen,
                      strokeColor: kColorGreen,
                      strokeWidth: 1,
                      size: 15),
                ),
              )
            ],
          ),
          Container(
            height: 50,
            child: Text(
              "${feedBackerModel.feedBack}",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 16,
                  color: kColorBlack,
                  //letterSpacing: 1,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                "${feedBackerModel.dateOfFeedBack}",
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 12,
                    color: kColorGreyDark,
                    //letterSpacing: 1,
                    fontWeight: FontWeight.normal),
              ),
              Row(
                children: [
                  Icon(
                    Icons.thumb_up_off_alt,
                    size: 25,
                    color: kColorGreyDark,
                  ),
                  AutoSizeText(
                    "${feedBackerModel.thumbsCount}",
                    style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 16,
                        color: kColorGreyDark,
                        //letterSpacing: 1,
                        fontWeight: FontWeight.normal),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
