import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/api/services/news_service.dart';
import 'package:recycle_hub/bloc/eco_guide_cubit/eco_guide_cubit_cubit.dart';
import 'package:recycle_hub/elements/news_list.dart';
import 'package:recycle_hub/model/news.dart';
import 'package:recycle_hub/elements/news_container.dart';

class AdviceScreen extends StatefulWidget {
  @override
  _AdviceScreenState createState() => _AdviceScreenState();
}

class _AdviceScreenState extends State<AdviceScreen> {
  List<News> newsList;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    newsList = NewsService().news;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Советы для экономии"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_sharp),
            onPressed: () {
              GetIt.I.get<EcoGuideCubit>().goBack();
            },
          ),
        ),
        body: NewsList(
          onlyAdvices: true,
        )
        /* ListView(
        shrinkWrap: true,
        controller: _scrollController,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 5),
            margin: EdgeInsets.only(bottom: 5),
            child: Column(
              children: [
                /* Container(
                  child: Wrap(
                    spacing: 5,
                    children: [
                      Container(
                        child: RaisedButton(
                          elevation: 0,
                          color: Colors.grey[300],
                          textColor: Colors.black,
                          disabledTextColor: Colors.white,
                          highlightColor: Color(0xFF249507),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () {},
                          child: Text("Все"),
                        ),
                      ),
                      Container(
                        child: RaisedButton(
                          elevation: 0,
                          color: Colors.grey[300],
                          highlightColor: Color(0xFF249507),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () {},
                          child: Text("Утилизация"),
                        ),
                      ),
                      Container(
                        child: RaisedButton(
                          elevation: 0,
                          color: Colors.grey[300],
                          highlightColor: Color(0xFF249507),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () {},
                          child: Text("Экономика"),
                        ),
                      ),
                      Container(
                        child: RaisedButton(
                          elevation: 0,
                          color: Colors.grey[300],
                          highlightColor: Color(0xFF249507),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () {},
                          child: Text("Электричество"),
                        ),
                      ),
                      Container(
                        child: RaisedButton(
                          elevation: 0,
                          color: Colors.grey[300],
                          highlightColor: Color(0xFF249507),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () {},
                          child: Text("Экономика"),
                        ),
                      ),
                    ],
                  ),
                ), */
                Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: newsList.length,
                    controller: _scrollController,
                    itemBuilder: (context, i) {
                      return NewsContainer(
                        news: newsList[i],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ), */
        );
  }
}
