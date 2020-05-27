import 'package:http/http.dart';

class Request {
  final String url;
  final Map<String, String> headers;

  Request(this.url, this.headers);

  Future getResponse() async {
    Response response = await get(url, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      Exception(response.statusCode);
    }
  }
}
