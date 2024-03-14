import 'package:equatable/equatable.dart';

class AddListExpenseGood extends Equatable {
  final String? idExpenseGoodsItem;
  final String? documentDate;
  final String? service;
  final String? description;
  final num? amount;
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

  const AddListExpenseGood({
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
    this.unitPriceInternational,
    this.totalBeforeTaxInternational,
    this.totalPriceInternational,
    this.taxInternational,
    this.withholdingInternational,
    this.netInternational,
  });

  AddListExpenseGood copyWith({
    String? service,
    String? documentDate,
    String? description,
    num? amount,
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
  }) {
    return AddListExpenseGood(
      idExpenseGoodsItem: idExpenseGoodsItem,
      documentDate: documentDate ?? this.documentDate,
      service: service ?? this.service,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      unitPrice: unitPrice ?? this.unitPrice,
      tax: tax ?? this.tax,
      taxPercent: taxPercent ?? this.taxPercent,
      total: total ?? this.total,
      totalPrice: totalPrice ?? this.totalPrice,
      withholding: withholding ?? this.withholding,
      unitPriceInternational:
          unitPriceInternational ?? this.unitPriceInternational,
      withholdingPercent: withholdingPercent ?? this.withholdingPercent,
      net: net ?? this.net,
      totalBeforeTaxInternational:
          totalBeforeTaxInternational ?? this.totalBeforeTaxInternational,
      totalPriceInternational:
          totalPriceInternational ?? this.totalPriceInternational,
      taxInternational: taxInternational ?? this.taxInternational,
      withholdingInternational:
          withholdingInternational ?? this.withholdingInternational,
      netInternational: netInternational ?? this.netInternational,
    );
  }

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
