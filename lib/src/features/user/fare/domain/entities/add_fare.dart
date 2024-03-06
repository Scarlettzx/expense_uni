import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

class AddFareEntity extends Equatable {
  final String? nameExpense;
  final List<ListExpenseEntity>? listExpense;
  final PlatformFile? file;
  final String? remark;
  final int? typeExpense;
  final String? typeExpenseName;
  final String? lastUpdateDate;
  final int? status;
  final int? totalDistance;
  final int? personalDistance;
  final int? netDistance;
  final int? net;
  final int? idEmpApprover;
  final String? ccEmail;
  final int? idPosition;
  const AddFareEntity({
    required this.nameExpense,
    required this.listExpense,
    required this.file,
    required this.remark,
    required this.typeExpense,
    required this.typeExpenseName,
    required this.lastUpdateDate,
    required this.status,
    required this.totalDistance,
    required this.personalDistance,
    required this.netDistance,
    required this.net,
    required this.idEmpApprover,
    required this.ccEmail,
    required this.idPosition,
  });

  @override
  List<Object?> get props => [
        nameExpense,
        listExpense,
        file,
        remark,
        typeExpense,
        typeExpenseName,
        lastUpdateDate,
        status,
        totalDistance,
        personalDistance,
        netDistance,
        net,
        idEmpApprover,
        ccEmail,
        idPosition,
      ];
}

class ListExpenseEntity extends Equatable {
  final String? date;
  final String? startLocation;
  final String? stopLocation;
  final String? startMile;
  final String? stopMile;
  final int? total;
  final String? personal;
  final int? net;

  const ListExpenseEntity({
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
