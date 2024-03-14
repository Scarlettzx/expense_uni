import 'package:uni_expense/src/features/user/fare/domain/entities/entities.dart';

import 'dart:convert';

DeleteDraftFareModel doDeleteFareModelFromJson(String str) =>
    DeleteDraftFareModel.fromJson(json.decode(str));

String doDeleteFareModelToJson(DeleteDraftFareModel data) =>
    json.encode(data.toJson());

class DeleteDraftFareModel extends DeleteDraftFareEntity {
  const DeleteDraftFareModel({
    required super.filePath,
    required super.idExpense,
    required super.idExpenseMileage,
    required super.isAttachFile,
    required super.listExpense,
  });
  factory DeleteDraftFareModel.fromJson(Map<String, dynamic> json) =>
      DeleteDraftFareModel(
        filePath: json["filePath"],
        idExpense: json["idExpense"],
        idExpenseMileage: json["idExpenseFare"],
        isAttachFile: json["isAttachFile"],
        listExpense: json["listExpense"] == null
            ? []
            : List<int>.from(json["listExpense"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "filePath": filePath,
        "idExpense": idExpense,
        "idExpenseMileage": idExpenseMileage,
        "isAttachFile": isAttachFile,
        "listExpense": listExpense == null
            ? []
            : List<dynamic>.from(listExpense!.map((x) => x)),
      };
}
