import 'dart:convert';

import 'package:uni_expense/src/features/user/familyrights/domain/entities/entities.dart';

List<GetAllRightsEmployeeFamilyModel> getAllRightsEmployeeFamilyModelFromJson(
        String str) =>
    List<GetAllRightsEmployeeFamilyModel>.from(json
        .decode(str)
        .map((x) => GetAllRightsEmployeeFamilyModel.fromJson(x)));

String getAllRightsEmployeeFamilyModelToJson(
        List<GetAllRightsEmployeeFamilyModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllRightsEmployeeFamilyModel extends GetAllrightsEmployeeFamilyEntity {
  const GetAllRightsEmployeeFamilyModel({
    required String? firstnameTh,
    required String? lastnameTh,
    required String? levelName,
    required int? idLevel,
    required int? idEmploymentType,
    required String? employmentTypeName,
    required String? relationship,
    required int? idEmployees,
    required List<AllRightModel>? allRights,
    required int? idFamily,
    required String? imageUrl,
  }) : super(
          firstnameTh: firstnameTh,
          lastnameTh: lastnameTh,
          levelName: levelName,
          idLevel: idLevel,
          idEmploymentType: idEmploymentType,
          employmentTypeName: employmentTypeName,
          relationship: relationship,
          idEmployees: idEmployees,
          allRights: allRights,
          idFamily: idFamily,
          imageUrl: imageUrl,
        );

  factory GetAllRightsEmployeeFamilyModel.fromJson(Map<String, dynamic> json) =>
      GetAllRightsEmployeeFamilyModel(
        firstnameTh: json["firstname_TH"],
        lastnameTh: json["lastname_TH"],
        levelName: json["levelName"],
        idLevel: json["idLevel"],
        idEmploymentType: json["idEmploymentType"],
        employmentTypeName: json["EmploymentTypeName"],
        relationship: json["relationship"],
        idEmployees: json["idEmployees"],
        allRights: json["allRights"] == null
            ? []
            : List<AllRightModel>.from(
                json["allRights"]!.map((x) => AllRightModel.fromJson(x))),
        idFamily: json["idFamily"],
        imageUrl: json["imageURL"],
      );

  Map<String, dynamic> toJson() => {
        "firstname_TH": firstnameTh,
        "lastname_TH": lastnameTh,
        "levelName": levelName,
        "idLevel": idLevel,
        "idEmploymentType": idEmploymentType,
        "EmploymentTypeName": employmentTypeName,
        "relationship": relationship,
        "idEmployees": idEmployees,
        "allRights": allRights == null
            ? []
            : List<dynamic>.from(allRights!.map((x) => x.toJson())),
        "idFamily": idFamily,
        "imageURL": imageUrl,
      };
}

class AllRightModel extends AllRightEntity {
  const AllRightModel({
    required int? idRightsManage,
    required String? rightsName,
    required int? idEmploymentType,
    required dynamic idLevel,
    required String? principle,
    required int? limit,
    required int? isHelpingSurplus,
    required dynamic limitSelf,
    required int? isHelpingSurplusSelf,
    required dynamic limitCouple,
    required dynamic isHelpingSurplusCouple,
    required dynamic limitParents,
    required dynamic isHelpingSurplusParents,
    required dynamic limitChild,
    required dynamic isHelpingSurplusChild,
    required String? opdPrinciple,
    required dynamic limitOpd,
    required int? isHelpingSurplusOpd,
    required int? opdNumber,
    required int? opdMoneyPerTimes,
    required String? ipdPrinciple,
    required dynamic limitIpd,
    required int? isHelpingSurplusIpd,
    required String? dentalPrinciple,
    required dynamic limitDental,
    required int? isHelpingSurplusDental,
    required int? idCompany,
    required DateTime? createdDate,
    required int? isActive,
    required DateTime? startDate,
    required DateTime? endDate,
    required List<UseForWhoModel>? useForWho,
    required List<DentalModel>? dental,
    required List<IpdModel>? ipd,
    required List<SurplusModel>? surplus,
    required List<dynamic>? surplusSelf,
    required List<dynamic>? surplusChild,
    required List<dynamic>? surplusCouple,
    required List<dynamic>? surplusParents,
    required List<dynamic>? surplusOpd,
    required List<dynamic>? surplusIpd,
    required List<dynamic>? surplusDental,
  }) : super(
          idRightsManage: idRightsManage,
          rightsName: rightsName,
          idEmploymentType: idEmploymentType,
          idLevel: idLevel,
          principle: principle,
          limit: limit,
          isHelpingSurplus: isHelpingSurplus,
          limitSelf: limitSelf,
          isHelpingSurplusSelf: isHelpingSurplusSelf,
          limitCouple: limitCouple,
          isHelpingSurplusCouple: isHelpingSurplusCouple,
          limitParents: limitParents,
          isHelpingSurplusParents: isHelpingSurplusParents,
          limitChild: limitChild,
          isHelpingSurplusChild: isHelpingSurplusChild,
          opdPrinciple: opdPrinciple,
          limitOpd: limitOpd,
          isHelpingSurplusOpd: isHelpingSurplusOpd,
          opdNumber: opdNumber,
          opdMoneyPerTimes: opdMoneyPerTimes,
          ipdPrinciple: ipdPrinciple,
          limitIpd: limitIpd,
          isHelpingSurplusIpd: isHelpingSurplusIpd,
          dentalPrinciple: dentalPrinciple,
          limitDental: limitDental,
          isHelpingSurplusDental: isHelpingSurplusDental,
          idCompany: idCompany,
          createdDate: createdDate,
          isActive: isActive,
          startDate: startDate,
          endDate: endDate,
          useForWho: useForWho,
          dental: dental,
          ipd: ipd,
          surplus: surplus,
          surplusSelf: surplusSelf,
          surplusChild: surplusChild,
          surplusCouple: surplusCouple,
          surplusParents: surplusParents,
          surplusOpd: surplusOpd,
          surplusIpd: surplusIpd,
          surplusDental: surplusDental,
        );

  factory AllRightModel.fromJson(Map<String, dynamic> json) => AllRightModel(
        idRightsManage: json["idRightsManage"],
        rightsName: json["rightsName"],
        idEmploymentType: json["idEmploymentType"],
        idLevel: json["idLevel"],
        principle: json["principle"],
        limit: json["limit"],
        isHelpingSurplus: json["isHelpingSurplus"],
        limitSelf: json["limitSelf"],
        isHelpingSurplusSelf: json["isHelpingSurplusSelf"],
        limitCouple: json["limitCouple"],
        isHelpingSurplusCouple: json["isHelpingSurplusCouple"],
        limitParents: json["limitParents"],
        isHelpingSurplusParents: json["isHelpingSurplusParents"],
        limitChild: json["limitChild"],
        isHelpingSurplusChild: json["isHelpingSurplusChild"],
        opdPrinciple: json["OPD_Principle"],
        limitOpd: json["limitOPD"],
        isHelpingSurplusOpd: json["isHelpingSurplusOPD"],
        opdNumber: json["OPD_Number"],
        opdMoneyPerTimes: json["OPD_MoneyPerTimes"],
        ipdPrinciple: json["IPD_Principle"],
        limitIpd: json["limitIPD"],
        isHelpingSurplusIpd: json["isHelpingSurplusIPD"],
        dentalPrinciple: json["Dental_Principle"],
        limitDental: json["limitDental"],
        isHelpingSurplusDental: json["isHelpingSurplusDental"],
        idCompany: json["idCompany"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        isActive: json["isActive"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        useForWho: json["UseForWho"] == null
            ? []
            : List<UseForWhoModel>.from(
                json["UseForWho"]!.map((x) => UseForWhoModel.fromJson(x))),
        dental: json["Dental"] == null
            ? []
            : List<DentalModel>.from(
                json["Dental"]!.map((x) => DentalModel.fromJson(x))),
        ipd: json["IPD"] == null
            ? []
            : List<IpdModel>.from(
                json["IPD"]!.map((x) => IpdModel.fromJson(x))),
        surplus: json["Surplus"] == null
            ? []
            : List<SurplusModel>.from(
                json["Surplus"]!.map((x) => SurplusModel.fromJson(x))),
        surplusSelf: json["SurplusSelf"] == null
            ? []
            : List<dynamic>.from(json["SurplusSelf"]!.map((x) => x)),
        surplusChild: json["SurplusChild"] == null
            ? []
            : List<dynamic>.from(json["SurplusChild"]!.map((x) => x)),
        surplusCouple: json["SurplusCouple"] == null
            ? []
            : List<dynamic>.from(json["SurplusCouple"]!.map((x) => x)),
        surplusParents: json["SurplusParents"] == null
            ? []
            : List<dynamic>.from(json["SurplusParents"]!.map((x) => x)),
        surplusOpd: json["SurplusOPD"] == null
            ? []
            : List<dynamic>.from(json["SurplusOPD"]!.map((x) => x)),
        surplusIpd: json["SurplusIPD"] == null
            ? []
            : List<dynamic>.from(json["SurplusIPD"]!.map((x) => x)),
        surplusDental: json["SurplusDental"] == null
            ? []
            : List<dynamic>.from(json["SurplusDental"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "idRightsManage": idRightsManage,
        "rightsName": rightsName,
        "idEmploymentType": idEmploymentType,
        "idLevel": idLevel,
        "principle": principle,
        "limit": limit,
        "isHelpingSurplus": isHelpingSurplus,
        "limitSelf": limitSelf,
        "isHelpingSurplusSelf": isHelpingSurplusSelf,
        "limitCouple": limitCouple,
        "isHelpingSurplusCouple": isHelpingSurplusCouple,
        "limitParents": limitParents,
        "isHelpingSurplusParents": isHelpingSurplusParents,
        "limitChild": limitChild,
        "isHelpingSurplusChild": isHelpingSurplusChild,
        "OPD_Principle": opdPrinciple,
        "limitOPD": limitOpd,
        "isHelpingSurplusOPD": isHelpingSurplusOpd,
        "OPD_Number": opdNumber,
        "OPD_MoneyPerTimes": opdMoneyPerTimes,
        "IPD_Principle": ipdPrinciple,
        "limitIPD": limitIpd,
        "isHelpingSurplusIPD": isHelpingSurplusIpd,
        "Dental_Principle": dentalPrinciple,
        "limitDental": limitDental,
        "isHelpingSurplusDental": isHelpingSurplusDental,
        "idCompany": idCompany,
        "createdDate": createdDate?.toIso8601String(),
        "isActive": isActive,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "UseForWho": useForWho == null
            ? []
            : List<dynamic>.from(useForWho!.map((x) => x.toJson())),
        "Dental": dental == null
            ? []
            : List<dynamic>.from(dental!.map((x) => x.toJson())),
        "IPD":
            ipd == null ? [] : List<dynamic>.from(ipd!.map((x) => x.toJson())),
        "Surplus": surplus == null
            ? []
            : List<dynamic>.from(surplus!.map((x) => x.toJson())),
        "SurplusSelf": surplusSelf == null
            ? []
            : List<dynamic>.from(surplusSelf!.map((x) => x)),
        "SurplusChild": surplusChild == null
            ? []
            : List<dynamic>.from(surplusChild!.map((x) => x)),
        "SurplusCouple": surplusCouple == null
            ? []
            : List<dynamic>.from(surplusCouple!.map((x) => x)),
        "SurplusParents": surplusParents == null
            ? []
            : List<dynamic>.from(surplusParents!.map((x) => x)),
        "SurplusOPD": surplusOpd == null
            ? []
            : List<dynamic>.from(surplusOpd!.map((x) => x)),
        "SurplusIPD": surplusIpd == null
            ? []
            : List<dynamic>.from(surplusIpd!.map((x) => x)),
        "SurplusDental": surplusDental == null
            ? []
            : List<dynamic>.from(surplusDental!.map((x) => x)),
      };
}

class DentalModel extends DentalEntity {
  const DentalModel({
    required int? idDental,
    required String? nameList,
    required int? limitList,
  }) : super(
          idDental: idDental,
          nameList: nameList,
          limitList: limitList,
        );

  factory DentalModel.fromJson(Map<String, dynamic> json) => DentalModel(
        idDental: json["idDental"],
        nameList: json["nameList"],
        limitList: json["limitList"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "idDental": idDental,
        "nameList": nameList,
        "limitList": limitList,
      };
}

class IpdModel extends IpdEntity {
  const IpdModel({
    required int? idIpd,
    required String? nameList,
    required int? limitList,
  }) : super(
          idIpd: idIpd,
          nameList: nameList,
          limitList: limitList,
        );

  factory IpdModel.fromJson(Map<String, dynamic> json) => IpdModel(
        idIpd: json["idIPD"],
        nameList: json["nameList"],
        limitList: json["limitList"],
      );

  Map<String, dynamic> toJson() => {
        "idIPD": idIpd,
        "nameList": nameList,
        "limitList": limitList,
      };
}

class SurplusModel extends SurplusEntity {
  const SurplusModel({
    required int? idSurplus,
    required int? numberSurplus,
    required int? surplusPercent,
  }) : super(
          idSurplus: idSurplus,
          numberSurplus: numberSurplus,
          surplusPercent: surplusPercent,
        );

  factory SurplusModel.fromJson(Map<String, dynamic> json) => SurplusModel(
        idSurplus: json["idSurplus"],
        numberSurplus: json["numberSurplus"],
        surplusPercent: json["surplusPercent"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "idSurplus": idSurplus,
        "numberSurplus": numberSurplus,
        "surplusPercent": surplusPercent,
      };
}

class UseForWhoModel extends UseForWhoEntity {
  const UseForWhoModel({
    required int? idUseForWho,
    required String? relationName,
  }) : super(
          idUseForWho: idUseForWho,
          relationName: relationName,
        );

  factory UseForWhoModel.fromJson(Map<String, dynamic> json) => UseForWhoModel(
        idUseForWho: json["idUseForWho"],
        relationName: json["relationName"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "idUseForWho": idUseForWho,
        "relationName": relationName,
      };
}
