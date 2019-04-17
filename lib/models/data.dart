import 'package:json_annotation/json_annotation.dart';
import 'result.dart';
part 'data.g.dart';

@JsonSerializable()
class Data{

  Data(this.offset,this.limit,this.total,this.count);

  int offset;
  int limit;
  int total;
  int count;
  List<Result> results;


  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}