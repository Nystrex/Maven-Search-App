import 'package:flutter/material.dart';
import 'screens/package_info_page.dart';
import 'screens/packages_list_page.dart';

void main() {
  runApp(new MaterialApp(
      initialRoute: '/',
      darkTheme: ThemeData.dark(),
      routes: {
        '/': (context) => PackagesPage(),
        '/info': (context) => PackageInfoPage()
      }));
}
