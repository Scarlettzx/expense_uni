import 'dart:convert';

import '../../domain/entities/entities.dart';

ResponseDoDeleteExpenseGoodModel responseDoDeleteExpenseGoodModelFromJson(
        String str) =>
    ResponseDoDeleteExpenseGoodModel.fromJson(json.decode(str));

String responseDoDeleteExpenseGoodModelToJson(
        ResponseDoDeleteExpenseGoodModel data) =>
    json.encode(data.toJson());

class ResponseDoDeleteExpenseGoodModel
    extends ResponseDoDeleteExpenseGoodEntity {
  const ResponseDoDeleteExpenseGoodModel({required super.status});
  factory ResponseDoDeleteExpenseGoodModel.fromJson(
          Map<String, dynamic> json) =>
      ResponseDoDeleteExpenseGoodModel(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
