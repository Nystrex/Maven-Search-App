import 'package:flutter/material.dart';

class PackageInfoPage extends StatelessWidget {
  final Map<String, dynamic> package;

  PackageInfoPage({this.package});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red.shade400,
          title: Text(package['artifactId'])),
      body: Container(
        width: double.infinity,
        child: Card(
            elevation: 8.00,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(package['artifactId'],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
                  Text(
                    package['groupId'],
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
