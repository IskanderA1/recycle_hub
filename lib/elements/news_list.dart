import 'package:flutter/material.dart';
import 'package:recycle_hub/api/services/news_service.dart';
import 'package:recycle_hub/elements/news_container.dart';
import 'package:recycle_hub/model/news.dart';

class NewsList extends StatefulWidget {
  final bool onlyAdvices;
  final EdgeInsetsGeometry padding;
  NewsList(
      {this.onlyAdvices = false,
      this.padding = const EdgeInsets.fromLTRB(16, 16, 16, 80)});
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  List<News> newsList;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    newsList = NewsService().news;
    if (widget.onlyAdvices) {
      newsList = newsList.where((e) => e.isAdvice).toList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
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
    );
  }
}
