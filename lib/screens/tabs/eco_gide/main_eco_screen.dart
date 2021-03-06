import 'package:flutter/material.dart';
import 'package:recycle_hub/bloc/eco_guide_blocs/eco_menu_bloc.dart';
import 'package:recycle_hub/screens/tabs/eco_gide/eco_guide_tabs/advice_screen.dart';
import 'package:recycle_hub/screens/tabs/eco_gide/eco_guide_tabs/container_screen.dart';
import 'package:recycle_hub/screens/tabs/eco_gide/eco_guide_tabs/do_test_screen.dart';
import 'package:recycle_hub/screens/tabs/eco_gide/eco_guide_tabs/main_eco_guide_screen.dart';
import 'package:recycle_hub/screens/tabs/eco_gide/eco_guide_tabs/reference_book_screen.dart';

class EcoMainScreen extends StatefulWidget {
  @override
  _EcoMainScreenState createState() => _EcoMainScreenState();
}

class _EcoMainScreenState extends State<EcoMainScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ecoMenu.itemStream,
      initialData: ecoMenu.defaultItem,
      // ignore: missing_return
      builder: (context, AsyncSnapshot<EcoMenuItem> snapshot) {
        switch (snapshot.data) {
          case EcoMenuItem.MENU:
            return MainEcoGuideScreen();
          case EcoMenuItem.CONTAINER:
            return ContainerScreen();
          case EcoMenuItem.REFERENCE:
            return ReferenceBookScreen();
          case EcoMenuItem.ADVICE:
            return AdviceScreen();
          case EcoMenuItem.TEST:
            return TestScreen();
        }
      },
    );
  }
}
