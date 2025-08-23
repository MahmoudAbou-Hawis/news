class HttpOptions {
  HttpOptions({
    this.baseUrl = "",
    this.apiVersion = "",
    this.queryParameters = const {},
  });
  String baseUrl = "";
  String apiVersion = "";
  Map<String, dynamic> queryParameters = {};

  Map<String, String> get stringQueryParameters {
    return queryParameters.map(
          (key, value) => MapEntry(key, value.toString()),
    );
  }
}

class HttpResponse {
  HttpStatus status = HttpStatus.success;
  List<Map<String,dynamic>> response = [{}];

  HttpResponse(this.status, this.response);
}

enum NewsTypes
{
  health,
  entertainment,
  science,
  technology,
  general
}

enum HttpStatus
{
  failure,
  success
}