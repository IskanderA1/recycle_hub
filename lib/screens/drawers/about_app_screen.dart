import 'package:flutter/material.dart';
import 'package:recycle_hub/elements/common_cell.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/loader_widget.dart';
import 'about_developers_screen.dart';
import 'package:package_info/package_info.dart';

class AboutAppScreen extends StatefulWidget {
  @override
  _AboutAppScreenState createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  Future<String> _getPackage() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      return '${packageInfo.version} (${packageInfo.buildNumber})';
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    print('helloabdu');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "О приложении",
          /* style: TextStyle(fontFamily: 'Gillroy'), */
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: FutureBuilder<String>(
          future: _getPackage(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: LoaderWidget());
            }
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ListView(
                      shrinkWrap: true,
                      children: [
                        CommonCell(
                          text: 'Условия и положения',
                          onTap: () {
                            /* Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BePartnerScreen(),
                          ),
                        ); */
                          },
                        ),
                        CommonCell(
                          text: 'Политика конфеденциальности',
                          onTap: () {},
                        ),
                        CommonCell(
                          text: 'Условия реферальной программы',
                          onTap: () {},
                        ),
                        CommonCell(
                          text: 'О разработчиках',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AboutDevelopersScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Positioned(
                      right: 8,
                      bottom: 16,
                      child: Text(snapshot.data),
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: LoaderWidget(),
              );
            }
          }),
    );
  }
}
