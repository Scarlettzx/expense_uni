import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

class EditDraftFareEntity extends Equatable {
  final int? idExpense;
  final int? idExpenseMileage;
  final String? documentId;
  final String? nameExpense;
  final List<ListExpenseEditFareEntity>? listExpense;
  final String? remark;
  final PlatformFile? file;
  final int? typeExpense;
  final String? typeExpenseName;
  final String? lastUpdateDate;
  final int? status;
  final int? totalDistance;
  final int? personalDistance;
  final int? netDistance;
  final int? net;
  final dynamic comment;
  final List<int>? deletedItem;
  final int? idEmpApprover;

  const EditDraftFareEntity({
    required this.idExpense,
    required this.idExpenseMileage,
    required this.documentId,
    required this.nameExpense,
    required this.listExpense,
    required this.remark,
    required this.file,
    required this.typeExpense,
    required this.typeExpenseName,
    required this.lastUpdateDate,
    required this.status,
    required this.totalDistance,
    required this.personalDistance,
    required this.netDistance,
    required this.net,
    required this.comment,
    required this.deletedItem,
    required this.idEmpApprover,
  });

  @override
  List<Object?> get props => [
        idExpense,
        idExpenseMileage,
        documentId,
        nameExpense,
        listExpense,
        remark,
        file,
        typeExpense,
        typeExpenseName,
        lastUpdateDate,
        status,
        totalDistance,
        personalDistance,
        netDistance,
        net,
        comment,
        deletedItem,
        idEmpApprover,
      ];
}

class ListExpenseEditFareEntity extends Equatable {
  final int? idExpenseMileageItem;
  final String? date;
  final String? startLocation;
  final String? stopLocation;
  final int? startMile;
  final int? stopMile;
  final int? total;
  final int? personal;
  final int? net;

  const ListExpenseEditFareEntity({
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

  @override
  List<Object?> get props => [
        idExpenseMileageItem,
        date,
        startLocation,
        stopLocation,
        startMile,
        stopMile,
        total,
        personal,
        net,
      ];

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
