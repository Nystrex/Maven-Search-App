import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:maven_search/api/PackagesApi.dart';
import 'package:maven_search/components/custom_search_delgates.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package_info_page.dart';

class PackagesPage extends StatefulWidget {
  @override
  _PackagesPageState createState() => _PackagesPageState();
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

  Future<void> _showSearch() async {
    final searchText = await showSearch<String>(
      context: context,
      delegate: SearchWithSuggestionDelegate(
        onSearchChanged: _getRecentSearchesLike,
      ),
    );
    await _saveToRecentSearches(searchText);
    getPackageData(searchText);
  }

  Future<List<String>> _getRecentSearchesLike(String query) async {
    final pref = await SharedPreferences.getInstance();
    final allSearches = pref.getStringList("recentSearches");
    return allSearches.where((search) => search.startsWith(query)).toList();
  }

  Future<void> _saveToRecentSearches(String searchText) async {
    if (searchText == null) return;
    final pref = await SharedPreferences.getInstance();

    Set<String> allSearches =
        pref.getStringList("recentSearches")?.toSet() ?? {};

    allSearches = {searchText, ...allSearches};
    pref.setStringList("recentSearches", allSearches.toList());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade400,
        title: Text("Maven Search"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _showSearch,
          ),
        ],
      ),
      body: packages?.length != 0
          ? ListView.builder(
              itemCount: packages?.length ?? 0,
              itemBuilder: (context, index) => GestureDetector(
                    child: Card(
                      elevation: 3.00,
                      child: ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.star_border),
                          onPressed: () {},
                        ),
                        title: Text(packages[index]['artifactId'] ?? ""),
                        subtitle: Text(packages[index]['groupId'] ?? ""),
                        trailing: FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PackageInfoPage(package: packages[index])));
                          },
                          child: Text(
                            "Details",
                            style: TextStyle(
                                color: Colors.blue.shade400,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ))
          : Center(child: Text("Not Found!")),
    );
  }
}
