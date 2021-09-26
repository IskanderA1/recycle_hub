import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/api/services/news_service.dart';
import 'package:recycle_hub/bloc/eco_guide_cubit/eco_guide_cubit_cubit.dart';
import 'package:recycle_hub/elements/news_list.dart';
import 'package:recycle_hub/icons/app_bar_icons_icons.dart';
import 'package:recycle_hub/model/news.dart';
import 'package:recycle_hub/elements/news_container.dart';
import 'package:recycle_hub/style/theme.dart';

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
          icon: Icon(
            AppBarIcons.back,
            color: kColorWhite,
            size: 18,
          ),
          onPressed: () {
            GetIt.I.get<EcoGuideCubit>().goBack();
          },
        ),
      ),
      body: NewsList(
        onlyAdvices: true,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        margin: const EdgeInsets.only(
          bottom: 80,
        ),
      ),
    );
  }
}
