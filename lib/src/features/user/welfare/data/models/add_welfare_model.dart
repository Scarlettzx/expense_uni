import 'package:file_picker/file_picker.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:uni_expense/src/features/user/welfare/domain/entities/entities.dart';

AddWelfareModel addWelfareModelFromJson(String str) =>
    AddWelfareModel.fromJson(json.decode(str));

// String addWelfareModelToJson(AddWelfareModel data) =>
//     json.encode(data.toJson());

class AddWelfareModel extends AddWelfareEntity {
  const AddWelfareModel({
    required String? nameExpense,
    required List<ListExpenseModelWelfare>? listExpense,
    required String? location,
    required PlatformFile? file,
    required String? documentDate,
    required String? type,
    required String? remark,
    required int? typeExpense,
    required String? typeExpenseName,
    required String? lastUpdateDate,
    required int? status,
    required double? total,
    required double? net,
    required int? idFamily,
    required int? isUseForFamilyMember,
    required String? ccEmail,
    required int? idPosition,
  }) : super(
          nameExpense: nameExpense,
          listExpense: listExpense,
          location: location,
          file: file,
          documentDate: documentDate,
          type: type,
          remark: remark,
          typeExpense: typeExpense,
          typeExpenseName: typeExpenseName,
          lastUpdateDate: lastUpdateDate,
          status: status,
          total: total,
          net: net,
          idFamily: idFamily,
          isUseForFamilyMember: isUseForFamilyMember,
          ccEmail: ccEmail,
          idPosition: idPosition,
        );

  factory AddWelfareModel.fromJson(Map<String, dynamic> json) =>
      AddWelfareModel(
        nameExpense: json["nameExpense"],
        listExpense: List<ListExpenseModelWelfare>.from(json["listExpense"]
            .map((x) => ListExpenseModelWelfare.fromJson(x))),
        location: json["location"],
        file: json["file"],
        documentDate: json["documentDate"],
        type: json["type"],
        remark: json["remark"],
        typeExpense: json["typeExpense"],
        typeExpenseName: json["typeExpenseName"],
        lastUpdateDate: json["lastUpdateDate"],
        status: json["status"],
        total: json["total"],
        net: json["net"],
        idFamily: json["idFamily"],
        isUseForFamilyMember: json["isUseForFamilyMember"],
        ccEmail: json["cc_email"],
        idPosition: json["idPosition"],
      );

  // Map<String, dynamic> toJson() => {
  //       "nameExpense": nameExpense,
  //       "listExpense": List<dynamic>.from(listExpense!.map((x) => x.toJson())),
  //       "location": location,
  //       "file": file,
  //       "documentDate": documentDate,
  //       "type": type,
  //       "remark": remark,
  //       "typeExpense": typeExpense,
  //       "typeExpenseName": typeExpenseName,
  //       "lastUpdateDate": lastUpdateDate,
  //       "status": status,
  //       "total": total,
  //       "net": net,
  //       "idFamily": idFamily,
  //       "isUseForFamilyMember": isUseForFamilyMember,
  //       "cc_email": ccEmail,
  //       "idPosition": idPosition,
  //     };
}

class ListExpenseModelWelfare extends ListExpenseEntity {
  const ListExpenseModelWelfare({
    required String? description,
    required String? price,
  }) : super(
          description: description,
          price: price,
        );

  factory ListExpenseModelWelfare.fromJson(Map<String, dynamic> json) =>
      ListExpenseModelWelfare(
        description: json["description"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "price": price,
      };
}
