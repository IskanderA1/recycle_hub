import 'package:flutter/material.dart';
import 'package:recycle_hub/api/request_models/request_news.dart';
import 'package:recycle_hub/api/services/news_service.dart';
import 'package:recycle_hub/elements/check_box_cell.dart';
import 'package:recycle_hub/elements/common_text_button.dart';
import 'package:recycle_hub/elements/simple_text_field.dart';
import 'package:recycle_hub/helpers/messager_helper.dart';
import 'package:recycle_hub/style/theme.dart';

class OfferNewsContainer extends StatefulWidget {
  @override
  _OfferNewsContainerState createState() => _OfferNewsContainerState();
}

class _OfferNewsContainerState extends State<OfferNewsContainer> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();
  bool _isAdvice = false;
  bool _isLoading = false;

  Future<void> sendNews() async {
    setState(() {
      _isLoading = true;
    });
    if (_titleController.text.isEmpty || _bodyController.text.isEmpty) {
      showMessage(context: context, message: 'Заполните поля');
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      RequestNewsCreateModel model = RequestNewsCreateModel(
          text: _bodyController.text,
          title: _titleController.text,
          isAdvice: _isAdvice);

      NewsService().sendNews(model);
      showMessage(
          context: context,
          message: 'Новость успешно сохранена',
          backColor: kColorGreen);
      clear();
    } catch (e) {
      print(e.toString());
      showMessage(context: context, message: e.toString());
    }

    setState(() {
      _isLoading = false;
    });
  }

  void clear() {
    _titleController.text = '';
    _bodyController.text = '';
    _isAdvice = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: kColorWhite),
        padding: EdgeInsets.all(20.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SimpleTextField(
                  controller: _titleController, labelText: 'Заголовок'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                'Тип новости',
                style: TextStyle(
                    color: kColorGreyDark,
                    fontSize: 14,
                    fontFamily: 'GilroyMedium'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: CheckBoxCell(
                isSelected: _isAdvice,
                text: 'Совет для экономии',
                onTap: () {
                  setState(() {
                    _isAdvice = !_isAdvice;
                  });
                },
              ),
            ),
            SimpleTextField(
              controller: _bodyController,
              labelText: 'Новость',
              maxLines: 5,
            ),
            Padding(
              padding: EdgeInsets.only(top: 32),
              child: CommonTextButton(
                text: 'Отправить',
                ontap: () {
                  sendNews();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
