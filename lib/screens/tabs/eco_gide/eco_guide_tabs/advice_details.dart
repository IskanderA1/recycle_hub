import 'package:flutter/material.dart';

class AdviceDetails extends StatefulWidget {
  @override
  _AdviceDetailsState createState() => _AdviceDetailsState();
}

class _AdviceDetailsState extends State<AdviceDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Советы для экономики"),
      ),
      body: Container(
        padding: EdgeInsets.all(17),
        height: MediaQuery.of(context).size.height - 50,
        child: ListView(
          children: [
            Expanded(
              flex: 1,
              child: Container(
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
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Как и зачем экономить воду?",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Wrap(children: [
                      Text(
                          "Вода – незаменимый источник существования каждого человека. Однако неэкономное использование этого незаменимого и важного ресурса, в большинстве странах, может привести к нарушению стабильности в экосистемах. Установка счетчиков на воду может решить проблему с беспечной растратой столь важного ресурса. Плохой уровень экологической обстановки, неразумная эксплуатация рек и озер, чрезмерное расходование воды приводит к уменьшению количества воды и значительно ухудшает ее качество. Сегодня общий расход воды намного превышает темпы прироста человечества. Специалисты уже подсчитали, что если ситуация останется такой же, то через пару десятков лет около двух третей населения нашей планеты начнут испытывать нехватку воды. Как бы невероятно это не звучало, но установка счетчиков воды может существенно изменить ситуацию, так как каждый собственник жилья сможет лично контролировать расход воды. Когда человек видит, сколько он тратит и сколько он платит за потраченную воду впустую, то начинает проявлять бережное отношение к столь важным."),
                    ])
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
