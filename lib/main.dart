import 'package:flutter/material.dart';

import 'screens/package_info_page.dart';
import 'screens/packages_list_page.dart';

void main() {
  runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.red,
          primaryColorDark: Colors.red.shade400,
          accentColor: Colors.redAccent,
          textSelectionHandleColor: Colors.redAccent,
          toggleableActiveColor: Colors.redAccent),
      routes: {
        '/': (context) => PackagesPage(),
        '/info': (context) => PackageInfoPage()
      }));
}
