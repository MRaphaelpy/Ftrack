import 'package:http/http.dart' as http;

abstract class IHttpClient {
  Future<http.Response> get(String url);
}

class HttpService implements IHttpClient {
  @override
  Future<http.Response> get(String url) {
    return http.get(Uri.parse(url));
  }
}
