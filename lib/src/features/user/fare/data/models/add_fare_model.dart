import 'package:file_picker/file_picker.dart';
import 'package:uni_expense/src/features/user/fare/domain/entities/entities.dart';
import 'dart:convert';

AddFareModel addFareModelFromJson(String str) =>
    AddFareModel.fromJson(json.decode(str));

String addFareModelToJson(AddFareModel data) => json.encode(data.toJson());

class AddFareModel extends AddFareEntity {
  const AddFareModel({
    required String? nameExpense,
    required List<AddListExpenseModel>? listExpense,
    required PlatformFile? file,
    required String? remark,
    required int? typeExpense,
    required String? typeExpenseName,
    required String? lastUpdateDate,
    required int? status,
    required int? totalDistance,
    required int? personalDistance,
    required int? netDistance,
    required int? net,
    required int? idEmpApprover,
    required String? ccEmail,
    required int? idPosition,
  }) : super(
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
          idEmpApprover: idEmpApprover,
          ccEmail: ccEmail,
          idPosition: idPosition,
        );
  factory AddFareModel.fromJson(Map<String, dynamic> json) => AddFareModel(
        nameExpense: json["nameExpense"],
        listExpense: json["listExpense"] == null
            ? []
            : List<AddListExpenseModel>.from(json["listExpense"]!
                .map((x) => AddListExpenseModel.fromJson(x))),
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
        idEmpApprover: json["idEmpApprover"],
        ccEmail: json["cc_email"],
        idPosition: json["idPosition"],
      );
  Map<String, dynamic> toJson() => {
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
        "idEmpApprover": idEmpApprover,
        "cc_email": ccEmail,
        "idPosition": idPosition,
      };
}

class AddListExpenseModel extends ListExpenseEntity {
  const AddListExpenseModel({
    required String? date,
    required String? startLocation,
    required String? stopLocation,
    required String? startMile,
    required String? stopMile,
    required int? total,
    required String? personal,
    required int? net,
  }) : super(
          date: date,
          startLocation: startLocation,
          stopLocation: stopLocation,
          startMile: startMile,
          stopMile: stopMile,
          total: total,
          personal: personal,
          net: net,
        );

  factory AddListExpenseModel.fromJson(Map<String, dynamic> json) =>
      AddListExpenseModel(
        date: json["date"],
        startLocation: json["startLocation"],
        stopLocation: json["stopLocation"],
        startMile: json["startMile"],
        stopMile: json["stopMile"],
        total: json["total"],
        personal: json["personal"],
        net: json["net"],
      );

  // Map<String, dynamic> toJson() => {
  //       "date": date,
  //       "startLocation": startLocation,
  //       "stopLocation": stopLocation,
  //       "startMile": startMile,
  //       "stopMile": stopMile,
  //       "total": total,
  //       "personal": personal,
  //       "net": net,
  //     };
}
