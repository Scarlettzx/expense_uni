import 'dart:convert';

import 'package:uni_expense/src/features/user/fare/domain/entities/entities.dart';

ResponseFareModel responseFareModelFromJson(String str) =>
    ResponseFareModel.fromJson(json.decode(str));

String responseFareModelToJson(ResponseFareModel data) =>
    json.encode(data.toJson());

class ResponseFareModel extends ResponseFareEntity {
  const ResponseFareModel({
    required String? status,
    required int? idExpense,
    required String? expenseStatus,
  }) : super(
          status: status,
          idExpense: idExpense,
          expenseStatus: expenseStatus,
        );

  factory ResponseFareModel.fromJson(Map<String, dynamic> json) =>
      ResponseFareModel(
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
