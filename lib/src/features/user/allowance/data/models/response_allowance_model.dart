import 'dart:convert';

import 'package:uni_expense/src/features/user/allowance/domain/entities/entities.dart';

ResponseAllowanceModel responseAllowanceModelFromJson(String str) =>
    ResponseAllowanceModel.fromJson(json.decode(str));

String responseAllowanceModelToJson(ResponseAllowanceModel data) =>
    json.encode(data.toJson());

class ResponseAllowanceModel extends ResponseAllowanceEntity {
  const ResponseAllowanceModel({
    required String? status,
    required int? idExpense,
    required String? expenseStatus,
  }) : super(
          status: status,
          idExpense: idExpense,
          expenseStatus: expenseStatus,
        );

  factory ResponseAllowanceModel.fromJson(Map<String, dynamic> json) =>
      ResponseAllowanceModel(
        status: json["status"],
        idExpense: json["idExpense"],
        expenseStatus: json["expenseStatus"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "idExpense": idExpense,
        "expenseStatus": expenseStatus,
      };
}
