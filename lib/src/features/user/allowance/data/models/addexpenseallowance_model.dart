// To parse this JSON data, do
//
//     final addExpenseAllowanceModel = addExpenseAllowanceModelFromJson(jsonString);

import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:uni_expense/src/features/user/allowance/domain/entities/entities.dart';

AddExpenseAllowanceModel addExpenseAllowanceModelFromJson(String str) =>
    AddExpenseAllowanceModel.fromJson(json.decode(str));

String addExpenseAllowanceModelToJson(AddExpenseAllowanceModel data) =>
    json.encode(data.toJson());

class AddExpenseAllowanceModel extends AddExpenseAllowanceEntity {
  const AddExpenseAllowanceModel({
    required String? nameExpense,
    required int? isInternational,
    required List<ListExpenseModel>? listExpense,
    required PlatformFile? file,
    required String? remark,
    required int? typeExpense,
    required String? typeExpenseName,
    required DateTime? lastUpdateDate,
    required int? status,
    required int? sumAllowance,
    required int? sumSurplus,
    required int? sumDays,
    required int? sumNet,
    required int? idEmpApprover,
    required List<dynamic>? ccEmail,
    required int? idPosition,
  }) : super(
            nameExpense: nameExpense,
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
            idEmpApprover: idEmpApprover,
            ccEmail: ccEmail,
            idPosition: idPosition);

  factory AddExpenseAllowanceModel.fromJson(Map<String, dynamic> json) =>
      AddExpenseAllowanceModel(
        nameExpense: json["nameExpense"],
        isInternational: json["isInternational"],
        listExpense: json["listExpense"] == null
            ? []
            : List<ListExpenseModel>.from(
                json["listExpense"]!.map((x) => ListExpenseModel.fromJson(x))),
        file: json["file"],
        remark: json["remark"],
        typeExpense: json["typeExpense"],
        typeExpenseName: json["typeExpenseName"],
        lastUpdateDate: json["lastUpdateDate"] is String
            ? DateTime.parse(json["lastUpdateDate"])
            : null,
        status: json["status"],
        sumAllowance: json["sumAllowance"],
        sumSurplus: json["sumSurplus"],
        sumDays: json["sumDays"],
        sumNet: json["sumNet"],
        idEmpApprover: json["idEmpApprover"],
        ccEmail: json["cc_email"],
        idPosition: json["idPosition"],
      );

  Map<String, dynamic> toJson() => {
        "nameExpense": nameExpense,
        "isInternational": isInternational,
        "listExpense": listExpense == null
            ? []
            : List<ListExpenseModel>.from(listExpense!.map((x) => x.toJson())),
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
        "idEmpApprover": idEmpApprover,
        "cc_email": ccEmail,
        "idPosition": idPosition,
      };
}

class ListExpenseModel extends ListExpenseEntity {
  const ListExpenseModel({
    required String? startDate,
    required String? endDate,
    required String? description,
    required double? countDays,
  }) : super(
            startDate: startDate,
            endDate: endDate,
            description: description,
            countDays: countDays);

  factory ListExpenseModel.fromJson(Map<String, dynamic> json) {
    try {
      return ListExpenseModel(
        startDate: json["startDate"],
        endDate: json["endDate"],
        description: json["description"],
        countDays: json["countDays"] is double
            ? json["countDays"]
            : double.parse(json["countDays"]),
      );
    } catch (e) {
      // ในกรณีที่ Format ไม่ถูกต้อง
      // ทำการ handle ตามที่คุณต้องการ
      print("Invalid date format: ${json["startDate"]}");
      return ListExpenseModel(
        startDate: null,
        endDate: null,
        description: json["description"],
        countDays: json["countDays"],
      );
    }
  }
}
