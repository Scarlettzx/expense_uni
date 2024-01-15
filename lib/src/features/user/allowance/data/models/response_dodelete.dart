import 'package:uni_expense/src/features/user/allowance/domain/entities/entities.dart';

import 'dart:convert';

ResponseDoDeleteAllowanceModel responseDoDeleteAllowanceModelFromJson(
        String str) =>
    ResponseDoDeleteAllowanceModel.fromJson(json.decode(str));

String responseDoDeleteAllowanceModelToJson(
        ResponseDoDeleteAllowanceModel data) =>
    json.encode(data.toJson());

class ResponseDoDeleteAllowanceModel extends ResponseDoDeleteAllowanceEntity {
  const ResponseDoDeleteAllowanceModel({required super.status});
  factory ResponseDoDeleteAllowanceModel.fromJson(Map<String, dynamic> json) =>
      ResponseDoDeleteAllowanceModel(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
