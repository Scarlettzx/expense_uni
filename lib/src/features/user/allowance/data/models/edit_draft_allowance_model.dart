import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/edit_draft_allowance.dart';

EditDraftAllowanceModel editDraftAllowanceModelFromJson(String str) =>
    EditDraftAllowanceModel.fromJson(json.decode(str));

String editDraftAllowanceModelToJson(EditDraftAllowanceModel data) =>
    json.encode(data.toJson());

class EditDraftAllowanceModel extends EditDraftAllowanceEntity {
  const EditDraftAllowanceModel({
    required String? nameExpense,
    required int? idExpense,
    required int? idExpenseAllowance,
    required String? documentId,
    required int? isInternational,
    required List<ListExpenseModel>? listExpense,
    required PlatformFile? file,
    required String? remark,
    required int? typeExpense,
    required String? typeExpenseName,
    required String? lastUpdateDate,
    required int? status,
    required int? sumAllowance,
    required int? sumSurplus,
    required int? sumDays,
    required int? sumNet,
    required dynamic comment,
    required List<dynamic>? deletedItem,
    required int? idEmpApprover,
  }) : super(
          nameExpense: nameExpense,
          idExpense: idExpense,
          idExpenseAllowance: idExpenseAllowance,
          documentId: documentId,
          isInternational: isInternational,
          listExpense: listExpense,
          file: file,
          remark: remark,
          typeExpense: typeExpense,
          typeExpenseName: typeExpenseName,
          lastUpdateDate: lastUpdateDate,
          status: status,
          sumAllowance: sumAllowance,
          sumSurplus: sumSurplus,
          sumDays: sumDays,
          sumNet: sumNet,
          comment: comment,
          deletedItem: deletedItem,
          idEmpApprover: idEmpApprover,
        );

  factory EditDraftAllowanceModel.fromJson(Map<String, dynamic> json) =>
      EditDraftAllowanceModel(
        nameExpense: json["nameExpense"],
        idExpense: json["idExpense"],
        idExpenseAllowance: json["idExpenseAllowance"],
        documentId: json["documentId"],
        isInternational: json["isInternational"],
        listExpense: List<ListExpenseModel>.from(
            json["listExpense"].map((x) => ListExpenseModel.fromJson(x))),
        file: json["file"],
        remark: json["remark"],
        typeExpense: json["typeExpense"],
        typeExpenseName: json["typeExpenseName"],
        lastUpdateDate: json["lastUpdateDate"],
        status: json["status"],
        sumAllowance: json["sumAllowance"],
        sumSurplus: json["sumSurplus"],
        sumDays: json["sumDays"],
        sumNet: json["sumNet"],
        comment: json["comment"],
        deletedItem: List<dynamic>.from(json["deletedItem"].map((x) => x)),
        idEmpApprover: json["idEmpApprover"],
      );

  Map<String, dynamic> toJson() => {
        "nameExpense": nameExpense,
        "idExpense": idExpense,
        "idExpenseAllowance": idExpenseAllowance,
        "documentId": documentId,
        "isInternational": isInternational,
        "listExpense": List<dynamic>.from(listExpense!.map((x) => x.toJson())),
        "file": file,
        "remark": remark,
        "typeExpense": typeExpense,
        "typeExpenseName": typeExpenseName,
        "lastUpdateDate": lastUpdateDate,
        "status": status,
        "sumAllowance": sumAllowance,
        "sumSurplus": sumSurplus,
        "sumDays": sumDays,
        "sumNet": sumNet,
        "comment": comment,
        "deletedItem": List<dynamic>.from(deletedItem!.map((x) => x)),
        "idEmpApprover": idEmpApprover,
      };
}

class ListExpenseModel extends ListExpenseEntity {
  const ListExpenseModel({
    required int? idExpenseAllowanceItem,
    required String? startDate,
    required String? endDate,
    required String? description,
    required num? countDays,
  }) : super(
            idExpenseAllowanceItem: idExpenseAllowanceItem,
            startDate: startDate,
            endDate: endDate,
            description: description,
            countDays: countDays);

  factory ListExpenseModel.fromJson(Map<String, dynamic> json) {
    try {
      return ListExpenseModel(
        idExpenseAllowanceItem: json["idExpenseAllowanceItem"],
        startDate:
            json["startDate"]! != null ? json["startDate"].toString() : null,
        endDate: json["endDate"]! != null ? json["endDate"].toString() : null,
        description: json["description"],
        countDays:
            json["countDays"] is num ? json["countDays"].toDouble() : null,
      );
    } catch (e) {
      print("Invalid date format: ${json["startDate"]} or ${json["endDate"]}");
      return ListExpenseModel(
        idExpenseAllowanceItem: json["idExpenseAllowanceItem"],
        startDate: null,
        endDate: null,
        description: json["description"],
        countDays: null,
      );
    }
  }
}
