import 'package:equatable/equatable.dart';

class GetAllrightsEmployeeFamilyEntity extends Equatable {
  final String? firstnameTh;
  final String? lastnameTh;
  final String? levelName;
  final int? idLevel;
  final int? idEmploymentType;
  final String? employmentTypeName;
  final String? relationship;
  final int? idEmployees;
  final List<AllRightEntity>? allRights;
  final int? idFamily;
  final String? imageUrl;

  const GetAllrightsEmployeeFamilyEntity({
    required this.firstnameTh,
    required this.lastnameTh,
    required this.levelName,
    required this.idLevel,
    required this.idEmploymentType,
    required this.employmentTypeName,
    required this.relationship,
    required this.idEmployees,
    required this.allRights,
    required this.idFamily,
    required this.imageUrl,
  });
  @override
  List<Object?> get props => [
        employmentTypeName,
        relationship,
        idEmployees,
        allRights,
        idFamily,
        imageUrl,
      ];
}

class AllRightEntity extends Equatable {
  final int? idRightsManage;
  final String? rightsName;
  final int? idEmploymentType;
  final dynamic idLevel;
  final String? principle;
  final int? limit;
  final int? isHelpingSurplus;
  final dynamic limitSelf;
  final int? isHelpingSurplusSelf;
  final dynamic limitCouple;
  final dynamic isHelpingSurplusCouple;
  final dynamic limitParents;
  final dynamic isHelpingSurplusParents;
  final dynamic limitChild;
  final dynamic isHelpingSurplusChild;
  final String? opdPrinciple;
  final dynamic limitOpd;
  final int? isHelpingSurplusOpd;
  final int? opdNumber;
  final int? opdMoneyPerTimes;
  final String? ipdPrinciple;
  final dynamic limitIpd;
  final int? isHelpingSurplusIpd;
  final String? dentalPrinciple;
  final dynamic limitDental;
  final int? isHelpingSurplusDental;
  final int? idCompany;
  final DateTime? createdDate;
  final int? isActive;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<UseForWhoEntity>? useForWho;
  final List<DentalEntity>? dental;
  final List<IpdEntity>? ipd;
  final List<SurplusEntity>? surplus;
  final List<dynamic>? surplusSelf;
  final List<dynamic>? surplusChild;
  final List<dynamic>? surplusCouple;
  final List<dynamic>? surplusParents;
  final List<dynamic>? surplusOpd;
  final List<dynamic>? surplusIpd;
  final List<dynamic>? surplusDental;

  const AllRightEntity({
    required this.idRightsManage,
    required this.rightsName,
    required this.idEmploymentType,
    required this.idLevel,
    required this.principle,
    required this.limit,
    required this.isHelpingSurplus,
    required this.limitSelf,
    required this.isHelpingSurplusSelf,
    required this.limitCouple,
    required this.isHelpingSurplusCouple,
    required this.limitParents,
    required this.isHelpingSurplusParents,
    required this.limitChild,
    required this.isHelpingSurplusChild,
    required this.opdPrinciple,
    required this.limitOpd,
    required this.isHelpingSurplusOpd,
    required this.opdNumber,
    required this.opdMoneyPerTimes,
    required this.ipdPrinciple,
    required this.limitIpd,
    required this.isHelpingSurplusIpd,
    required this.dentalPrinciple,
    required this.limitDental,
    required this.isHelpingSurplusDental,
    required this.idCompany,
    required this.createdDate,
    required this.isActive,
    required this.startDate,
    required this.endDate,
    required this.useForWho,
    required this.dental,
    required this.ipd,
    required this.surplus,
    required this.surplusSelf,
    required this.surplusChild,
    required this.surplusCouple,
    required this.surplusParents,
    required this.surplusOpd,
    required this.surplusIpd,
    required this.surplusDental,
  });
  @override
  List<Object?> get props => [
        idRightsManage,
        rightsName,
        idEmploymentType,
        idLevel,
        principle,
        limit,
        isHelpingSurplus,
        limitSelf,
        isHelpingSurplusSelf,
        limitCouple,
        isHelpingSurplusCouple,
        limitParents,
        isHelpingSurplusParents,
        limitChild,
        isHelpingSurplusChild,
        opdPrinciple,
        limitOpd,
        isHelpingSurplusOpd,
        opdNumber,
        opdMoneyPerTimes,
        ipdPrinciple,
        limitIpd,
        isHelpingSurplusIpd,
        dentalPrinciple,
        limitDental,
        isHelpingSurplusDental,
        idCompany,
        createdDate,
        isActive,
        startDate,
        endDate,
        useForWho,
        dental,
        ipd,
        surplus,
        surplusSelf,
        surplusChild,
        surplusCouple,
        surplusParents,
        surplusOpd,
        surplusIpd,
        surplusDental,
      ];

  toJson() {}
}

class IpdEntity extends Equatable {
  final int? idIpd;
  final String? nameList;
  final int? limitList;

  const IpdEntity({
    required this.idIpd,
    required this.nameList,
    required this.limitList,
  });
  @override
  List<Object?> get props => [
        idIpd,
        nameList,
        limitList,
      ];

  toJson() {}
}

class DentalEntity extends Equatable {
  final int? idDental;
  final String? nameList;
  final int? limitList;

  const DentalEntity({
    required this.idDental,
    required this.nameList,
    required this.limitList,
  });
  @override
  List<Object?> get props => [
        idDental,
        nameList,
        limitList,
      ];

  toJson() {}
}

class SurplusEntity extends Equatable {
  final int? idSurplus;
  final int? numberSurplus;
  final int? surplusPercent;

  const SurplusEntity({
    required this.idSurplus,
    required this.numberSurplus,
    required this.surplusPercent,
  });
  @override
  List<Object?> get props => [
        idSurplus,
        numberSurplus,
        surplusPercent,
      ];

  toJson() {}
}

class UseForWhoEntity extends Equatable {
  final int? idUseForWho;
  final String? relationName;

  const UseForWhoEntity({
    required this.idUseForWho,
    required this.relationName,
  });

  @override
  List<Object?> get props => [
        idUseForWho,
        relationName,
      ];

  toJson() {}
}
