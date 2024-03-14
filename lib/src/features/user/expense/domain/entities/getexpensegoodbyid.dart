import 'package:equatable/equatable.dart';

class GetExpenseGoodByIdEntity extends Equatable {
  final String? documentId;
  final int? idExpense;
  final int? idExpenseGoods;
  final int? status;
  final String? nameExpense;
  final bool? isVatIncluded;
  final bool? isInternational;
  final String? currency;
  final int? currencyRate;
  final List<ListExpenseGetExpenseGoodByIdEntity>? listExpense;
  final String? remark;
  final String? typeExpenseName;
  final int? expenseType;
  final num? total;
  final num? vat;
  final num? withholding;
  final num? net;
  final List<dynamic>? comments;
  final List<dynamic>? actions;
  final int? idEmpApprover;
  final int? idEmpReviewer;
  final String? approverFirstnameTh;
  final String? approverLastnameTh;
  final String? approverFirstnameEn;
  final String? approverLastnameEn;
  final dynamic ccEmail;
  final FileUrlGetExpenseGoodByIdEntity? fileUrl;

  const GetExpenseGoodByIdEntity({
    required this.documentId,
    required this.idExpense,
    required this.idExpenseGoods,
    required this.status,
    required this.nameExpense,
    required this.isVatIncluded,
    required this.isInternational,
    required this.currency,
    required this.currencyRate,
    required this.listExpense,
    required this.remark,
    required this.typeExpenseName,
    required this.expenseType,
    required this.total,
    required this.vat,
    required this.withholding,
    required this.net,
    required this.comments,
    required this.actions,
    required this.idEmpApprover,
    required this.idEmpReviewer,
    required this.approverFirstnameTh,
    required this.approverLastnameTh,
    required this.approverFirstnameEn,
    required this.approverLastnameEn,
    required this.ccEmail,
    required this.fileUrl,
  });

  @override
  List<Object?> get props => [
        documentId,
        idExpense,
        idExpenseGoods,
        status,
        nameExpense,
        isVatIncluded,
        isInternational,
        currency,
        currencyRate,
        listExpense,
        remark,
        typeExpenseName,
        expenseType,
        total,
        vat,
        withholding,
        net,
        comments,
        actions,
        idEmpApprover,
        idEmpReviewer,
        approverFirstnameTh,
        approverLastnameTh,
        approverFirstnameEn,
        approverLastnameEn,
        ccEmail,
        fileUrl,
      ];
}

class FileUrlGetExpenseGoodByIdEntity extends Equatable {
  final String? url;
  final String? path;

  const FileUrlGetExpenseGoodByIdEntity({
    required this.url,
    required this.path,
  });

  @override
  List<Object?> get props => [
        url,
        path,
      ];

  toJson() {}
}

class ListExpenseGetExpenseGoodByIdEntity extends Equatable {
  final int? idExpenseGoodsItem;
  final String? documentDate;
  final String? service;
  final String? description;
  final int? amount;
  final int? unitPrice;
  final num? net;
  final int? taxPercent;
  final num? tax;
  final num? total;
  final num? totalPrice;
  final int? withholdingPercent;
  final num? withholding;
  final num? unitPriceInternational;
  final num? totalBeforeTaxInternational;
  final num? totalPriceInternational;
  final num? taxInternational;
  final num? withholdingInternational;
  final num? netInternational;

  const ListExpenseGetExpenseGoodByIdEntity({
    required this.idExpenseGoodsItem,
    required this.documentDate,
    required this.service,
    required this.description,
    required this.amount,
    required this.unitPrice,
    required this.net,
    required this.taxPercent,
    required this.tax,
    required this.total,
    required this.totalPrice,
    required this.withholdingPercent,
    required this.withholding,
    required this.unitPriceInternational,
    required this.totalBeforeTaxInternational,
    required this.totalPriceInternational,
    required this.taxInternational,
    required this.withholdingInternational,
    required this.netInternational,
  });

  @override
  List<Object?> get props => [
        idExpenseGoodsItem,
        documentDate,
        service,
        description,
        amount,
        unitPrice,
        net,
        taxPercent,
        tax,
        total,
        totalPrice,
        withholdingPercent,
        withholding,
        unitPriceInternational,
        totalBeforeTaxInternational,
        totalPriceInternational,
        taxInternational,
        withholdingInternational,
        netInternational,
      ];
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
