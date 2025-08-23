


import 'package:news/data/datasource/remote/news/news.dart';

class Client{
  News news;
  Client({required String apiKey}) : news = News(apiKey: apiKey);
}