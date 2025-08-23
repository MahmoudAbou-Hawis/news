


import 'package:news/data/datasource/remote/news/baseApiClient.dart';
import 'package:news/data/datasource/remote/news/types.dart';

import '../../../models/newsMoedl.dart';
import '_base_url.dart';

class News {
  String apiKey;
  News({required this.apiKey});

  Future<List<NewsModel>> getNews({required NewsTypes types,
                                       required int page ,
                                       required int pageSize}) async {
    BaseApiClient client = BaseApiClient();
   final response = await client.asyncRequest(options: HttpOptions(baseUrl: getBaseUrl(),apiVersion: "v2",
        queryParameters: {
           "apiKey":apiKey,
          "language" : "en",
          "q" : types.name,
          "page" : page,
          "pageSize" : pageSize
    }));
   if(response.status == HttpStatus.success) {
      return response.response.map((element){
       return NewsModel.fromJson(element);
     }).toList();
   } else {
     return [];
   }
  }
}