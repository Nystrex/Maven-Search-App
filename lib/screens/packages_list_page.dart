import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maven_search/api/PackagesApi.dart';
import 'package:maven_search/screens/package_info_page.dart';

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

  @override
  void initState() {
    super.initState();
  }

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
              color: Colors.red.shade400,
            ),
            Positioned(
              bottom: 50.0,
              right: 100.0,
              child: Container(
                height: 400.0,
                width: 400.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200.0),
                    color: Colors.red.shade600.withOpacity(0.4)),
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
                      color: Colors.red.shade600.withOpacity(0.5))),
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
                    'Search for any maven package',
                    style:
                        TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
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
                            hintText: 'Search for Package',
                            hintStyle: TextStyle(color: Colors.grey))),
                  ),
                ),
                SizedBox(height: 15.0)
              ],
            )
          ],
        ),
      ]),
      Container(
          height: MediaQuery.of(context).size.height - 350,
          child: packages?.length != 0
              ? GridView.count(
                  shrinkWrap: true,
                  primary: true,
                  crossAxisCount: 2,
                  children: List.generate(packages?.length ?? 0, (index) {
                    return _buildPackageItem(packages[index]);
                  }))
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
                            Container(
                                height: 75.0,
                                width: 75.0,
                                decoration: BoxDecoration(
                                    color: Colors.red.shade400,
                                    shape: BoxShape.circle),
                                child: Center(child: Icon(Icons.warning))),
                            SizedBox(height: 25.0),
                            Text(
                              "Not Found",
                              style: TextStyle(fontSize: 24.0),
                              textAlign: TextAlign.center,
                            ),
                          ])),
                )),
      Container(
        height: 30,
        child: Center(
          child: Text("Made By Hadi Ka (Nystrex)",
              style: TextStyle(color: Colors.grey, fontSize: 11)),
        ),
      )
    ]));
  }

  _buildPackageItem(Map<String, dynamic> package) {
    return Padding(
        padding: EdgeInsets.all(15),
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PackageInfoPage(package: package)));
            },
            child: Container(
                height: 175.0,
                width: 175.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.black26),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        height: 75.0,
                        width: 75.0,
                        decoration: BoxDecoration(
                            color: Colors.red.shade400, shape: BoxShape.circle),
                        child: Center(child: Icon(Icons.code))),
                    SizedBox(height: 25.0),
                    Text(
                      package['artifactId'],
                      style: TextStyle(fontSize: 14.0),
                      textAlign: TextAlign.center,
                    ),
                    Text(package['groupId'],
                        style: TextStyle(fontSize: 10.0, color: Colors.grey),
                        textAlign: TextAlign.center),
                  ],
                ))));
  }
}
