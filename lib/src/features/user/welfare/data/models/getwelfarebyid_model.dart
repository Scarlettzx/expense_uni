import 'dart:convert';

import 'package:uni_expense/src/features/user/welfare/domain/entities/entities.dart';

GetWelFarebyIdModel getWelFarebyIdModelFromJson(String str) =>
    GetWelFarebyIdModel.fromJson(json.decode(str));

String getWelFarebyIdModelToJson(GetWelFarebyIdModel data) =>
    json.encode(data.toJson());

class GetWelFarebyIdModel extends GetWelfareByIdEntity {
  const GetWelFarebyIdModel({
    required String? documentId,
    required int? idExpense,
    required int? idExpenseWelfare,
    required int? status,
    required String? nameExpense,
    required List<ListExpenseWelfareModel>? listExpense,
    required String? remark,
    required String? typeExpenseName,
    required int? expenseType,
    required num? total,
    required num? net,
    required dynamic withdrawal,
    required dynamic difference,
    required dynamic helpingSurplus,
    required String? documentDate,
    required String? type,
    required String? location,
    required List<dynamic>? comments,
    required List<dynamic>? actions,
    required bool? isUseForFamilyMember,
    required int? idFamily,
    required String? relation,
    required int? idEmployees,
    required String? userName,
    required int? suggestedIdRightsManage,
    required FileUrlWelfareModel? fileUrl,
  }) : super(
          documentId: documentId,
          idExpense: idExpense,
          idExpenseWelfare: idExpenseWelfare,
          status: status,
          nameExpense: nameExpense,
          listExpense: listExpense,
          remark: remark,
          typeExpenseName: typeExpenseName,
          expenseType: expenseType,
          total: total,
          net: net,
          withdrawal: withdrawal,
          difference: difference,
          helpingSurplus: helpingSurplus,
          documentDate: documentDate,
          type: type,
          location: location,
          comments: comments,
          actions: actions,
          isUseForFamilyMember: isUseForFamilyMember,
          idFamily: idFamily,
          relation: relation,
          idEmployees: idEmployees,
          userName: userName,
          suggestedIdRightsManage: suggestedIdRightsManage,
          fileUrl: fileUrl,
        );

  factory GetWelFarebyIdModel.fromJson(Map<String, dynamic> json) =>
      GetWelFarebyIdModel(
        documentId: json["documentId"],
        idExpense: json["idExpense"],
        idExpenseWelfare: json["idExpenseWelfare"],
        status: json["status"],
        nameExpense: json["nameExpense"],
        listExpense: json["listExpense"] == null
            ? []
            : List<ListExpenseWelfareModel>.from(json["listExpense"]!
                .map((x) => ListExpenseWelfareModel.fromJson(x))),
        remark: json["remark"],
        typeExpenseName: json["typeExpenseName"],
        expenseType: json["expenseType"],
        total: json["total"],
        net: json["net"],
        withdrawal: json["withdrawal"],
        difference: json["difference"],
        helpingSurplus: json["helpingSurplus"],
        documentDate: json["documentDate"],
        type: json["type"],
        location: json["location"],
        comments: json["comments"] == null
            ? []
            : List<dynamic>.from(json["comments"]!.map((x) => x)),
        actions: json["actions"] == null
            ? []
            : List<dynamic>.from(json["actions"]!.map((x) => x)),
        isUseForFamilyMember: json["isUseForFamilyMember"],
        idFamily: json["idFamily"],
        relation: json["relation"],
        idEmployees: json["idEmployees"],
        userName: json["userName"],
        suggestedIdRightsManage: json["suggestedIdRightsManage"],
        fileUrl: json["fileURL"] == null
            ? null
            : FileUrlWelfareModel.fromJson(json["fileURL"]),
      );

  Map<String, dynamic> toJson() => {
        "documentId": documentId,
        "idExpense": idExpense,
        "idExpenseWelfare": idExpenseWelfare,
        "status": status,
        "nameExpense": nameExpense,
        "listExpense": listExpense == null
            ? []
            : List<dynamic>.from(listExpense!.map((x) => x.toJson())),
        "remark": remark,
        "typeExpenseName": typeExpenseName,
        "expenseType": expenseType,
        "total": total,
        "net": net,
        "withdrawal": withdrawal,
        "difference": difference,
        "helpingSurplus": helpingSurplus,
        "documentDate": documentDate,
        "type": type,
        "location": location,
        "comments":
            comments == null ? [] : List<dynamic>.from(comments!.map((x) => x)),
        "actions":
            actions == null ? [] : List<dynamic>.from(actions!.map((x) => x)),
        "isUseForFamilyMember": isUseForFamilyMember,
        "idFamily": idFamily,
        "relation": relation,
        "idEmployees": idEmployees,
        "userName": userName,
        "suggestedIdRightsManage": suggestedIdRightsManage,
        "fileURL": fileUrl?.toJson(),
      };
}

class FileUrlWelfareModel extends FileUrlWelfareEntity {
  const FileUrlWelfareModel({
    required String? url,
    required String? path,
  }) : super(
          url: url,
          path: path,
        );

  factory FileUrlWelfareModel.fromJson(Map<String, dynamic> json) =>
      FileUrlWelfareModel(
        url: json["URL"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "URL": url,
        "path": path,
      };
}

class ListExpenseWelfareModel extends ListExpenseWelfareEntity {
  const ListExpenseWelfareModel({
    required int? idExpenseWelfareItem,
    required String? description,
    required num? price,
    required dynamic withdrawablePrice,
    required dynamic difference,
  }) : super(
          idExpenseWelfareItem: idExpenseWelfareItem,
          description: description,
          price: price,
          withdrawablePrice: withdrawablePrice,
          difference: difference,
        );

  factory ListExpenseWelfareModel.fromJson(Map<String, dynamic> json) =>
      ListExpenseWelfareModel(
        idExpenseWelfareItem: json["idExpenseWelfareItem"],
        description: json["description"],
        price: json["price"],
        withdrawablePrice: json["withdrawablePrice"],
        difference: json["difference"],
      );

  Map<String, dynamic> toJson() => {
        "idExpenseWelfareItem": idExpenseWelfareItem,
        "description": description,
        "price": price,
        "withdrawablePrice": withdrawablePrice,
        "difference": difference,
      };
}
