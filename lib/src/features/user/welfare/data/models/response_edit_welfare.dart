// To parse this JSON data, do
//
//     final responseEditWelfareModel = responseEditWelfareModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/entities.dart';


ResponseEditWelfareModel responseEditWelfareModelFromJson(
        String str) =>
    ResponseEditWelfareModel.fromJson(json.decode(str));

String responseEditWelfareModelToJson(
        ResponseEditWelfareModel data) =>
    json.encode(data.toJson());

class ResponseEditWelfareModel extends ResponseEditWelfareEntity{
const ResponseEditWelfareModel({required super.status, required super.expenseStatus});

  factory ResponseEditWelfareModel.fromJson(Map<String, dynamic> json) =>
      ResponseEditWelfareModel(
        status: json["status"],
        expenseStatus: json["expenseStatus"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "expenseStatus": expenseStatus,
      };
}
