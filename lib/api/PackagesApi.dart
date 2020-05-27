import 'Request.dart';

class PackagesAPI {
  Future<dynamic> getPackage(String pkg) async {
    Request request = Request(
        'https://package-search.jetbrains.com/api/package?onlyMpp=false&query=$pkg',
        {
          "Accepts": "*/*",
        });
    var packageData = await request.getResponse();
    return packageData;
  }
}
