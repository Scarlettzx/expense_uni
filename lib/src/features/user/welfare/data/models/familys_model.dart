import 'dart:convert';

import 'package:uni_expense/src/features/user/welfare/domain/entities/entities.dart';

List<FamilysModel> familysModelFromJson(String str) => List<FamilysModel>.from(
    json.decode(str).map((x) => FamilysModel.fromJson(x)));

String familysModelToJson(List<FamilysModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FamilysModel extends FamilysEntity {
  const FamilysModel({
    required int? idFamily,
    required int? idEmployees,
    required String? relationship,
    required DateTime? birthday,
    required String? personalId,
    required String? firstnameTh,
    required String? lastnameTh,
    required String? filename,
    required DateTime? createDate,
    required DateTime? updateDate,
    required int? isApprove,
    required DateTime? approveDate,
    required int? idAdmin,
    required int? isActive,
    required String? imageUrl,
  }) : super(
          idFamily: idFamily,
          idEmployees: idEmployees,
          relationship: relationship,
          birthday: birthday,
          personalId: personalId,
          firstnameTh: firstnameTh,
          lastnameTh: lastnameTh,
          filename: filename,
          createDate: createDate,
          updateDate: updateDate,
          isApprove: isApprove,
          approveDate: approveDate,
          idAdmin: idAdmin,
          isActive: isActive,
          imageUrl: imageUrl,
        );

  factory FamilysModel.fromJson(Map<String, dynamic> json) => FamilysModel(
        idFamily: json["idFamily"],
        idEmployees: json["idEmployees"],
        relationship: json["relationship"],
        birthday:
            json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
        personalId: json["personalID"],
        firstnameTh: json["firstname_TH"],
        lastnameTh: json["lastname_TH"],
        filename: json["filename"],
        createDate: json["createDate"] == null
            ? null
            : DateTime.parse(json["createDate"]),
        updateDate: json["updateDate"] == null
            ? null
            : DateTime.parse(json["updateDate"]),
        isApprove: json["isApprove"],
        approveDate: json["approveDate"] == null
            ? null
            : DateTime.parse(json["approveDate"]),
        idAdmin: json["idAdmin"],
        isActive: json["isActive"],
        imageUrl: json["imageURL"],
      );

  Map<String, dynamic> toJson() => {
        "idFamily": idFamily,
        "idEmployees": idEmployees,
        "relationship": relationship,
        "birthday": birthday?.toIso8601String(),
        "personalID": personalId,
        "firstname_TH": firstnameTh,
        "lastname_TH": lastnameTh,
        "filename": filename,
        "createDate": createDate?.toIso8601String(),
        "updateDate": updateDate?.toIso8601String(),
        "isApprove": isApprove,
        "approveDate": approveDate?.toIso8601String(),
        "idAdmin": idAdmin,
        "isActive": isActive,
        "imageURL": imageUrl,
      };
}
