import 'package:flutter/material.dart';
import 'package:recycle_hub/elements/news_list.dart';
import 'package:recycle_hub/style/theme.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          title: Text(
            'Новости',
            style: TextStyle(
                color: kColorWhite,
                fontSize: 18,
                fontFamily: 'GillroyMedium',
                fontWeight: FontWeight.bold),
          ),
        ),
        body: NewsList(
          onlyAdvices: false,
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        ),
      ),
    );
  }
}
