import 'dart:convert';

import '../../domain/entities/response_doaddwelfare.dart';

ResponseWelfareModel responseWelfareModelFromJson(String str) =>
    ResponseWelfareModel.fromJson(json.decode(str));

String responseWelfareModelToJson(ResponseWelfareModel data) =>
    json.encode(data.toJson());

class ResponseWelfareModel extends ResponseWelfareEntity {
  const ResponseWelfareModel({
    required String? status,
    required int? idExpense,
    required String? expenseStatus,
  }) : super(
          status: status,
          idExpense: idExpense,
          expenseStatus: expenseStatus,
        );

  factory ResponseWelfareModel.fromJson(Map<String, dynamic> json) =>
      ResponseWelfareModel(
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
