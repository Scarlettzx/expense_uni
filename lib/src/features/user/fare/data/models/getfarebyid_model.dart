import 'dart:convert';

import 'package:uni_expense/src/features/user/fare/domain/entities/entities.dart';

GetFareByIdModel getFareByIdModelFromJson(String str) =>
    GetFareByIdModel.fromJson(json.decode(str));

String getFareByIdModelToJson(GetFareByIdModel data) =>
    json.encode(data.toJson());

class GetFareByIdModel extends GetFareByIdEntity {
  const GetFareByIdModel({
    required String? documentId,
    required int? idExpense,
    required int? idExpenseMileage,
    required int? status,
    required String? nameExpense,
    required List<ListExpenseFareModel>? listExpense,
    required String? remark,
    required String? typeExpenseName,
    required int? expenseType,
    required int? totalDistance,
    required int? personalDistance,
    required int? netDistance,
    required int? net,
    required List<dynamic>? comments,
    required List<dynamic>? actions,
    required int? idEmpApprover,
    required String? approverFirstnameTh,
    required String? approverLastnameTh,
    required String? approverFirstnameEn,
    required String? approverLastnameEn,
    required FileUrlModel? fileUrl,
  }) : super(
          documentId: documentId,
          idExpense: idExpense,
          idExpenseMileage: idExpenseMileage,
          status: status,
          nameExpense: nameExpense,
          listExpense: listExpense,
          remark: remark,
          typeExpenseName: typeExpenseName,
          expenseType: expenseType,
          totalDistance: totalDistance,
          personalDistance: personalDistance,
          netDistance: netDistance,
          net: net,
          comments: comments,
          actions: actions,
          idEmpApprover: idEmpApprover,
          approverFirstnameTh: approverFirstnameTh,
          approverLastnameTh: approverLastnameTh,
          approverFirstnameEn: approverFirstnameEn,
          approverLastnameEn: approverLastnameEn,
          fileUrl: fileUrl,
        );

  factory GetFareByIdModel.fromJson(Map<String, dynamic> json) =>
      GetFareByIdModel(
        documentId: json["documentId"],
        idExpense: json["idExpense"],
        idExpenseMileage: json["idExpenseMileage"],
        status: json["status"],
        nameExpense: json["nameExpense"],
        listExpense: json["listExpense"] == null
            ? []
            : List<ListExpenseFareModel>.from(json["listExpense"]!
                .map((x) => ListExpenseFareModel.fromJson(x))),
        remark: json["remark"],
        typeExpenseName: json["typeExpenseName"],
        expenseType: json["expenseType"],
        totalDistance: json["totalDistance"],
        personalDistance: json["personalDistance"],
        netDistance: json["netDistance"],
        net: json["net"],
        comments: json["comments"] == null
            ? []
            : List<dynamic>.from(json["comments"]!.map((x) => x)),
        actions: json["actions"] == null
            ? []
            : List<dynamic>.from(json["actions"]!.map((x) => x)),
        idEmpApprover: json["idEmpApprover"],
        approverFirstnameTh: json["approver_firstname_TH"],
        approverLastnameTh: json["approver_lastname_TH"],
        approverFirstnameEn: json["approver_firstname_EN"],
        approverLastnameEn: json["approver_lastname_EN"],
        fileUrl: json["fileURL"] == null
            ? null
            : FileUrlModel.fromJson(json["fileURL"]),
      );

  Map<String, dynamic> toJson() => {
        "documentId": documentId,
        "idExpense": idExpense,
        "idExpenseMileage": idExpenseMileage,
        "status": status,
        "nameExpense": nameExpense,
        "listExpense": listExpense == null
            ? []
            : List<dynamic>.from(listExpense!.map((x) => x.toJson())),
        "remark": remark,
        "typeExpenseName": typeExpenseName,
        "expenseType": expenseType,
        "totalDistance": totalDistance,
        "personalDistance": personalDistance,
        "netDistance": netDistance,
        "net": net,
        "comments":
            comments == null ? [] : List<dynamic>.from(comments!.map((x) => x)),
        "actions":
            actions == null ? [] : List<dynamic>.from(actions!.map((x) => x)),
        "idEmpApprover": idEmpApprover,
        "approver_firstname_TH": approverFirstnameTh,
        "approver_lastname_TH": approverLastnameTh,
        "approver_firstname_EN": approverFirstnameEn,
        "approver_lastname_EN": approverLastnameEn,
      };
}

class ListExpenseFareModel extends ListExpenseFareEntity {
  ListExpenseFareModel({
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

  factory ListExpenseFareModel.fromJson(Map<String, dynamic> json) =>
      ListExpenseFareModel(
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

class FileUrlModel extends FileUrl {
  const FileUrlModel({
    required String? url,
    required String? path,
  }) : super(path: path, url: url);

  factory FileUrlModel.fromJson(Map<String, dynamic> json) => FileUrlModel(
        url: json["URL"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "URL": url,
        "path": path,
      };
}
