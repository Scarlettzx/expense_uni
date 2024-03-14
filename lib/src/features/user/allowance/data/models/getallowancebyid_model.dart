import 'dart:convert';

import 'package:uni_expense/src/features/user/allowance/domain/entities/entities.dart';

GetExpenseAllowanceByIdModel getExpenseAllowanceByIdModelFromJson(String str) =>
    GetExpenseAllowanceByIdModel.fromJson(json.decode(str));

String getExpenseAllowanceByIdModelToJson(GetExpenseAllowanceByIdModel data) =>
    json.encode(data.toJson());

class GetExpenseAllowanceByIdModel extends GetExpenseAllowanceByIdEntity {
  const GetExpenseAllowanceByIdModel({
    required String? documentId,
    required int? idExpense,
    required int? idExpenseAllowance,
    required int? status,
    required String? nameExpense,
    required bool? isInternational,
    required List<ListExpensegetallowancebyidModel>? listExpense,
    required String? remark,
    required String? typeExpenseName,
    required int? expenseType,
    required int? sumDays,
    required int? sumAllowance,
    required int? sumSurplus,
    required int? net,
    required List<dynamic>? comments,
    required List<dynamic>? actions,
    required int? idEmpApprover,
    required String? approverName,
    required FileUrlModel? fileUrl,
  }) : super(
          documentId: documentId,
          idExpense: idExpense,
          idExpenseAllowance: idExpenseAllowance,
          status: status,
          nameExpense: nameExpense,
          isInternational: isInternational,
          listExpense: listExpense,
          remark: remark,
          typeExpenseName: typeExpenseName,
          expenseType: expenseType,
          sumDays: sumDays,
          sumAllowance: sumAllowance,
          sumSurplus: sumSurplus,
          net: net,
          comments: comments,
          actions: actions,
          idEmpApprover: idEmpApprover,
          approverName: approverName,
          fileUrl: fileUrl,
        );

  factory GetExpenseAllowanceByIdModel.fromJson(Map<String, dynamic> json) =>
      GetExpenseAllowanceByIdModel(
        documentId: json["documentId"],
        idExpense: json["idExpense"],
        idExpenseAllowance: json["idExpenseAllowance"],
        status: json["status"],
        nameExpense: json["nameExpense"],
        isInternational: json["isInternational"],
        listExpense: json["listExpense"] == null
            ? []
            : List<ListExpensegetallowancebyidModel>.from(json["listExpense"]!
                .map((x) => ListExpensegetallowancebyidModel.fromJson(x))),
        remark: json["remark"],
        typeExpenseName: json["typeExpenseName"],
        expenseType: json["expenseType"],
        sumDays: json["sumDays"],
        sumAllowance: json["sumAllowance"],
        sumSurplus: json["sumSurplus"],
        net: json["net"],
        comments: json["comments"] == null
            ? []
            : List<dynamic>.from(json["comments"]!.map((x) => x)),
        actions: json["actions"] == null
            ? []
            : List<dynamic>.from(json["actions"]!.map((x) => x)),
        idEmpApprover: json["idEmpApprover"],
        approverName: json["approverName"],
        fileUrl:
            json["fileURL"] == null ? null : FileUrlModel.fromJson(json["fileURL"]),
      );

  Map<String, dynamic> toJson() => {
        "documentId": documentId,
        "idExpense": idExpense,
        "idExpenseAllowance": idExpenseAllowance,
        "status": status,
        "nameExpense": nameExpense,
        "isInternational": isInternational,
        "listExpense": listExpense == null
            ? []
            : List<dynamic>.from(listExpense!.map((x) => x.toJson())),
        "remark": remark,
        "typeExpenseName": typeExpenseName,
        "expenseType": expenseType,
        "sumDays": sumDays,
        "sumAllowance": sumAllowance,
        "sumSurplus": sumSurplus,
        "net": net,
        "comments":
            comments == null ? [] : List<dynamic>.from(comments!.map((x) => x)),
        "actions":
            actions == null ? [] : List<dynamic>.from(actions!.map((x) => x)),
        "idEmpApprover": idEmpApprover,
        "approverName": approverName,
      };
}

class ListExpensegetallowancebyidModel
    extends ListExpensegetallowancebyidEntity {
  const ListExpensegetallowancebyidModel({
    required int? idExpenseAllowanceItem,
    required String? startDate,
    required String? endDate,
    required String? description,
    required int? countDays,
  }) : super(
            idExpenseAllowanceItem: idExpenseAllowanceItem,
            startDate: startDate,
            endDate: endDate,
            description: description,
            countDays: countDays);

  factory ListExpensegetallowancebyidModel.fromJson(
          Map<String, dynamic> json) =>
      ListExpensegetallowancebyidModel(
        idExpenseAllowanceItem: json["idExpenseAllowanceItem"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        description: json["description"],
        countDays: json["countDays"],
      );
}

class FileUrlModel extends FileUrlGetAllowanceByIdEntity {
  const FileUrlModel({
    required String? url,
    required String? path,
  }) : super(path: path, url: url);

  factory FileUrlModel.fromJson(Map<String, dynamic> json) => FileUrlModel(
        url: json["URL"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "URL": url,
        "path": path,
      };
}
