import 'package:json_annotation/json_annotation.dart';

part 'thumbnail.g.dart';

@JsonSerializable()

class Thumbnail{

  Thumbnail(this.path,this.extension,this.hil);

  String path;
  String extension;
  String hil;

  factory Thumbnail.fromJson(Map<String, dynamic> json) => _$ThumbnailFromJson(json);
  Map<String, dynamic> toJson() => _$ThumbnailToJson(this);
}