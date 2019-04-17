// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thumbnail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Thumbnail _$ThumbnailFromJson(Map<String, dynamic> json) {
  return Thumbnail(json['path'] as String, json['extension'] as String,
      json['hil'] as String);
}

Map<String, dynamic> _$ThumbnailToJson(Thumbnail instance) => <String, dynamic>{
      'path': instance.path,
      'extension': instance.extension,
      'hil': instance.hil
    };
