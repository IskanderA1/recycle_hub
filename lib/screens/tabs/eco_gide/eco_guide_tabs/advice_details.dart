import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recycle_hub/model/news.dart';

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
              Hero(
                  tag: news.id,
                  child: Container(
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      child: CachedNetworkImage(
                        imageUrl: news.image ??
                            "https://www.accenture.com/t20200128T032529Z__w__/lu-en/_acnmedia/Accenture/Redesign-Assets/DotCom/Images/Global/Thumbnail400x400/8/Accenture-australian-water-utility-blue-400x400.jpg",
                        imageBuilder: (context, imageProvider) {
                          return Blur(
                            blur: 5.0,
                            colorOpacity: 0.0,
                            child: Container(
                                decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
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
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  )),
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      news.title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
