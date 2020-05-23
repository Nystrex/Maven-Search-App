//'https://package-search.jetbrains.com/api/package?onlyMpp=false&query=$pkg', headers: {"Accepts": "*/*"});

import 'Network.dart';

class PackagesAPI {
  Future<dynamic> getPackage(String pkg) async {
    Network network = Network(
        'https://package-search.jetbrains.com/api/package?onlyMpp=false&query=$pkg',
        {"Accepts": "*/*"});
    var packageData = await network.getData();
    return packageData;
  }
}
