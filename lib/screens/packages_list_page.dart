import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maven_search/api/PackagesApi.dart';
import 'package:maven_search/screens/package_info_page.dart';

class PackagesPage extends StatefulWidget {
  @override
  _PackagesPageState createState() => _PackagesPageState();
}

int getColorHexFromStr(String colorStr) {
  colorStr = "FF" + colorStr;
  colorStr = colorStr.replaceAll("#", "");
  int val = 0;
  int len = colorStr.length;
  for (int i = 0; i < len; i++) {
    int hexDigit = colorStr.codeUnitAt(i);
    if (hexDigit >= 48 && hexDigit <= 57) {
      val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 65 && hexDigit <= 70) {
      val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 97 && hexDigit <= 102) {
      val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
    } else {
      throw new FormatException("An error occurred when converting a color");
    }
  }
  return val;
}

class _PackagesPageState extends State<PackagesPage> {
  List<dynamic> packages;
  String lastValue;

  void getPackageData(String pkg) async {
    if (pkg == null) return;
    var result = await PackagesAPI().getPackage(pkg ?? "gson");
    var pakMap = json.decode(result);
    setState(() {
      packages = pakMap;
    });
  }

//  Future<void> _showSearch() async {
//    final searchText = await showSearch<String>(
//      context: context,
//      delegate: SearchWithSuggestionDelegate(
//        onSearchChanged: _getRecentSearchesLike,
//      ),
//    );
//    await _saveToRecentSearches(searchText);
//    getPackageData(searchText);
//  }
//
//  Future<List<String>> _getRecentSearchesLike(String query) async {
//    final pref = await SharedPreferences.getInstance();
//    final allSearches = pref.getStringList("recentSearches");
//    return allSearches.where((search) => search.startsWith(query)).toList();
//  }
//
//  Future<void> _saveToRecentSearches(String searchText) async {
//    if (searchText == null) return;
//    final pref = await SharedPreferences.getInstance();
//
//    Set<String> allSearches =
//        pref.getStringList("recentSearches")?.toSet() ?? {};
//
//    allSearches = {searchText, ...allSearches};
//    pref.setStringList("recentSearches", allSearches.toList());
//  }

  @override
  void initState() {
    super.initState();
  }

  //onPressed: _showSearch,

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: <Widget>[
      Column(children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              height: 250.0,
              width: double.infinity,
              color: Colors.red.shade800,
            ),
            Positioned(
              bottom: 50.0,
              right: 100.0,
              child: Container(
                height: 400.0,
                width: 400.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200.0),
                    color: Colors.red.shade400.withOpacity(0.4)),
              ),
            ),
            Positioned(
              bottom: 100.0,
              left: 150.0,
              child: Container(
                  height: 300.0,
                  width: 300.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150.0),
                      color: Colors.red.shade400.withOpacity(0.5))),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 15.0),
                Row(
                  children: <Widget>[
                    SizedBox(width: 15),
                    Container(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () {
                          Fluttertoast.showToast(msg: "Coming Soon!");
                        },
                        color: Colors.white,
                        iconSize: 30.0,
                      ),
                    ),
                    SizedBox(height: 15.0),
                  ],
                ),
                SizedBox(height: 50.0),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Maven Search',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 15.0),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Search for any maven packages',
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 25.0),
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Material(
                    elevation: 8.0,
                    borderRadius: BorderRadius.circular(5.0),
                    child: TextField(
                        onSubmitted: (value) {
                          getPackageData(value);
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search,
                                color: Colors.red.shade400, size: 30.0),
                            contentPadding:
                                EdgeInsets.only(left: 15.0, top: 15.0),
                            hintText: 'Search',
                            hintStyle: TextStyle(
                                color: Colors.grey, fontFamily: 'Quicksand'))),
                  ),
                ),
                SizedBox(height: 10.0)
              ],
            )
          ],
        ),
      ]),
      SizedBox(height: 15.0),
      Container(
          height: 200.0,
          child: packages?.length != 0
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: packages?.length ?? 0,
                  itemBuilder: (context, index) =>
                      _buildPackageItem(packages[index]))
              : Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Container(
                      height: 175.0,
                      width: 200.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.red.shade600),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Hero(
                                tag: "Not Found",
                                child: Container(
                                    height: 75.0,
                                    width: 75.0,
                                    decoration: BoxDecoration(
                                        color: Colors.red.shade400,
                                        shape: BoxShape.circle),
                                    child: Center(child: Icon(Icons.warning)))),
                            SizedBox(height: 25.0),
                            Text(
                              "Not Found",
                              style: TextStyle(fontSize: 24.0),
                              textAlign: TextAlign.center,
                            ),
                          ])),
                ))
    ]));
  }

  _buildPackageItem(Map<String, dynamic> package) {
    return Padding(
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PackageInfoPage(package: package)));
            },
            child: Container(
                height: 175.0,
                width: 200.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.black26),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Hero(
                        tag: package['artifactId'],
                        child: Container(
                            height: 75.0,
                            width: 75.0,
                            decoration: BoxDecoration(
                                color: Colors.red.shade400,
                                shape: BoxShape.circle),
                            child: Center(child: Icon(Icons.code)))),
                    SizedBox(height: 25.0),
                    Text(
                      package['artifactId'],
                      style: TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                    Text(package['groupId'],
                        style: TextStyle(fontSize: 12.0, color: Colors.grey),
                        textAlign: TextAlign.center),
                  ],
                ))));
  }
}
