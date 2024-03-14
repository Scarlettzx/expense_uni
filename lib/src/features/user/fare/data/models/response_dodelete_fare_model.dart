import 'dart:convert';

import 'package:uni_expense/src/features/user/fare/domain/entities/entities.dart';

ResponseDoDeleteFareModel responseDoDeleteFareModelFromJson(String str) =>
    ResponseDoDeleteFareModel.fromJson(json.decode(str));

String responseDoDeleteFareModelToJson(ResponseDoDeleteFareModel data) =>
    json.encode(data.toJson());

class ResponseDoDeleteFareModel extends ResponseDoDeleteFareEntity {
  const ResponseDoDeleteFareModel({required super.status});
  factory ResponseDoDeleteFareModel.fromJson(Map<String, dynamic> json) =>
      ResponseDoDeleteFareModel(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
