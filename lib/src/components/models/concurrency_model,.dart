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

List<ConcurrencyModel> loadConcurrencyData(String jsonString) {
  return concurrencyModelFromJson(jsonString);
}
