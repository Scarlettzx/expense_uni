// To parse this JSON data, do
//
//     final responseEditDraftAllowanceModel = responseEditDraftAllowanceModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/entities.dart';

ResponseEditDraftAllowanceModel responseEditDraftAllowanceModelFromJson(
        String str) =>
    ResponseEditDraftAllowanceModel.fromJson(json.decode(str));

String responseEditDraftAllowanceModelToJson(
        ResponseEditDraftAllowanceModel data) =>
    json.encode(data.toJson());

class ResponseEditDraftAllowanceModel extends ResponseEditDraftAllowanceEntity{
const ResponseEditDraftAllowanceModel({required super.status, required super.expenseStatus});

  factory ResponseEditDraftAllowanceModel.fromJson(Map<String, dynamic> json) =>
      ResponseEditDraftAllowanceModel(
        status: json["status"],
        expenseStatus: json["expenseStatus"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "expenseStatus": expenseStatus,
      };
}
