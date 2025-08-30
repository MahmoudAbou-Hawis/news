import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:news/data/datasource/remote/news/types.dart';




class BaseApiClient {
  String _buildRequest({
    required HttpOptions options,
    required String endPoint,
  }) {
    return Uri.https(
      options.baseUrl,
      '${options.apiVersion}/$endPoint',
      options.stringQueryParameters
    ).toString();
  }
  Future<HttpResponse> asyncRequest({required HttpOptions options}) async {
    Dio dio = Dio();
    String requestUrl = _buildRequest(options: options,
                                    endPoint: "everything");
    try{
      final response =  await dio.request(requestUrl,options: Options(
          method: 'GET'
      ));
      final articles = (response.data as Map<String, dynamic>)["articles"] as List<dynamic>;
      final parsedArticles = articles.cast<Map<String, dynamic>>();



      return HttpResponse(
        response.statusCode == 200 ? HttpStatus.success : HttpStatus.failure,
        parsedArticles,
      );
    }catch (_) {
      return HttpResponse(
        HttpStatus.failure,
        [],
      );
    }



  }

}
