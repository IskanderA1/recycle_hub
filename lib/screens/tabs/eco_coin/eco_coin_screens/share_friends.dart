import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/bloc/auth/auth_bloc.dart';
import 'package:recycle_hub/bloc/eco_coin_menu/eco_coin_menu_cubit.dart';
import 'package:recycle_hub/helpers/messager_helper.dart';
import 'package:recycle_hub/model/user_model.dart';
import 'package:recycle_hub/style/theme.dart';
import 'package:recycle_hub/elements/ball.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:url_launcher/url_launcher.dart';

enum SocialMedia { facebook, vkontakte, telegram }

// enum Share { facebook, whatsapp, share_instagram, share_telegram }

class ShareFineds extends StatefulWidget {
  @override
  _ShareFinedsState createState() => _ShareFinedsState();
}

class _ShareFinedsState extends State<ShareFineds> {
  UserModel userState;
  AuthBloc authBloc;

  @override
  void initState() {
    authBloc = GetIt.I.get<AuthBloc>();
    userState = authBloc.state.userModel;
    print('invitecode ${userState.inviteCode}');
    authBloc.stream.listen((st) {
      userState = authBloc.state.userModel;
    });
    super.initState();
  }

  // Future<void> onButtonTap(Share share) async {
  //   String msg =
  //       'Flutter share is great!!\n Check out full example at https://pub.dev/packages/flutter_share_me';
  //   String url = 'https://pub.dev/packages/flutter_share_me';

  //   String response;
  //   final FlutterShareMe flutterShareMe = FlutterShareMe();
  //   switch (share) {
  //     case Share.facebook:
  //       response = await flutterShareMe.shareToFacebook(url: url, msg: msg);
  //       break;
  //     case Share.whatsapp:
  //       response = await flutterShareMe.shareToWhatsApp(msg: msg);
  //       break;

  //     case Share.share_instagram:
  //       // response = await flutterShareMe.shareToInstagram(imagePath: file!.path);
  //       break;
  //     case Share.share_telegram:
  //       // response = await flutterShareMe.shareToTelegram(msg: msg);
  //       break;
  //   }

  //   debugPrint(response);
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        GetIt.I.get<EcoCoinMenuCubit>().moveTo(EcoCoinMenuItems.MENU);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Порекомендуйте друзьям",
            /* style: TextStyle(fontFamily: 'Gillroy'), */
          ),
          leading: GestureDetector(
            onTap: () {
              GetIt.I.get<EcoCoinMenuCubit>().moveTo(EcoCoinMenuItems.MENU);
            },
            child: Icon(
              Icons.arrow_back,
              color: kColorWhite,
            ),
          ),
        ),
        backgroundColor: kColorGreyVeryLight,
        body: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Container(
            height: ScreenUtil().screenHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              color: kColorWhite,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        'Пригласите друзей и получайте экокоины! Больше активных рефералов-больше экокоинов!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Column(
                      children: [
                        Container(
                          child: Text(
                            'Ваш реферальный код :',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          child: Text(
                            '${userState.inviteCode}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        GestureDetector(
                          onTap: () {
                            final data =
                                ClipboardData(text: '${userState.inviteCode}');
                            Clipboard.setData(data);
                            AlertHelper.showSuccesMessage(
                                context: context,
                                message: 'Код скопирован в буфер обмена');
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 44,
                            decoration: BoxDecoration(
                                border: Border.all(color: kColorGreen),
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                              child: Center(
                                child: Text(
                                  'Копировать код',
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: BallGreen(),
                            ),
                            Expanded(
                              flex: 6,
                              child: Container(
                                child: Text(
                                  'Ваш друг должен указать этот код при первом входе в приложении',
                                  style: TextStyle(
                                    fontFamily: "Gilroy",
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Container(
                          child: Text(
                            'Поделитесь нашим приложениемв в социальных сетях',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                share(SocialMedia.vkontakte);
                              },
                              child: Container(
                                child: Image(
                                  width: 50,
                                  height: 50,
                                  image: Svg('assets/icons/socials/vk.svg'),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                share(SocialMedia.facebook);
                              },
                              child: Container(
                                child: Image(
                                  width: 50,
                                  height: 50,
                                  image: Svg('assets/icons/socials/fb.svg'),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                share(SocialMedia.telegram);
                              },
                              child: Container(
                                child: Image(
                                  width: 50,
                                  height: 50,
                                  image: AssetImage('assets/icons/socials/telegram.png')
                                  // image: Svg('assets/icons/socials/in.svg'),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future share(SocialMedia socialPlatform) async {
    final message =
        'Лучшее мобильное приложение для поиска пунктов приёма вторсырья';
    final urlShare =
        'https://play.google.com/store/apps/details?id=com.beerstudio.recycle_hub';

    final urls = {
      SocialMedia.vkontakte:
          "http://vk.com/share.php?url=$urlShare&title=RecycleHub&description=$message&noparse=true",
      SocialMedia.facebook:
          "https://www.facebook.com/sharer/sharer.php?u=$urlShare",
      SocialMedia.telegram:
          "https://telegram.me/share/url?url=$urlShare&text=RecycleHub - ${message}",
    };
    final url = urls[socialPlatform];
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
