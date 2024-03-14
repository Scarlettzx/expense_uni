import 'dart:convert';

import 'package:uni_expense/src/features/user/expense/domain/entities/response_addexpensegood.dart';


ResponseAddExpenseGoodModel responseAddExpenseGoodModelFromJson(String str) =>
    ResponseAddExpenseGoodModel.fromJson(json.decode(str));

String responseAddExpenseGoodModelToJson(ResponseAddExpenseGoodModel data) =>
    json.encode(data.toJson());

class ResponseAddExpenseGoodModel extends ResponseAdddExpenseGoodEntity {
  const ResponseAddExpenseGoodModel({
    required String? status,
    required int? idExpense,
    required String? expenseStatus,
  }) : super(
          status: status,
          idExpense: idExpense,
          expenseStatus: expenseStatus,
        );

  factory ResponseAddExpenseGoodModel.fromJson(Map<String, dynamic> json) =>
      ResponseAddExpenseGoodModel(
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
