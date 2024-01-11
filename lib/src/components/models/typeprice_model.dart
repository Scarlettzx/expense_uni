// To parse this JSON data, do
//
//     final typePriceModel = typePriceModelFromJson(jsonString);

import 'dart:convert';

List<TypePriceModel> typePriceModelFromJson(String str) =>
    List<TypePriceModel>.from(
        json.decode(str).map((x) => TypePriceModel.fromJson(x)));

String typePriceModelToJson(List<TypePriceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TypePriceModel {
  String? type;
  bool? isVatIncluded;
  int? vat;

  TypePriceModel({
    this.type,
    this.isVatIncluded,
    this.vat,
  });

  factory TypePriceModel.fromJson(Map<String, dynamic> json) => TypePriceModel(
        type: json["Type"],
        isVatIncluded: json["isVatIncluded"],
        vat: json["vat"],
      );

  Map<String, dynamic> toJson() => {
        "Type": type,
        "isVatIncluded": isVatIncluded,
        "vat": vat,
      };
}

List<TypePriceModel> loadTypePriceData(String jsonString) {
  return typePriceModelFromJson(jsonString);
}
