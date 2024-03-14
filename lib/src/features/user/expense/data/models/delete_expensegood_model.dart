import 'dart:convert';

import '../../domain/entities/entities.dart';

DeleteDraftExpenseGoodModel doDeleteExpenseGoodModelFromJson(String str) =>
    DeleteDraftExpenseGoodModel.fromJson(json.decode(str));

String doDeleteExpenseGoodModelToJson(DeleteDraftExpenseGoodModel data) =>
    json.encode(data.toJson());

class DeleteDraftExpenseGoodModel extends DeleteDraftExpenseGoodEntity {
  const DeleteDraftExpenseGoodModel({
    required super.filePath,
    required super.idExpense,
    required super.idExpenseGoods,
    required super.isAttachFile,
    required super.listExpense,
  });
  factory DeleteDraftExpenseGoodModel.fromJson(Map<String, dynamic> json) =>
      DeleteDraftExpenseGoodModel(
        filePath: json["filePath"],
        idExpense: json["idExpense"],
        idExpenseGoods: json["idExpenseExpenseGood"],
        isAttachFile: json["isAttachFile"],
        listExpense: json["listExpense"] == null
            ? []
            : List<int>.from(json["listExpense"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "filePath": filePath,
        "idExpense": idExpense,
        "idExpenseGoods": idExpenseGoods,
        "isAttachFile": isAttachFile,
        "listExpense": listExpense == null
            ? []
            : List<dynamic>.from(listExpense!.map((x) => x)),
      };
}
