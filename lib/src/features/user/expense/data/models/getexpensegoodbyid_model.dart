// To parse this JSON data, do
//
//     final getExpenseGoodByIdModel = getExpenseGoodByIdModelFromJson(jsonString);

import 'dart:convert';

import 'package:uni_expense/src/features/user/expense/domain/entities/entities.dart';

GetExpenseGoodByIdModel getExpenseGoodByIdModelFromJson(String str) =>
    GetExpenseGoodByIdModel.fromJson(json.decode(str));

String getExpenseGoodByIdModelToJson(GetExpenseGoodByIdModel data) =>
    json.encode(data.toJson());

class GetExpenseGoodByIdModel extends GetExpenseGoodByIdEntity {
  const GetExpenseGoodByIdModel({
    required String? documentId,
    required int? idExpense,
    required int? idExpenseGoods,
    required int? status,
    required String? nameExpense,
    required bool? isVatIncluded,
    required bool? isInternational,
    required String? currency,
    required int? currencyRate,
    required List<ListExpenseGetExpenseGoodByIdModel>? listExpense,
    required String? remark,
    required String? typeExpenseName,
    required int? expenseType,
    required num? total,
    required num? vat,
    required num? withholding,
    required num? net,
    required List<dynamic>? comments,
    required List<dynamic>? actions,
    required int? idEmpApprover,
    required int? idEmpReviewer,
    required String? approverFirstnameTh,
    required String? approverLastnameTh,
    required String? approverFirstnameEn,
    required String? approverLastnameEn,
    required dynamic ccEmail,
    required FileUrlGetExpenseGoodByIdModel? fileUrl,
  }) : super(
          documentId: documentId,
          idExpense: idExpense,
          idExpenseGoods: idExpenseGoods,
          status: status,
          nameExpense: nameExpense,
          isVatIncluded: isVatIncluded,
          isInternational: isInternational,
          currency: currency,
          currencyRate: currencyRate,
          listExpense: listExpense,
          remark: remark,
          typeExpenseName: typeExpenseName,
          expenseType: expenseType,
          total: total,
          vat: vat,
          withholding: withholding,
          net: net,
          comments: comments,
          actions: actions,
          idEmpApprover: idEmpApprover,
          idEmpReviewer: idEmpReviewer,
          approverFirstnameTh: approverFirstnameTh,
          approverLastnameTh: approverLastnameTh,
          approverFirstnameEn: approverFirstnameEn,
          approverLastnameEn: approverLastnameEn,
          ccEmail: ccEmail,
          fileUrl: fileUrl,
        );

  factory GetExpenseGoodByIdModel.fromJson(Map<String, dynamic> json) =>
      GetExpenseGoodByIdModel(
        documentId: json["documentId"],
        idExpense: json["idExpense"],
        idExpenseGoods: json["idExpenseGoods"],
        status: json["status"],
        nameExpense: json["nameExpense"],
        isVatIncluded: json["isVatIncluded"],
        isInternational: json["isInternational"],
        currency: json["currency"],
        currencyRate: json["currencyRate"],
        listExpense: json["listExpense"] == null
            ? []
            : List<ListExpenseGetExpenseGoodByIdModel>.from(json["listExpense"]!
                .map((x) => ListExpenseGetExpenseGoodByIdModel.fromJson(x))),
        remark: json["remark"],
        typeExpenseName: json["typeExpenseName"],
        expenseType: json["expenseType"],
        total: json["total"],
        vat: json["vat"]?.toDouble(),
        withholding: json["withholding"],
        net: json["net"]?.toDouble(),
        comments: json["comments"] == null
            ? []
            : List<dynamic>.from(json["comments"]!.map((x) => x)),
        actions: json["actions"] == null
            ? []
            : List<dynamic>.from(json["actions"]!.map((x) => x)),
        idEmpApprover: json["idEmpApprover"],
        idEmpReviewer: json["idEmpReviewer"],
        approverFirstnameTh: json["approver_firstname_TH"],
        approverLastnameTh: json["approver_lastname_TH"],
        approverFirstnameEn: json["approver_firstname_EN"],
        approverLastnameEn: json["approver_lastname_EN"],
        ccEmail: (json["cc_email"] == null || json["cc_email"] == "")
            ? []
            : List<String>.from(json["cc_email"].map((x) => x)),
        fileUrl: json["fileURL"] == null
            ? null
            : FileUrlGetExpenseGoodByIdModel.fromJson(json["fileURL"]),
      );

