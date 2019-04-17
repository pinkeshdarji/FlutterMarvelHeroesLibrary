// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'heroshub.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HerosHub _$HerosHubFromJson(Map<String, dynamic> json) {
  return HerosHub(
      json['code'] as int,
      json['status'] as String,
      json['copyright'] as String,
      json['attributionText'] as String,
      json['attributionHTML'] as String,
      json['etag'] as String,
      json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>));
}

Map<String, dynamic> _$HerosHubToJson(HerosHub instance) => <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'copyright': instance.copyright,
      'attributionText': instance.attributionText,
      'attributionHTML': instance.attributionHTML,
      'etag': instance.etag,
      'data': instance.data
    };
