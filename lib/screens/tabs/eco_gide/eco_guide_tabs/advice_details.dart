import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recycle_hub/model/news.dart';
import 'package:recycle_hub/style/theme.dart';

class AdviceDetails extends StatelessWidget {
  final News news;
  AdviceDetails({@required this.news});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Советы для экономики"),
        ),
        body: Container(
          padding: EdgeInsets.all(17),
          height: MediaQuery.of(context).size.height - 50,
          child: ListView(
            children: [
              news.image != null
                  ? Hero(
                      tag: news.id,
                      child: Container(
                        height: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(kBorderRadius),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: news.image,
                            imageBuilder: (context, imageProvider) {
                              return Blur(
                                blur: 5.0,
                                colorOpacity: 0.0,
                                child: Container(
                                    decoration: BoxDecoration(
                                  image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                )),
                                overlay: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                            /* errorWidget: (context, url, error) => Center(
                            child: Icon(
                              Icons.error,
                              color: kColorIcon,
                            ),
                          ), */
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      news.title,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Wrap(children: [
                      Text(news.text),
                    ])
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
