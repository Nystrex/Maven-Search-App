import 'package:http/http.dart';

class Network {
  final String url;
  final Map<String, String> headers;

  Network(this.url, this.headers);

  Future getData() async {
    print('Calling uri: $url');
    Response response = await get(url, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
    }
  }
}