  Map<String, dynamic> toJson() => {
        "documentId": documentId,
        "idExpense": idExpense,
        "idExpenseGoods": idExpenseGoods,
        "status": status,
        "nameExpense": nameExpense,
        "isVatIncluded": isVatIncluded,
        "isInternational": isInternational,
        "currency": currency,
        "currencyRate": currencyRate,
        "listExpense": listExpense == null
            ? []
            : List<dynamic>.from(listExpense!.map((x) => x.toJson())),
        "remark": remark,
        "typeExpenseName": typeExpenseName,
        "expenseType": expenseType,
        "total": total,
        "vat": vat,
        "withholding": withholding,
        "net": net,
        "comments":
            comments == null ? [] : List<dynamic>.from(comments!.map((x) => x)),
        "actions":
            actions == null ? [] : List<dynamic>.from(actions!.map((x) => x)),
        "idEmpApprover": idEmpApprover,
        "idEmpReviewer": idEmpReviewer,
        "approver_firstname_TH": approverFirstnameTh,
        "approver_lastname_TH": approverLastnameTh,
        "approver_firstname_EN": approverFirstnameEn,
        "approver_lastname_EN": approverLastnameEn,
        "cc_email": (ccEmail == null || ccEmail == "")
            ? []
            : List<dynamic>.from(ccEmail!.map((x) => x)),
        "fileURL": fileUrl?.toJson(),
      };
}

class FileUrlGetExpenseGoodByIdModel extends FileUrlGetExpenseGoodByIdEntity {
  const FileUrlGetExpenseGoodByIdModel({
    String? url,
    String? path,
  }) : super(
          url: url,
          path: path,
        );

  factory FileUrlGetExpenseGoodByIdModel.fromJson(Map<String, dynamic> json) =>
      FileUrlGetExpenseGoodByIdModel(
        url: json["URL"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "URL": url,
        "path": path,
      };
}

class ListExpenseGetExpenseGoodByIdModel
    extends ListExpenseGetExpenseGoodByIdEntity {
  const ListExpenseGetExpenseGoodByIdModel({
    int? idExpenseGoodsItem,
    String? documentDate,
    String? service,
    String? description,
    int? amount,
    int? unitPrice,
    num? net,
    int? taxPercent,
    num? tax,
    num? total,
    num? totalPrice,
    int? withholdingPercent,
    num? withholding,
    num? unitPriceInternational,
    num? totalBeforeTaxInternational,
    num? totalPriceInternational,
    num? taxInternational,
    num? withholdingInternational,
    num? netInternational,
  }) : super(
          idExpenseGoodsItem: idExpenseGoodsItem,
          documentDate: documentDate,
          service: service,
          description: description,
          amount: amount,
          unitPrice: unitPrice,
          net: net,
          taxPercent: taxPercent,
          tax: tax,
          total: total,
          totalPrice: totalPrice,
          withholdingPercent: withholdingPercent,
          withholding: withholding,
          unitPriceInternational: unitPriceInternational,
          totalBeforeTaxInternational: totalBeforeTaxInternational,
          totalPriceInternational: totalPriceInternational,
          taxInternational: taxInternational,
          withholdingInternational: withholdingInternational,
          netInternational: netInternational,
        );

  factory ListExpenseGetExpenseGoodByIdModel.fromJson(
          Map<String, dynamic> json) =>
      ListExpenseGetExpenseGoodByIdModel(
        idExpenseGoodsItem: json["idExpenseGoodsItem"],
        documentDate: json["documentDate"],
        service: json["service"],
        description: json["description"],
        amount: json["amount"],
        unitPrice: json["unitPrice"],
        net: json["net"]?.toDouble(),
        taxPercent: json["taxPercent"],
        tax: json["tax"]?.toDouble(),
        total: json["total"],
        totalPrice: json["totalPrice"]?.toDouble(),
        withholdingPercent: json["withholdingPercent"],
        withholding: json["withholding"],
        unitPriceInternational: json["unitPriceInternational"],
        totalBeforeTaxInternational: json["totalBeforeTaxInternational"],
        totalPriceInternational: json["totalPriceInternational"]?.toDouble(),
        taxInternational: json["taxInternational"]?.toDouble(),
        withholdingInternational: json["withholdingInternational"],
        netInternational: json["netInternational"]?.toDouble(),
      );

  @override
  Map<String, dynamic> toJson() => {
        "idExpenseGoodsItem": idExpenseGoodsItem,
        "documentDate": documentDate,
        "service": service,
        "description": description,
        "amount": amount,
        "unitPrice": unitPrice,
        "net": net,
        "taxPercent": taxPercent,
        "tax": tax,
        "total": total,
        "totalPrice": totalPrice,
        "withholdingPercent": withholdingPercent,
        "withholding": withholding,
        "unitPriceInternational": unitPriceInternational,
        "totalBeforeTaxInternational": totalBeforeTaxInternational,
        "totalPriceInternational": totalPriceInternational,
        "taxInternational": taxInternational,
        "withholdingInternational": withholdingInternational,
        "netInternational": netInternational,
      };
}
