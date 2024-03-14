import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:uni_expense/src/components/models/concurrency_model,.dart';
import 'package:uni_expense/src/features/user/expense/domain/entities/entities.dart';

EditDraftExpenseGoodModel editDraftExpenseGoodModelFromJson(String str) =>
    EditDraftExpenseGoodModel.fromJson(json.decode(str));

String editDraftExpenseGoodModelToJson(EditDraftExpenseGoodModel data) =>
    json.encode(data.toJson());

class EditDraftExpenseGoodModel extends EditDraftExpenseGoodEntity {
  const EditDraftExpenseGoodModel({
    required int? idExpense,
    required int? idExpenseGoods,
    required String? documentId,
    required String? nameExpense,
    required int? isInternational,
    required int? isVatIncluded,
    required String? currency,
    required ConcurrencyModel? currencyItem,
    required int? currencyRate,
    required List<ListExpenseEditDraftExpenseGoodModel>? listExpense,
    required String? remark,
    required PlatformFile? file,
    required int? typeExpense,
    required String? typeExpenseName,
    required String? lastUpdateDate,
    required int? status,
    required double? total,
    required double? vat,
    required double? withholding,
    required double? net,
    required dynamic comment,
    required List<int>? deletedItem,
    required int? idEmpApprover,
    required int? idEmpReviewer,
  }) : super(
          idExpense: idExpense,
          idExpenseGoods: idExpenseGoods,
          documentId: documentId,
          nameExpense: nameExpense,
          isInternational: isInternational,
          isVatIncluded: isVatIncluded,
          currency: currency,
          currencyItem: currencyItem,
          currencyRate: currencyRate,
          listExpense: listExpense,
          remark: remark,
          file: file,
          typeExpense: typeExpense,
          typeExpenseName: typeExpenseName,
          lastUpdateDate: lastUpdateDate,
          status: status,
          total: total,
          vat: vat,
          withholding: withholding,
          net: net,
          comment: comment,
          deletedItem: deletedItem,
          idEmpApprover: idEmpApprover,
          idEmpReviewer: idEmpReviewer,
        );

  factory EditDraftExpenseGoodModel.fromJson(Map<String, dynamic> json) =>
      EditDraftExpenseGoodModel(
        idExpense: json["idExpense"],
        idExpenseGoods: json["idExpenseGoods"],
        documentId: json["documentId"],
        nameExpense: json["nameExpense"],
        isInternational: json["isInternational"],
        isVatIncluded: json["isVatIncluded"],
        currency: json["currency"],
        currencyItem: json["currencyItem"] == null
            ? null
            : ConcurrencyModel.fromJson(json["currencyItem"]),
        currencyRate: json["currencyRate"],
        listExpense: json["listExpense"] == null
            ? []
            : List<ListExpenseEditDraftExpenseGoodModel>.from(
                json["listExpense"]!.map(
                    (x) => ListExpenseEditDraftExpenseGoodModel.fromJson(x))),
        remark: json["remark"],
        file: json["file"],
        typeExpense: json["typeExpense"],
        typeExpenseName: json["typeExpenseName"],
        lastUpdateDate: json["lastUpdateDate"],
        status: json["status"],
        total: json["total"]?.toDouble(),
        vat: json["vat"]?.toDouble(),
        withholding: json["withholding"]?.toDouble(),
        net: json["net"]?.toDouble(),
        comment: json["comment"],
        deletedItem: json["deletedItem"] == null
            ? []
            : List<int>.from(json["deletedItem"]!.map((x) => x)),
        idEmpApprover: json["idEmpApprover"],
        idEmpReviewer: json["idEmpReviewer"],
      );

  Map<String, dynamic> toJson() => {
        "idExpense": idExpense,
        "idExpenseGoods": idExpenseGoods,
        "documentId": documentId,
        "nameExpense": nameExpense,
        "isInternational": isInternational,
        "isVatIncluded": isVatIncluded,
        "currency": currency,
        "currencyItem": currencyItem?.toJson(),
        "currencyRate": currencyRate,
        "listExpense": listExpense == null
            ? []
            : List<dynamic>.from(listExpense!.map((x) => x.toJson())),
        "remark": remark,
        "file": file,
        "typeExpense": typeExpense,
        "typeExpenseName": typeExpenseName,
        "lastUpdateDate": lastUpdateDate,
        "status": status,
        "total": total,
        "vat": vat,
        "withholding": withholding,
        "net": net,
        "comment": comment,
        "deletedItem": deletedItem == null
            ? []
            : List<dynamic>.from(deletedItem!.map((x) => x)),
        "idEmpApprover": idEmpApprover,
        "idEmpReviewer": idEmpReviewer,
      };
}

class ListExpenseEditDraftExpenseGoodModel
    extends ListExpenseEditDraftExpenseGoodEntity {
  const ListExpenseEditDraftExpenseGoodModel({
    int? idExpenseGoodsItem,
    String? documentDate,
    String? service,
    String? description,
    int? amount,
    int? unitPrice,
    String? net,
    int? taxPercent,
    String? tax,
    String? total,
    String? totalPrice,
    int? withholdingPercent,
    String? withholding,
    num? unitPriceInternational,
    num? taxInternational,
    num? totalBeforeTaxInternational,
    num? totalPriceInternational,
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

  factory ListExpenseEditDraftExpenseGoodModel.fromJson(
          Map<String, dynamic> json) =>
      ListExpenseEditDraftExpenseGoodModel(
        idExpenseGoodsItem: json["idExpenseGoodsItem"],
        documentDate: json["documentDate"],
        service: json["service"],
        description: json["description"],
        amount: json["amount"],
        unitPrice: json["unitPrice"],
        net: json["net"],
        taxPercent: json["taxPercent"],
        tax: json["tax"],
        total: json["total"],
        totalPrice: json["totalPrice"],
        withholdingPercent: json["withholdingPercent"],
        withholding: json["withholding"],
        unitPriceInternational: json["unitPriceInternational"],
        totalBeforeTaxInternational: json["totalBeforeTaxInternational"],
        totalPriceInternational: json["totalPriceInternational"],
        taxInternational: json["taxInternational"],
        withholdingInternational: json["withholdingInternational"],
        netInternational: json["netInternational"],
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
