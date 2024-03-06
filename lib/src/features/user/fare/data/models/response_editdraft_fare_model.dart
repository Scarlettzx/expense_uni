import 'dart:convert';

import '../../domain/entities/entities.dart';

ResponseEditDraftFareModel responseEditDraftFareModelFromJson(String str) =>
    ResponseEditDraftFareModel.fromJson(json.decode(str));

String responseEditDraftFareModelToJson(ResponseEditDraftFareModel data) =>
    json.encode(data.toJson());

class ResponseEditDraftFareModel extends ResponseEditDraftFareEntity {
  const ResponseEditDraftFareModel(
      {required super.status, required super.expenseStatus});

  factory ResponseEditDraftFareModel.fromJson(Map<String, dynamic> json) =>
      ResponseEditDraftFareModel(
        status: json["status"],
        expenseStatus: json["expenseStatus"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "expenseStatus": expenseStatus,
      };
}
