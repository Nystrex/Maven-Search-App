import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:maven_search/api/PackagesApi.dart';
import 'package:maven_search/models/packages.dart';

class PackagesPage extends StatefulWidget {
  @override
  _PackagesPageState createState() => _PackagesPageState();
}

class _PackagesPageState extends State<PackagesPage> {
  PackageList packageList = PackageList();

  void getPackageData(String pkg) async {
      var result = await PackagesAPI().getPackage(pkg);
      var pakMap = json.decode(result);
      setState(() {
        packageList = PackageList.fromJson(pakMap);
      });
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
          title: TextField(
              onSubmitted: (value) {
                  getPackageData(value.isEmpty || value == null ? "maven" : value);
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: "Search Package...",
                  hintStyle: TextStyle(color: Colors.white)))),
      body: ListView.builder(
          itemCount: packageList?.packages?.length ?? 0 ,
          itemBuilder: (context, index) =>
              GestureDetector(
                onTap: () {
                  print(packageList?.packages?.length ?? 0);
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    // 7
                    child: ListTile(
                      title: Text(packageList.packages[index].artifactId ?? 'Package not Found!'),
                      subtitle: Text(packageList.packages[index].groupId ?? ''),
                    ),
                  ),
                ),
              )),
    );
  }
}
