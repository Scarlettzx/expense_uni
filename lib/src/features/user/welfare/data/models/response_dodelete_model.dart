import '../../domain/entities/entities.dart';
import 'dart:convert';

ResponseDoDeleteWelfareModel responseDoDeleteWelfareModelFromJson(String str) =>
    ResponseDoDeleteWelfareModel.fromJson(json.decode(str));

String responseDoDeleteWelfareModelToJson(ResponseDoDeleteWelfareModel data) =>
    json.encode(data.toJson());

class ResponseDoDeleteWelfareModel extends ResponseDoDeleteWelfareEntity {
  const ResponseDoDeleteWelfareModel({required super.status});
  factory ResponseDoDeleteWelfareModel.fromJson(Map<String, dynamic> json) =>
      ResponseDoDeleteWelfareModel(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
