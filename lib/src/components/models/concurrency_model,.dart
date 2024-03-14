import 'dart:convert';

List<ConcurrencyModel> concurrencyModelFromJson(String str) =>
    List<ConcurrencyModel>.from(
        json.decode(str).map((x) => ConcurrencyModel.fromJson(x)));

String concurrencyModelToJson(List<ConcurrencyModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ConcurrencyModel {
  String? label;
  String? code;
  String? unit;

  ConcurrencyModel({
    this.label,
    this.code,
    this.unit,
  });

  factory ConcurrencyModel.fromJson(Map<String, dynamic> json) =>
      ConcurrencyModel(
        label: json["label"],
        code: json["code"],
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "code": code,
        "unit": unit,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConcurrencyModel &&
          runtimeType == other.runtimeType &&
          code == other.code;

  @override
  int get hashCode => code.hashCode;
}

List<ConcurrencyModel>? loadConcurrencyData(String jsonString) {
  return concurrencyModelFromJson(jsonString);
}

// int? findCurrencyIndex(String? targetUnit, List<ConcurrencyModel>? currencies) {
//   if (targetUnit == null || currencies == null) return null;

//   for (int i = 0; i < currencies.length; i++) {
//     if (currencies[i].unit == targetUnit) {
//       return i;
//     }
//   }

//   return null;
// }

// String? findMatchingUnitIndex(String? targetCurrency, String jsonString) {
//   List<ConcurrencyModel>? currencies = loadConcurrencyData(jsonString);
//   int? matchingIndex = findCurrencyIndex(targetCurrency, currencies);
//   return matchingIndex != null ? currencies![matchingIndex].unit : null;
// }
