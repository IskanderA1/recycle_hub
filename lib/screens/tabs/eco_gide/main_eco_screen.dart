import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/bloc/eco_guide_cubit/eco_guide_cubit_cubit.dart';
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
    return BlocBuilder<EcoGuideCubit, EcoGuideMenuItem>(
      bloc: GetIt.I.get<EcoGuideCubit>(),
      // ignore: missing_return
      builder: (context, state) {
        switch (state) {
          case EcoGuideMenuItem.MENU:
            return MainEcoGuideScreen();
          case EcoGuideMenuItem.CONTAINER:
            return ContainerScreen();
          case EcoGuideMenuItem.REFERENCE:
            return ReferenceBookScreen();
          case EcoGuideMenuItem.ADVICE:
            return AdviceScreen();
          case EcoGuideMenuItem.TEST:
            return TestScreen(
              onBackPressed: GetIt.I.get<EcoGuideCubit>().goBack,
            );
        }
      },
    );
  }
}
