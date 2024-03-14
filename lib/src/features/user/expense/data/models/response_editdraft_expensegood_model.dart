import 'dart:convert';

import '../../domain/entities/entities.dart';

ResponseEditDraftExpenseGoodModel responseEditDraftExpenseGoodModelFromJson(
        String str) =>
    ResponseEditDraftExpenseGoodModel.fromJson(json.decode(str));

String responseEditDraftExpenseGoodModelToJson(
        ResponseEditDraftExpenseGoodModel data) =>
    json.encode(data.toJson());

class ResponseEditDraftExpenseGoodModel
    extends ResponseEditDraftExpenseGoodEntity {
  const ResponseEditDraftExpenseGoodModel(
      {required super.status, required super.expenseStatus});

  factory ResponseEditDraftExpenseGoodModel.fromJson(
          Map<String, dynamic> json) =>
      ResponseEditDraftExpenseGoodModel(
        status: json["status"],
        expenseStatus: json["expenseStatus"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "expenseStatus": expenseStatus,
      };
}
