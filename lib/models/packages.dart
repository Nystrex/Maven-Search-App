part 'packages.g.dart';

class Package {
  String groupId;
  String artifactId;
  String name;
  String description;

  Package({this.groupId, this.artifactId, this.name, this.description});

  factory Package.fromJson(Map<String, dynamic> json) =>
      _$PackageFromJson(json);
  Map<String, dynamic> toJson() => _$PackageToJson(this);
}

class PackageList {
  List<Package> packages;

  PackageList({this.packages});

  factory PackageList.fromJson(List<dynamic> json) {
    return PackageList(
        packages: json
            .map((e) => Package.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}
