


import 'package:news/data/datasource/remote/news/types.dart';

String defaultNewsUrl = "newsapi.org";


void setDefaultBaseUrls({required String newsUrl}) {
  defaultNewsUrl = newsUrl;
}

String getBaseUrl({HttpOptions? options}) {
  if (options != null && options.baseUrl != "") {
    return options.baseUrl;
  }
  return defaultNewsUrl;
}