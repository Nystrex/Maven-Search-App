// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Package _$PackageFromJson(Map<String, dynamic> json) {
  return Package(
    groupId: json['group_id'] as String,
    artifactId: json['artifact_id'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$PackageToJson(Package instance) => <String, dynamic>{
      'group_id': instance.groupId,
      'artifact_id': instance.artifactId,
      'name': instance.name,
      'description': instance.description,
    };
