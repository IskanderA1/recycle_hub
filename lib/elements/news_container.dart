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
                          return AdviceDetails(news: news,);
                        },
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height: 400,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Expanded(
                                child: Hero(
                              tag: "first_image",
                              child: Image.network(
                                  "https://www.accenture.com/t20200128T032529Z__w__/lu-en/_acnmedia/Accenture/Redesign-Assets/DotCom/Images/Global/Thumbnail400x400/8/Accenture-australian-water-utility-blue-400x400.jpg",
                                  ),
                              
                            )),
                            Expanded(
                                child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Text(
                                    news.title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Wrap(children: [
                                    Text(
                                        news.text,
                                        maxLines: 5,)
                                  ]),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        news.pubDate != null?format.format(news.pubDate) : '20.12.2020',
                                        style:
                                            TextStyle(color: kColorGreyLight),
                                      ),
                                      Text(
                                        "Поподробнее",
                                        style:
                                            TextStyle(color: kColorGreyLight),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                    ),
                  );
  }
}