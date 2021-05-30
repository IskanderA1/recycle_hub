import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:recycle_hub/bloc/profile_bloc/profile_bloc.dart';
import 'package:recycle_hub/model/invite_model.dart';
import 'package:recycle_hub/api/app_repo.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/loader_widget.dart';
import 'package:recycle_hub/style/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class InviteScreen extends StatefulWidget {
  @override
  _InviteScreenState createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: kColorWhite, size: 25),
            onPressed: () =>
                profileMenuBloc.mapEventToState(ProfileMenuStates.MENU),
          ),
          title: Text(
            "Мои покупки",
            style: TextStyle(
                color: kColorWhite,
                fontSize: 18,
                fontFamily: 'GillroyMedium',
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        backgroundColor: kColorGreyVeryLight,
        body: InviteWidget(
                code: 1324234234,
              )/*FutureBuilder(
          future: AppService().getInvite(Hive.box('user').get('user').id),
          builder: (context, snapshot) {
            /*if (snapshot.connectionState == ConnectionState.waiting) {
              return LoaderWidget();
            }
            if (snapshot.data is Invite) {
              return InviteWidget(
                code: snapshot.data.code,
              );
            }
            return LoaderWidget();*/
          },
        )*/);
  }
}

class InviteWidget extends StatelessWidget {
  const InviteWidget({Key key, @required this.code}) : super(key: key);
  final int code;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 25, 15, 0),
      child: Container(
        decoration: BoxDecoration(
            color: kColorWhite,
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                    text:
                        "Пригласите друзей и получайте экокоины! Больше активных рефералов - больше экокоинов!",
                    style: TextStyle(
                        fontFamily: 'Gillroy',
                        fontSize: 18,
                        color: kColorBlack,
                        fontWeight: FontWeight.bold)),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Ваш реферальный код:",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'GillroyMedium',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    "$code",
                    style: TextStyle(
                        fontFamily: 'Gillroy',
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: "$code"));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Код скопирован в буфер обмена"),
                        duration: Duration(seconds: 1),
                      ));
                    },
                    child: Icon(
                      Icons.copy,
                      color: kColorGreyLight,
                      size: 25,
                    ),
                  )
                ],
              ),
              Divider(
                color: kColorGreyDark,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                            color: kColorGreen, shape: BoxShape.circle),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: RichText(
                      text: TextSpan(
                        text:
                            "Ваш друг должен указать этот код при регистрации в приложении (код одноразовый)",
                        style: TextStyle(
                          color: kColorBlack,
                          fontFamily: 'GillroyMedium',
                          fontSize: 14,
                        ),
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 100,
              ),
              Text(
                "Поделитесь нашим приложением в социальных сетях",
                style: TextStyle(
                    fontFamily: 'GillroyMedium',
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: CircleAvatar(
                          child: FaIcon(
                        FontAwesomeIcons.vk,
                        color: kColorWhite,
                        size: 20,
                      )),
                      onTap: () {
                        try {
                          openUrl('https://vk.com/feed');
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Не удалось открыть приложение VK"),
                          ));
                        }
                      },
                    ),
                    GestureDetector(
                      child: CircleAvatar(
                          child: FaIcon(
                        FontAwesomeIcons.instagram,
                        color: kColorWhite,
                        size: 20,
                      )),
                      onTap: () {
                        try {
                          openUrl(
                              'https://www.instagram.com/<INSTAGRAM_PROFILE>/');
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text("Не удалось открыть приложение Instagram"),
                          ));
                        }
                      },
                    ),
                    GestureDetector(
                      child: CircleAvatar(
                          child: FaIcon(
                        FontAwesomeIcons.facebookF,
                        color: kColorWhite,
                        size: 20,
                      )),
                      onTap: () {
                        try {
                          openUrl('https://www.facebook.com');
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text("Не удалось открыть приложение Facebook"),
                          ));
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void openUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      universalLinksOnly: true,
    );
  } else {
    throw 'There was a problem to open the url: $url';
  }
}
