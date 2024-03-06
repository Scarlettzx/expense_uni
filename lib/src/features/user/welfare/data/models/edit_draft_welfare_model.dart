import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:uni_expense/src/features/user/welfare/domain/entities/entities.dart';

EditWelfareModel editWelfareModelFromJson(String str) =>
    EditWelfareModel.fromJson(json.decode(str));

String editWelfareModelToJson(EditWelfareModel data) =>
    json.encode(data.toJson());

class EditWelfareModel extends EditWelfareEntity {
  const EditWelfareModel({
    required int? idExpense,
    required int? idExpenseWelfare,
    required String? documentId,
    required String? nameExpense,
    required PlatformFile? file,
    required List<ListExpenseEditWelfareModel>? listExpense,
    required String? location,
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
    required dynamic comment,
    required List<int>? deletedItem,
  }) : super(
          idExpense: idExpense,
          idExpenseWelfare: idExpenseWelfare,
          documentId: documentId,
          nameExpense: nameExpense,
          file: file,
          listExpense: listExpense,
          location: location,
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
          comment: comment,
          deletedItem: deletedItem,
        );

  factory EditWelfareModel.fromJson(Map<String, dynamic> json) =>
      EditWelfareModel(
        idExpense: json["idExpense"],
        idExpenseWelfare: json["idExpenseWelfare"],
        documentId: json["documentId"],
        nameExpense: json["nameExpense"],
        file: json["file"],
        listExpense: json["listExpense"] == null
            ? []
            : List<ListExpenseEditWelfareModel>.from(json["listExpense"]!
                .map((x) => ListExpenseEditWelfareModel.fromJson(x))),
        location: json["location"],
        documentDate: json["documentDate"],
        type: json["type"],
        remark: json["remark"],
        typeExpense: json["typeExpense"],
        typeExpenseName: json["typeExpenseName"],
        lastUpdateDate: json["lastUpdateDate"],
        status: json["status"],
        total: json["total"]?.toDouble(),
        net: json["net"]?.toDouble(),
        idFamily: json["idFamily"],
        isUseForFamilyMember: json["isUseForFamilyMember"],
        comment: json["comment"],
        deletedItem: json["deletedItem"] == null
            ? []
            : List<int>.from(json["deletedItem"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "idExpense": idExpense,
        "idExpenseWelfare": idExpenseWelfare,
        "documentId": documentId,
        "nameExpense": nameExpense,
        "listExpense": listExpense == null
            ? []
            : List<dynamic>.from(listExpense!.map((x) => x.toJson())),
        "location": location,
        "documentDate": documentDate,
        "type": type,
        "remark": remark,
        "typeExpense": typeExpense,
        "typeExpenseName": typeExpenseName,
        "lastUpdateDate": lastUpdateDate,
        "status": status,
        "total": total,
        "net": net,
        "idFamily": idFamily,
        "isUseForFamilyMember": isUseForFamilyMember,
        "comment": comment,
        "deletedItem": deletedItem == null
            ? []
            : List<dynamic>.from(deletedItem!.map((x) => x)),
      };
}

class ListExpenseEditWelfareModel extends ListExpenseEditWelfareEntity {
  const ListExpenseEditWelfareModel({
    required int? idExpenseWelfareItem,
    required String? description,
    required String? price,
    required dynamic withdrawablePrice,
    required dynamic difference,
  }) : super(
          idExpenseWelfareItem: idExpenseWelfareItem,
          description: description,
          price: price,
          withdrawablePrice: withdrawablePrice,
          difference: difference,
        );

  factory ListExpenseEditWelfareModel.fromJson(Map<String, dynamic> json) =>
      ListExpenseEditWelfareModel(
        idExpenseWelfareItem: json["idExpenseWelfareItem"],
        description: json["description"],
        price: json["price"],
        withdrawablePrice: json["withdrawablePrice"],
        difference: json["difference"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "idExpenseWelfareItem": idExpenseWelfareItem,
        "description": description,
        "price": price,
        "withdrawablePrice": withdrawablePrice,
        "difference": difference,
      };
}
