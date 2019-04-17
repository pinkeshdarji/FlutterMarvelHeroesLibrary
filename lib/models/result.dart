import 'package:json_annotation/json_annotation.dart';
import 'thumbnail.dart';
part 'result.g.dart';

@JsonSerializable()
class Result{

  Result(this.id,this.name);

  int id;
  String name;
  String description;
  Thumbnail thumbnail;

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
  Map<String, dynamic> toJson() => _$ResultToJson(this);
}