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
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: Hero(
                    tag: "first_image",
                    child: Image.network(
                        "https://www.accenture.com/t20200128T032529Z__w__/lu-en/_acnmedia/Accenture/Redesign-Assets/DotCom/Images/Global/Thumbnail400x400/8/Accenture-australian-water-utility-blue-400x400.jpg"),
                  ),
                ),
              ),
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
