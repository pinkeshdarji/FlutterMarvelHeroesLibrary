import 'package:json_annotation/json_annotation.dart';
import 'data.dart';
part 'heroshub.g.dart';

@JsonSerializable()
class HerosHub {

  HerosHub(this.code, this.status, this.copyright, this.attributionText,
      this.attributionHTML, this.etag, this.data);

  @JsonKey(name: 'code')
  int code;
  @JsonKey(name: 'status')
  String status;
  @JsonKey(name: 'copyright')
  String copyright;
  @JsonKey(name: 'attributionText')
  String attributionText;
  @JsonKey(name: 'attributionHTML')
  String attributionHTML;
  @JsonKey(name: 'etag')
  String etag;
  @JsonKey(name: 'data')
  Data data;

  factory HerosHub.fromJson(Map<String, dynamic> json) => _$HerosHubFromJson(json);

  Map<String, dynamic> toJson() => _$HerosHubToJson(this);
}
