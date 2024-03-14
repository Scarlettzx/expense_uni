import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uni_expense/src/components/models/concurrency_model,.dart';

class EditDraftExpenseGoodEntity extends Equatable {
  final int? idExpense;
  final int? idExpenseGoods;
  final String? documentId;
  final String? nameExpense;
  final int? isInternational;
  final int? isVatIncluded;
  final String? currency;
  final ConcurrencyModel? currencyItem;
  final int? currencyRate;
  final List<ListExpenseEditDraftExpenseGoodEntity>? listExpense;
  final String? remark;
  final PlatformFile? file;
  final int? typeExpense;
  final String? typeExpenseName;
  final String? lastUpdateDate;
  final int? status;
  final double? total;
  final double? vat;
  final double? withholding;
  final double? net;
  final dynamic comment;
  final List<int>? deletedItem;
  final int? idEmpApprover;
  final int? idEmpReviewer;

  const EditDraftExpenseGoodEntity({
    required this.idExpense,
    required this.idExpenseGoods,
    required this.documentId,
    required this.nameExpense,
    required this.isInternational,
    required this.isVatIncluded,
    required this.currency,
    required this.currencyItem,
    required this.currencyRate,
    required this.listExpense,
    required this.remark,
    required this.file,
    required this.typeExpense,
    required this.typeExpenseName,
    required this.lastUpdateDate,
    required this.status,
    required this.total,
    required this.vat,
    required this.withholding,
    required this.net,
    required this.comment,
    required this.deletedItem,
    required this.idEmpApprover,
    required this.idEmpReviewer,
  });

  @override
  List<Object?> get props => [
        idExpense,
        idExpenseGoods,
        documentId,
        nameExpense,
        isInternational,
        isVatIncluded,
        currency,
        currencyItem,
        currencyRate,
        listExpense,
        remark,
        file,
        typeExpense,
        typeExpenseName,
        lastUpdateDate,
        status,
        total,
        vat,
        withholding,
        net,
        comment,
        deletedItem,
        idEmpApprover,
        idEmpReviewer,
      ];
}

class ListExpenseEditDraftExpenseGoodEntity extends Equatable {
  final int? idExpenseGoodsItem;
  final String? documentDate;
  final String? service;
  final String? description;
  final int? amount;
  final int? unitPrice;
  final String? net;
  final int? taxPercent;
  final String? tax;
  final String? total;
  final String? totalPrice;
  final int? withholdingPercent;
  final String? withholding;
  final num? unitPriceInternational;
  final num? taxInternational;
  final num? totalBeforeTaxInternational;
  final num? totalPriceInternational;
  final num? withholdingInternational;
  final num? netInternational;

  const ListExpenseEditDraftExpenseGoodEntity({
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
}
