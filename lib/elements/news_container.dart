import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recycle_hub/model/news.dart';
import 'package:recycle_hub/screens/tabs/eco_gide/eco_guide_tabs/advice_details.dart';
import 'package:recycle_hub/style/theme.dart';

class NewsContainer extends StatelessWidget {
  final News news;
  final DateFormat format = DateFormat('dd:MM:yyyy');
  NewsContainer({this.news});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return AdviceDetails(
              news: news,
            );
          },
        ));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kBorderRadius),
          topRight: Radius.circular(kBorderRadius),
        ),
        child: Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(kBorderRadius),
              ),
              color: kColorWhite,
            ),
            child: Column(
              children: [
                news.image != null
                    ? Hero(
                        tag: news.id,
                        child: Container(
                          height: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
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
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 10),
                  child: Column(
                    children: [
                      Text(
                        news.title,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: Text(
                          news.text,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            news.pubDate != null ? format.format(news.pubDate) : '20.12.2020',
                            style: TextStyle(color: kColorGreyLight),
                          ),
                          /* Text(
                            "Поподробнее",
                            style: TextStyle(color: kColorGreyLight),
                          ) */
                        ],
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
