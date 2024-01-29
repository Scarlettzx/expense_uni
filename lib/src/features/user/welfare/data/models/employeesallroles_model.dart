import 'dart:convert';
import 'package:uni_expense/src/features/user/welfare/domain/entities/entities.dart';

List<EmployeesAllRolesModel> employeesAllRolesModelFromJson(String str) =>
    List<EmployeesAllRolesModel>.from(
        json.decode(str).map((x) => EmployeesAllRolesModel.fromJson(x)));

String employeesAllRolesModelToJson(List<EmployeesAllRolesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeesAllRolesModel extends EmployeesAllRolesEntity {
  const EmployeesAllRolesModel({
    required int? idEmployees,
    required String? employeeId,
    required String? titleTh,
    required String? firstnameTh,
    required String? lastnameTh,
    required String? nicknameTh,
    required String? titleEn,
    required String? firstnameEn,
    required String? lastnameEn,
    required String? nicknameEn,
    required String? telephoneMobile,
    required String? email,
    required int? idCompany,
    required dynamic idBranch,
    required int? idPosition,
    required int? isActive,
    required dynamic createDate,
    required dynamic createBy,
    required DateTime? hiringDate,
    required DateTime? updateDate,
    required int? updateBy,
    required String? positionName,
    required String? sectionName,
    required String? departmentName,
    required int? idDepartment,
    required String? divisionName,
    required String? companyName,
    required String? imageName,
    required String? managerLV1firstnameTh,
    required String? managerLV1lastnameTh,
    required String? managerLV1firstnameEn,
    required String? managerLV1lastnameEn,
    required String? managerLV1email,
    required String? managerLV2firstnameTh,
    required String? managerLV2lastnameTh,
    required String? managerLV2firstnameEn,
    required String? managerLV2lastnameEn,
    required String? managerLV2email,
    required int? idManagerLV1,
    required dynamic idManagerLV2,
    required String? workingType,
    required int? idPaymentType,
    required String? imageProfile,
  }) : super(
            idEmployees: idEmployees,
            employeeId: employeeId,
            titleTh: titleTh,
            firstnameTh: firstnameTh,
            lastnameTh: lastnameTh,
            nicknameTh: nicknameTh,
            titleEn: titleEn,
            firstnameEn: firstnameEn,
            lastnameEn: lastnameEn,
            nicknameEn: nicknameEn,
            telephoneMobile: telephoneMobile,
            email: email,
            idCompany: idCompany,
            idBranch: idBranch,
            idPosition: idPosition,
            isActive: isActive,
            createDate: createDate,
            createBy: createBy,
            hiringDate: hiringDate,
            updateDate: updateDate,
            updateBy: updateBy,
            positionName: positionName,
            sectionName: sectionName,
            departmentName: departmentName,
            idDepartment: idDepartment,
            divisionName: divisionName,
            companyName: companyName,
            imageName: imageName,
            managerLV1firstnameTh: managerLV1firstnameTh,
            managerLV1lastnameTh: managerLV1lastnameTh,
            managerLV1firstnameEn: managerLV1firstnameEn,
            managerLV1lastnameEn: managerLV1lastnameEn,
            managerLV1email: managerLV1email,
            managerLV2firstnameTh: managerLV2firstnameTh,
            managerLV2lastnameTh: managerLV2lastnameTh,
            managerLV2firstnameEn: managerLV2firstnameEn,
            managerLV2lastnameEn: managerLV2lastnameEn,
            managerLV2email: managerLV2email,
            idManagerLV1: idManagerLV1,
            idManagerLV2: idManagerLV2,
            workingType: workingType,
            idPaymentType: idPaymentType,
            imageProfile: imageProfile);
  factory EmployeesAllRolesModel.fromJson(Map<String, dynamic> json) =>
      EmployeesAllRolesModel(
        idEmployees: json["idEmployees"],
        employeeId: json["employeeID"],
        titleTh: json["title_TH"],
        firstnameTh: json["firstname_TH"],
        lastnameTh: json["lastname_TH"],
        nicknameTh: json["nickname_TH"],
        titleEn: json["title_EN"],
        firstnameEn: json["firstname_EN"],
        lastnameEn: json["lastname_EN"],
        nicknameEn: json["nickname_EN"],
        telephoneMobile: json["telephoneMobile"],
        email: json["email"],
        idCompany: json["idCompany"],
        idBranch: json["idBranch"],
        idPosition: json["idPosition"],
        isActive: json["isActive"],
        createDate: json["createDate"],
        createBy: json["createBy"],
        hiringDate: json["hiringDate"] == null
            ? null
            : DateTime.parse(json["hiringDate"]),
        updateDate: json["updateDate"] == null
            ? null
            : DateTime.parse(json["updateDate"]),
        updateBy: json["updateBy"],
        positionName: json["positionName"],
        sectionName: json["sectionName"],
        departmentName: json["departmentName"],
        idDepartment: json["idDepartment"],
        divisionName: json["divisionName"],
        companyName: json["companyName"],
        imageName: json["imageName"],
        managerLV1firstnameTh: json["managerLV1_firstname_TH"],
        managerLV1lastnameTh: json["managerLV1_lastname_TH"],
        managerLV1firstnameEn: json["managerLV1_firstname_EN"],
        managerLV1lastnameEn: json["managerLV1_lastname_EN"],
        managerLV1email: json["managerLV1_email"],
        managerLV2firstnameTh: json["managerLV2_firstname_TH"],
        managerLV2lastnameTh: json["managerLV2_lastname_TH"],
        managerLV2firstnameEn: json["managerLV2_firstname_EN"],
        managerLV2lastnameEn: json["managerLV2_lastname_EN"],
        managerLV2email: json["managerLV2_email"],
        idManagerLV1: json["idManagerLV1"],
        idManagerLV2: json["idManagerLV2"],
        workingType: json["workingType"],
        idPaymentType: json["idPaymentType"],
        imageProfile: json["imageProfile"],
      );

  Map<String, dynamic> toJson() => {
        "idEmployees": idEmployees,
        "employeeID": employeeId,
        "title_TH": titleTh,
        "firstname_TH": firstnameTh,
        "lastname_TH": lastnameTh,
        "nickname_TH": nicknameTh,
        "title_EN": titleEn,
        "firstname_EN": firstnameEn,
        "lastname_EN": lastnameEn,
        "nickname_EN": nicknameEn,
        "telephoneMobile": telephoneMobile,
        "email": email,
        "idCompany": idCompany,
        "idBranch": idBranch,
        "idPosition": idPosition,
        "isActive": isActive,
        "createDate": createDate,
        "createBy": createBy,
        "hiringDate": hiringDate?.toIso8601String(),
        "updateDate": updateDate?.toIso8601String(),
        "updateBy": updateBy,
        "positionName": positionName,
        "sectionName": sectionName,
        "departmentName": departmentName,
        "idDepartment": idDepartment,
        "divisionName": divisionName,
        "companyName": companyName,
        "imageName": imageName,
        "managerLV1_firstname_TH": managerLV1firstnameTh,
        "managerLV1_lastname_TH": managerLV1lastnameTh,
        "managerLV1_firstname_EN": managerLV1firstnameEn,
        "managerLV1_lastname_EN": managerLV1lastnameEn,
        "managerLV1_email": managerLV1email,
        "managerLV2_firstname_TH": managerLV2firstnameTh,
        "managerLV2_lastname_TH": managerLV2lastnameTh,
        "managerLV2_firstname_EN": managerLV2firstnameEn,
        "managerLV2_lastname_EN": managerLV2lastnameEn,
        "managerLV2_email": managerLV2email,
        "idManagerLV1": idManagerLV1,
        "idManagerLV2": idManagerLV2,
        "workingType": workingType,
        "idPaymentType": idPaymentType,
        "imageProfile": imageProfile,
      };
}
  //  const EmployeesAllRolesModel({
  // required  int? idEmployees,
  // required  String? employeeId,
  // required  String? titleTh,
  // required  String? firstnameTh,
  // required  String? lastnameTh,
  // required  String? nicknameTh,
  // required  String? titleEn,
  // required  String? firstnameEn,
  // required  String? lastnameEn,
  // required  String? nicknameEn,
  // required  String? telephoneMobile,
  // required  String? email,
  // required  int? idCompany,
  // required  int? idBranch,
  // required  int? idPosition,
  // required  int? isActive,
  // required  DateTime? createDate,
  // required  String? createBy,
  // required  DateTime? hiringDate,
  // required  DateTime? updateDate,
  // required  String? updateBy,
  // required  String? positionName,
  // required  String? sectionName,
  // required  String? departmentName,
  // required  int? idDepartment,
  // required  String? divisionName,
  // required  String? companyName,
  // required  String? imagename,
  // required  String? managerLV1firstnameTh,
  // required  String? managerLV1lastnameTh,
  // required  String? managerLV1firstnameEn,
  // required  String? managerLV1lastnameEn,
  // required  String? managerLV2firstnameTh,
  // required  String? managerLV2lastnameTh,
  // required  String? managerLV2firstnameEn,
  // required  String? managerLV2lastnameEn,
  // required  String? managerLV2email,
  // required  int? idManagerLV1,
  // required  int? idManagerLV2,
  // required  String? workingType,
  // required  int? idPaymentType,
  // required  String? imageProfile,
  //  }):super(idEmployees: idEmployees,)

