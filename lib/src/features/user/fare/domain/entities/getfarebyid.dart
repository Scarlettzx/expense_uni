import 'package:equatable/equatable.dart';

class GetFareByIdEntity extends Equatable {
  final String? documentId;
  final int? idExpense;
  final int? idExpenseMileage;
  final int? status;
  final String? nameExpense;
  final List<ListExpenseFareEntity>? listExpense;
  final String? remark;
  final String? typeExpenseName;
  final int? expenseType;
  final int? totalDistance;
  final int? personalDistance;
  final int? netDistance;
  final int? net;
  final List<dynamic>? comments;
  final List<dynamic>? actions;
  final int? idEmpApprover;
  final String? approverFirstnameTh;
  final String? approverLastnameTh;
  final String? approverFirstnameEn;
  final String? approverLastnameEn;
  final FileUrl? fileUrl;

  const GetFareByIdEntity({
    required this.documentId,
    required this.idExpense,
    required this.idExpenseMileage,
    required this.status,
    required this.nameExpense,
    required this.listExpense,
    required this.remark,
    required this.typeExpenseName,
    required this.expenseType,
    required this.totalDistance,
    required this.personalDistance,
    required this.netDistance,
    required this.net,
    required this.comments,
    required this.actions,
    required this.idEmpApprover,
    required this.approverFirstnameTh,
    required this.approverLastnameTh,
    required this.approverFirstnameEn,
    required this.approverLastnameEn,
    required this.fileUrl,
  });

  @override
  List<Object?> get props => [
        documentId,
        idExpense,
        idExpenseMileage,
        status,
        nameExpense,
        listExpense,
        remark,
        typeExpenseName,
        expenseType,
        totalDistance,
        personalDistance,
        netDistance,
        net,
        comments,
        actions,
        idEmpApprover,
        approverFirstnameTh,
        approverLastnameTh,
        approverFirstnameEn,
        approverLastnameEn,
        fileUrl,
      ];
}

class ListExpenseFareEntity {
  final int? idExpenseMileageItem;
  final String? date;
  final String? startLocation;
  final String? stopLocation;
  final int? startMile;
  final int? stopMile;
  final int? total;
  final int? personal;
  final int? net;

  ListExpenseFareEntity({
    required this.idExpenseMileageItem,
    required this.date,
    required this.startLocation,
    required this.stopLocation,
    required this.startMile,
    required this.stopMile,
    required this.total,
    required this.personal,
    required this.net,
  });
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

class FileUrl extends Equatable {
  final String? url;
  final String? path;

  const FileUrl({
    required this.url,
    required this.path,
  });

  @override
  List<Object?> get props => [
        url,
        path,
      ];
}
