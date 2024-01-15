import '../../domain/entities/delete_expenseallowance.dart';
import 'dart:convert';

DeleteExpenseAllowanceModel doDeleteAllowanceModelFromJson(String str) =>
    DeleteExpenseAllowanceModel.fromJson(json.decode(str));

String doDeleteAllowanceModelToJson(DeleteExpenseAllowanceModel data) =>
    json.encode(data.toJson());

class DeleteExpenseAllowanceModel extends DeleteExpenseAllowance {
  const DeleteExpenseAllowanceModel(
      {required super.filePath,
      required super.idExpense,
      required super.idExpenseAllowance,
      required super.isAttachFile,
      required super.listExpense});
  factory DeleteExpenseAllowanceModel.fromJson(Map<String, dynamic> json) =>
      DeleteExpenseAllowanceModel(
        filePath: json["filePath"],
        idExpense: json["idExpense"],
        idExpenseAllowance: json["idExpenseAllowance"],
        isAttachFile: json["isAttachFile"],
        listExpense: json["listExpense"] == null
            ? []
            : List<int>.from(json["listExpense"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "filePath": filePath,
        "idExpense": idExpense,
        "idExpenseAllowance": idExpenseAllowance,
        "isAttachFile": isAttachFile,
        "listExpense": listExpense == null
            ? []
            : List<dynamic>.from(listExpense!.map((x) => x)),
      };
}
