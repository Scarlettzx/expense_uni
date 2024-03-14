import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uni_expense/src/components/models/concurrency_model,.dart';

class AddExpenseGoodEntity extends Equatable {
  final String? nameExpense;
  final PlatformFile? file;
  final int? isInternational;
  final int? isVatIncluded;
  final String? currency;
  final ConcurrencyModel? currencyItem;
  final int? currencyRate;
  final List<ListExpenseAddExpenseGoodEntity>? listExpense;
  final String? remark;
  final int? typeExpense;
  final String? typeExpenseName;
  final String? lastUpdateDate;
  final int? status;
  final String? total;
  final String? vat;
  final String? withholding;
  final String? net;
  final int? idEmpApprover;
  final int? idEmpReviewer;
  final String? ccEmail;
  final int? idPosition;

  const AddExpenseGoodEntity({
    required this.nameExpense,
    required this.file,
    required this.isInternational,
    required this.isVatIncluded,
    required this.currency,
    required this.currencyItem,
    required this.currencyRate,
    required this.listExpense,
    required this.remark,
    required this.typeExpense,
    required this.typeExpenseName,
    required this.lastUpdateDate,
    required this.status,
    required this.total,
    required this.vat,
    required this.withholding,
    required this.net,
    required this.idEmpApprover,
    required this.idEmpReviewer,
    required this.ccEmail,
    required this.idPosition,
  });
  @override
  List<Object?> get props => [
        nameExpense,
        file,
        isInternational,
        isVatIncluded,
        currency,
        currencyItem,
        currencyRate,
        listExpense,
        remark,
        typeExpense,
        typeExpenseName,
        lastUpdateDate,
        status,
        total,
        vat,
        withholding,
        net,
        idEmpApprover,
        idEmpReviewer,
        ccEmail,
        idPosition,
      ];
}

class ListExpenseAddExpenseGoodEntity extends Equatable {
  final String? documentDate;
  final String? service;
  final String? description;
  final String? amount;
  final String? unitPrice;
  final int? taxPercent;
  final String? tax;
  final String? total;
  final String? totalPrice;
  final String? withholdingPercent;
  final String? withholding;
  final String? net;
  final num? unitPriceInternational;
  final num? taxInternational;
  final num? totalBeforeTaxInternational;
  final num? totalPriceInternational;
  final num? withholdingInternational;
  final num? netInternational;

  const ListExpenseAddExpenseGoodEntity({
    required this.documentDate,
    required this.service,
    required this.description,
    required this.amount,
    required this.unitPrice,
    required this.taxPercent,
    required this.tax,
    required this.total,
    required this.totalPrice,
    required this.withholdingPercent,
    required this.withholding,
    required this.net,
    required this.unitPriceInternational,
    required this.taxInternational,
    required this.totalBeforeTaxInternational,
    required this.totalPriceInternational,
    required this.withholdingInternational,
    required this.netInternational,
  });

  @override
  List<Object?> get props => [
        documentDate,
        service,
        description,
        amount,
        unitPrice,
        taxPercent,
        tax,
        total,
        totalPrice,
        withholdingPercent,
        withholding,
        net,
        unitPriceInternational,
        taxInternational,
        totalBeforeTaxInternational,
        totalPriceInternational,
        withholdingInternational,
        netInternational,
      ];

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
