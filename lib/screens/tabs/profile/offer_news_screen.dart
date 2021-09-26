import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/bloc/cubit/profile_menu_cubit.dart';
import 'package:recycle_hub/elements/news_list.dart';
import 'package:recycle_hub/elements/offer_news_container.dart';
import 'package:recycle_hub/icons/app_bar_icons_icons.dart';
import 'package:recycle_hub/style/theme.dart';

class OfferNewsScreen extends StatefulWidget {
  @override
  _OfferNewsScreenState createState() => _OfferNewsScreenState();
}

class _OfferNewsScreenState extends State<OfferNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(
                  AppBarIcons.back,
                  color: kColorWhite,
                  size: 18,
                ),
                onPressed: () => GetIt.I.get<ProfileMenuCubit>().goBack()),
            title: Text(
              "Новости",
              /* style: TextStyle(color: kColorWhite, fontSize: 18, fontFamily: 'GillroyMedium', fontWeight: FontWeight.bold), */
            ),
            bottom: TabBar(
              indicatorColor: kColorWhite,
              indicatorWeight: 4,
              tabs: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Новость',
                    style: TextStyle(color: kColorWhite, fontSize: 18, fontFamily: 'Gilroy', fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Новость',
                    style: TextStyle(color: kColorWhite, fontSize: 18, fontFamily: 'Gilroy', fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [OfferNewsContainer(), NewsList()],
          )),
    );
  }
}
