import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:uni_expense/src/features/user/expense/domain/entities/entities.dart';

import '../../../../../components/models/concurrency_model,.dart';

AddExpenseGoodModel addExpenseGoodModelFromJson(String str) =>
    AddExpenseGoodModel.fromJson(json.decode(str));

String addExpenseGoodModelToJson(AddExpenseGoodModel data) =>
    json.encode(data.toJson());

class AddExpenseGoodModel extends AddExpenseGoodEntity {
  const AddExpenseGoodModel({
    required String? nameExpense,
    required PlatformFile? file,
    required int? isInternational,
    required int? isVatIncluded,
    required String? currency,
    required ConcurrencyModel? currencyItem,
    required int? currencyRate,
    required List<ListExpenseAddExpenseGoodModel>? listExpense,
    required String? remark,
    required int? typeExpense,
    required String? typeExpenseName,
    required String? lastUpdateDate,
    required int? status,
    required String? total,
    required String? vat,
    required String? withholding,
    required String? net,
    required int? idEmpApprover,
    required int? idEmpReviewer,
    required String? ccEmail,
    required int? idPosition,
  }) : super(
          nameExpense: nameExpense,
          file: file,
          isInternational: isInternational,
          isVatIncluded: isVatIncluded,
          currency: currency,
          currencyItem: currencyItem,
          currencyRate: currencyRate,
          listExpense: listExpense,
          remark: remark,
          typeExpense: typeExpense,
          typeExpenseName: typeExpenseName,
          lastUpdateDate: lastUpdateDate,
          status: status,
          total: total,
          vat: vat,
          withholding: withholding,
          net: net,
          idEmpApprover: idEmpApprover,
          idEmpReviewer: idEmpReviewer,
          ccEmail: ccEmail,
          idPosition: idPosition,
        );

  factory AddExpenseGoodModel.fromJson(Map<String, dynamic> json) =>
      AddExpenseGoodModel(
        nameExpense: json["nameExpense"],
        file: json["file"],
        isInternational: json["isInternational"],
        isVatIncluded: json["isVatIncluded"],
        currency: json["currency"],
        currencyItem: json["currencyItem"] == null
            ? null
            : ConcurrencyModel.fromJson(json["currencyItem"]),
        currencyRate: json["currencyRate"],
        listExpense: json["listExpense"] == null
            ? []
            : List<ListExpenseAddExpenseGoodModel>.from(json["listExpense"]!
                .map((x) => ListExpenseAddExpenseGoodModel.fromJson(x))),
        remark: json["remark"],
        typeExpense: json["typeExpense"],
        typeExpenseName: json["typeExpenseName"],
        lastUpdateDate: json["lastUpdateDate"],
        status: json["status"],
        total: json["total"],
        vat: json["vat"],
        withholding: json["withholding"],
        net: json["net"],
        idEmpApprover: json["idEmpApprover"],
        idEmpReviewer: json["idEmpReviewer"],
        ccEmail: json["cc_email"],
        idPosition: json["idPosition"],
      );

  Map<String, dynamic> toJson() => {
        "nameExpense": nameExpense,
        "file": file,
        "isInternational": isInternational,
        "isVatIncluded": isVatIncluded,
        "currency": currency,
        "currencyItem": currencyItem?.toJson(),
        "currencyRate": currencyRate,
        "listExpense": listExpense == null
            ? []
            : List<dynamic>.from(listExpense!.map((x) => x.toJson())),
        "remark": remark,
        "typeExpense": typeExpense,
        "typeExpenseName": typeExpenseName,
        "lastUpdateDate": lastUpdateDate,
        "status": status,
        "total": total,
        "vat": vat,
        "withholding": withholding,
        "net": net,
        "idEmpApprover": idEmpApprover,
        "idEmpReviewer": idEmpReviewer,
        "cc_email": ccEmail,
        "idPosition": idPosition,
      };
}

class ListExpenseAddExpenseGoodModel extends ListExpenseAddExpenseGoodEntity {
  const ListExpenseAddExpenseGoodModel({
    String? documentDate,
    String? service,
    String? description,
    String? amount,
    String? unitPrice,
    int? taxPercent,
    String? tax,
    String? total,
    String? totalPrice,
    String? withholdingPercent,
    String? withholding,
    String? net,
    num? unitPriceInternational,
    num? taxInternational,
    num? totalBeforeTaxInternational,
    num? totalPriceInternational,
    num? withholdingInternational,
    num? netInternational,
  }) : super(
          documentDate: documentDate,
          service: service,
          description: description,
          amount: amount,
          unitPrice: unitPrice,
          taxPercent: taxPercent,
          tax: tax,
          total: total,
          totalPrice: totalPrice,
          withholdingPercent: withholdingPercent,
          withholding: withholding,
          net: net,
          unitPriceInternational: unitPriceInternational,
          taxInternational: taxInternational,
          totalBeforeTaxInternational: totalBeforeTaxInternational,
          totalPriceInternational: totalPriceInternational,
          withholdingInternational: withholdingInternational,
          netInternational: netInternational,
        );

  factory ListExpenseAddExpenseGoodModel.fromJson(Map<String, dynamic> json) =>
      ListExpenseAddExpenseGoodModel(
        documentDate: json["documentDate"],
        service: json["service"],
        description: json["description"],
        amount: json["amount"],
        unitPrice: json["unitPrice"],
        taxPercent: json["taxPercent"],
        tax: json["tax"],
        total: json["total"],
        totalPrice: json["totalPrice"],
        withholdingPercent: json["withholdingPercent"],
        withholding: json["withholding"],
        net: json["net"],
        unitPriceInternational: json["unitPriceInternational"],
        taxInternational: json["taxInternational"],
        totalBeforeTaxInternational: json["totalBeforeTaxInternational"],
        totalPriceInternational: json["totalPriceInternational"],
        withholdingInternational: json["withholdingInternational"],
        netInternational: json["netInternational"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "documentDate": documentDate,
        "service": service,
        "description": description,
        "amount": amount,
        "unitPrice": unitPrice,
        "taxPercent": taxPercent,
        "tax": tax,
        "total": total,
        "totalPrice": totalPrice,
        "withholdingPercent": withholdingPercent,
        "withholding": withholding,
        "net": net,
        "unitPriceInternational": unitPriceInternational,
        "taxInternational": taxInternational,
        "totalBeforeTaxInternational": totalBeforeTaxInternational,
        "totalPriceInternational": totalPriceInternational,
        "withholdingInternational": withholdingInternational,
        "netInternational": netInternational,
      };
}
