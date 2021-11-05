import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycle_hub/api/request/api_error.dart';
import 'package:recycle_hub/api/services/store_service.dart';

import 'package:recycle_hub/bloc/profile_bloc/profile_bloc.dart';
import 'package:recycle_hub/bloc/profile_bloc/store_bloc.dart';
import 'package:recycle_hub/bloc/store/store_bloc.dart';
import 'package:recycle_hub/elements/error_widget.dart';
import 'package:recycle_hub/helpers/messager_helper.dart';
import 'package:recycle_hub/icons/app_bar_icons_icons.dart';
import 'package:recycle_hub/model/product.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/loader_widget.dart';
import 'package:recycle_hub/screens/tabs/profile/purchase_detail_screen.dart';
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
  StoreBloc storeBloc;
  StreamSubscription<StoreState> _storeSub;

  @override
  void initState() {
    storeTabBarBloc.mapEventToState(StoreStates.SERVICES);
    storeBloc = BlocProvider.of<StoreBloc>(context);
    storeBloc.add(StoreEventInit());
    _storeSub = storeBloc.stream.listen((state) {
      if (state is StoreStateBought) {
        AlertHelper.showInfoAlert(context, "Товар куплен", 'Товар добавлен в ваши покупки, Вы можете посмотреть свою покупку в раздале "Мои покупки"');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Магазин",
          /* style: TextStyle(color: kColorWhite, fontFamily: 'GillRoyMedium', fontSize: 18, fontWeight: FontWeight.bold), */
        ),
        leading: InkWell(
          child: Icon(
            Icons.arrow_back,
            color: kColorWhite,
          ),
          onTap: () => widget.onBackCall(),
        ),
      ),
      body: Container(
        color: const Color(0xFFF2F2F2),
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        child: BlocBuilder<StoreBloc, StoreState>(
          buildWhen: (previous, current) {
            if (previous is StoreStateBought || current is StoreStateBought) {
              return false;
            }
            return true;
          },
          builder: (context, state) {
            if (state is StoreStateLoading) {
              return LoaderWidget();
            } else if (state is StoreStateError) {
              return CustomErrorWidget(
                message: state.message,
              );
            } else if (state is StoreStateLoaded) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: kColorGreen, width: 1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  storeTabBarBloc.mapEventToState(StoreStates.SERVICES);
                                  setState(() {
                                    _selected = 0;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _selected == 0 ? kColorGreen : kColorWhite,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      bottomLeft: Radius.circular(4),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Услуги",
                                      style: TextStyle(
                                        color: _selected == 0 ? kColorWhite : kColorGreen,
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
                                      color: _selected == 1 ? kColorGreen : kColorWhite,
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4))),
                                  child: Center(
                                    child: Text(
                                      "Товары",
                                      style: TextStyle(
                                        color: _selected == 1 ? kColorWhite : kColorGreen,
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
                      child: StreamBuilder(
                        stream: storeTabBarBloc.subject,
                        initialData: storeTabBarBloc.defaultState,
                        builder: (BuildContext context, AsyncSnapshot<StoreStates> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data == StoreStates.SERVICES) {
                              var list = StoreService().products;
                              return ListView.builder(
                                itemCount: list.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return ProductCell(
                                    product: list[index],
                                    callBack: () {
                                      storeBloc.add(StoreEventBuy(product: list[index]));
                                    },
                                  );
                                },
                              );
                            }
                            return Container();
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class ProductCell extends StatelessWidget {
  const ProductCell({Key key, this.product, this.callBack}) : super(key: key);
  final Product product;
  final Function callBack;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kBorderRadius)),
      child: Container(
        decoration: BoxDecoration(color: kColorWhite, borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (product.image != null && product.image.isNotEmpty)
                Image.network(
                  '${product.image}',
                  height: 100,
                  width: 100,
                ),
              if (product.image != null && product.image.isNotEmpty) Spacer(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(color: kColorBlack, fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Gilroy'),
                  ),
                  Text(
                    "${product.price} ЭкоКоинов",
                    style: const TextStyle(color: kColorBlack, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Gilroy'),
                  ),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  AlertHelper.showErrorAlert(
                    context,
                    "${product.name}",
                    "Вы действительно хотите купить этот товар?",
                    okButtonTitle: "Да",
                    denialButtonTitle: "Нет",
                    onClick: callBack,
                  );
                },
                child: FaIcon(
                  FontAwesomeIcons.plus,
                  color: kColorGreen,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
