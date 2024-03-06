import 'package:uni_expense/src/features/user/welfare/domain/entities/entities.dart';

class DeleteWelfareModel extends DeleteWelfareEntity {
  const DeleteWelfareModel({
    required super.filePath,
    required super.idExpense,
    required super.idExpenseWelfare,
    required super.isAttachFile,
    required super.listExpense,
  });
  factory DeleteWelfareModel.fromJson(Map<String, dynamic> json) =>
      DeleteWelfareModel(
        idExpense: json["idExpense"],
        idExpenseWelfare: json["idExpenseWelfare"],
        listExpense: json["listExpense"] == null
            ? []
            : List<int>.from(json["listExpense"]!.map((x) => x)),
        isAttachFile: json["isAttachFile"],
        filePath: json["filePath"],
      );

  Map<String, dynamic> toJson() => {
        "idExpense": idExpense,
        "idExpenseWelfare": idExpenseWelfare,
        "listExpense": listExpense == null
            ? []
            : List<dynamic>.from(listExpense!.map((x) => x)),
        "isAttachFile": isAttachFile,
        "filePath": filePath,
      };
}
