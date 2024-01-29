import 'package:equatable/equatable.dart';

class EmployeesAllRolesEntity extends Equatable {
  final int? idEmployees;
  final String? employeeId;
  final String? titleTh;
  final String? firstnameTh;
  final String? lastnameTh;
  final String? nicknameTh;
  final String? titleEn;
  final String? firstnameEn;
  final String? lastnameEn;
  final String? nicknameEn;
  final String? telephoneMobile;
  final String? email;
  final int? idCompany;
  final dynamic idBranch;
  final int? idPosition;
  final int? isActive;
  final dynamic createDate;
  final dynamic createBy;
  final DateTime? hiringDate;
  final DateTime? updateDate;
  final int? updateBy;
  final String? positionName;
  final String? sectionName;
  final String? departmentName;
  final int? idDepartment;
  final String? divisionName;
  final String? companyName;
  final String? imageName;
  final String? managerLV1firstnameTh;
  final String? managerLV1lastnameTh;
  final String? managerLV1firstnameEn;
  final String? managerLV1lastnameEn;
  final String? managerLV1email;
  final String? managerLV2firstnameTh;
  final String? managerLV2lastnameTh;
  final String? managerLV2firstnameEn;
  final String? managerLV2lastnameEn;
  final String? managerLV2email;
  final int? idManagerLV1;
  final dynamic idManagerLV2;
  final String? workingType;
  final int? idPaymentType;
  final String? imageProfile;

  const EmployeesAllRolesEntity(
      {required this.idEmployees,
      required this.employeeId,
      required this.titleTh,
      required this.firstnameTh,
      required this.lastnameTh,
      required this.nicknameTh,
      required this.titleEn,
      required this.firstnameEn,
      required this.lastnameEn,
      required this.nicknameEn,
      required this.telephoneMobile,
      required this.email,
      required this.idCompany,
      required this.idBranch,
      required this.idPosition,
      required this.isActive,
      required this.createDate,
      required this.createBy,
      required this.hiringDate,
      required this.updateDate,
      required this.updateBy,
      required this.positionName,
      required this.sectionName,
      required this.departmentName,
      required this.idDepartment,
      required this.divisionName,
      required this.companyName,
      required this.imageName,
      required this.managerLV1firstnameTh,
      required this.managerLV1lastnameTh,
      required this.managerLV1firstnameEn,
      required this.managerLV1lastnameEn,
      required this.managerLV1email,
      required this.managerLV2firstnameTh,
      required this.managerLV2lastnameTh,
      required this.managerLV2firstnameEn,
      required this.managerLV2lastnameEn,
      required this.managerLV2email,
      required this.idManagerLV1,
      required this.idManagerLV2,
      required this.workingType,
      required this.idPaymentType,
      required this.imageProfile});

  @override
  List<Object?> get props => [
        idEmployees,
        employeeId,
        titleTh,
        firstnameTh,
        lastnameTh,
        nicknameTh,
        titleEn,
        firstnameEn,
        lastnameEn,
        nicknameEn,
        telephoneMobile,
        email,
        idCompany,
        idBranch,
        idPosition,
        isActive,
        createDate,
        createBy,
        hiringDate,
        updateDate,
        updateBy,
        positionName,
        sectionName,
        departmentName,
        idDepartment,
        divisionName,
        companyName,
        imageName,
        managerLV1firstnameTh,
        managerLV1lastnameTh,
        managerLV1firstnameEn,
        managerLV1lastnameEn,
        managerLV1email,
        managerLV2firstnameTh,
        managerLV2lastnameTh,
        managerLV2firstnameEn,
        managerLV2lastnameEn,
        managerLV2email,
        idManagerLV1,
        idManagerLV2,
        workingType,
        idPaymentType,
        imageProfile,
      ];
}
