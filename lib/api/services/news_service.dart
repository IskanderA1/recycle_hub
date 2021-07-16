import 'dart:convert';
import 'dart:developer' as d;

import 'package:recycle_hub/api/request/request.dart';
import 'package:recycle_hub/api/request_models/request_news.dart';
import 'package:recycle_hub/model/api_error.dart';
import 'package:recycle_hub/model/news.dart';

class NewsService {
  static NewsService _service = NewsService._();

  factory NewsService() {
    return _service;
  }
  NewsService._();

  List<News> news = [];

  Future<List<News>> loadNews() async {
    try {
      final response =
          await CommonRequest.makeRequest('news', needAuthorization: false);
      List data = jsonDecode(response.body);
      d.log(data.toString(), name: 'services.news_service');
      if (response.statusCode == 200) {
        news = List<News>.from(data.map((e) => News.fromMap(e)));
        return news;
      } else {
        throw ApiError(
            type: ApiErrorType.unknown,
            errorDescription: 'Не удалось загрузить новости');
      }
    } catch (e) {
      d.log(e.toString(), name: 'services.news_service');
      rethrow;
    }
  }

  Future<void> sendNews(RequestNewsCreateModel news) async {
    try {
      final response = await CommonRequest.makeRequest(
        'news',
        body: news.toMap(),
        method: CommonRequestMethod.post,
      );
      final data = jsonDecode(response.body);
      d.log(data.toString(), name: 'services.news_service');
      if (response.statusCode == 200) {
        return;
      } else {
        throw ApiError(
            type: ApiErrorType.unknown,
            errorDescription: 'Не удалось отправить новость');
      }
    } catch (e) {
      d.log(e.toString(), name: 'services.news_service');
      rethrow;
    }
  }
}
