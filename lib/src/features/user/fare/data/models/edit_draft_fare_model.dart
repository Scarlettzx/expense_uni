import 'dart:convert';

import 'package:file_picker/file_picker.dart';

import '../../domain/entities/entities.dart';

EditDraftFareModel editDraftFareModelFromJson(String str) =>
    EditDraftFareModel.fromJson(json.decode(str));

String editDraftFareModelToJson(EditDraftFareModel data) =>
    json.encode(data.toJson());

class EditDraftFareModel extends EditDraftFareEntity {
  const EditDraftFareModel({
    required int? idExpense,
    required int? idExpenseMileage,
    required String? documentId,
    required String? nameExpense,
    required List<ListExpenseEditFareModel>? listExpense,
    required String? remark,
    required PlatformFile? file,
    required int? typeExpense,
    required String? typeExpenseName,
    required String? lastUpdateDate,
    required int? status,
    required int? totalDistance,
    required int? personalDistance,
    required int? netDistance,
    required int? net,
    required dynamic comment,
    required List<int>? deletedItem,
    required int? idEmpApprover,
  }) : super(
          idExpense: idExpense,
          idExpenseMileage: idExpenseMileage,
          documentId: documentId,
          nameExpense: nameExpense,
          listExpense: listExpense,
          file: file,
          remark: remark,
          typeExpense: typeExpense,
          typeExpenseName: typeExpenseName,
          lastUpdateDate: lastUpdateDate,
          status: status,
          totalDistance: totalDistance,
          personalDistance: personalDistance,
          netDistance: netDistance,
          net: net,
          comment: comment,
          deletedItem: deletedItem,
          idEmpApprover: idEmpApprover,
        );

  factory EditDraftFareModel.fromJson(Map<String, dynamic> json) =>
      EditDraftFareModel(
        idExpense: json["idExpense"],
        idExpenseMileage: json["idExpenseMileage"],
        documentId: json["documentId"],
        nameExpense: json["nameExpense"],
        listExpense: json["listExpense"] == null
            ? []
            : List<ListExpenseEditFareModel>.from(json["listExpense"]!
                .map((x) => ListExpenseEditFareModel.fromJson(x))),
        file: json["file"],
        remark: json["remark"],
        typeExpense: json["typeExpense"],
        typeExpenseName: json["typeExpenseName"],
        lastUpdateDate: json["lastUpdateDate"],
        status: json["status"],
        totalDistance: json["totalDistance"],
        personalDistance: json["personalDistance"],
        netDistance: json["netDistance"],
        net: json["net"],
        comment: json["comment"],
        deletedItem: json["deletedItem"] == null
            ? []
            : List<int>.from(json["deletedItem"]!.map((x) => x)),
        idEmpApprover: json["idEmpApprover"],
      );

  Map<String, dynamic> toJson() => {
        "idExpense": idExpense,
        "idExpenseMileage": idExpenseMileage,
        "documentId": documentId,
        "nameExpense": nameExpense,
        "listExpense": listExpense == null
            ? []
            : List<dynamic>.from(listExpense!.map((x) => x.toJson())),
        "file": file,
        "remark": remark,
        "typeExpense": typeExpense,
        "typeExpenseName": typeExpenseName,
        "lastUpdateDate": lastUpdateDate,
        "status": status,
        "totalDistance": totalDistance,
        "personalDistance": personalDistance,
        "netDistance": netDistance,
        "net": net,
        "comment": comment,
        "deletedItem": deletedItem == null
            ? []
            : List<dynamic>.from(deletedItem!.map((x) => x)),
        "idEmpApprover": idEmpApprover,
      };
}

class ListExpenseEditFareModel extends ListExpenseEditFareEntity {
  const ListExpenseEditFareModel({
    required int? idExpenseMileageItem,
    required String? date,
    required String? startLocation,
    required String? stopLocation,
    required int? startMile,
    required int? stopMile,
    required int? total,
    required int? personal,
    required int? net,
  }) : super(
          idExpenseMileageItem: idExpenseMileageItem,
          date: date,
          startLocation: startLocation,
          stopLocation: stopLocation,
          startMile: startMile,
          stopMile: stopMile,
          total: total,
          personal: personal,
          net: net,
        );

  factory ListExpenseEditFareModel.fromJson(Map<String, dynamic> json) =>
      ListExpenseEditFareModel(
        idExpenseMileageItem: json["idExpenseMileageItem"],
        date: json["date"],
        startLocation: json["startLocation"],
        stopLocation: json["stopLocation"],
        startMile: json["startMile"],
        stopMile: json["stopMile"],
        total: json["total"],
        personal: json["personal"],
        net: json["net"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "idExpenseMileageItem": idExpenseMileageItem,
        "date": date,
        "startLocation": startLocation,
        "stopLocation": stopLocation,
        "startMile": startMile,
        "stopMile": stopMile,
        "total": total,
        "personal": personal,
        "net": net,
      };
}
