import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

class AddExpenseAllowanceEntity extends Equatable {
  final String? nameExpense;
  final int? isInternational;
  final List<ListExpenseEntity>? listExpense;
  final PlatformFile? file;
  final String? remark;
  final int? typeExpense;
  final String? typeExpenseName;
  final DateTime? lastUpdateDate;
  final int? status;
  final int? sumAllowance;
  final int? sumSurplus;
  final int? sumDays;
  final int? sumNet;
  final int? idEmpApprover;
  final List<dynamic>? ccEmail;
  final int? idPosition;

  const AddExpenseAllowanceEntity({
    required this.nameExpense,
    required this.isInternational,
    required this.listExpense,
    required this.file,
    required this.remark,
    required this.typeExpense,
    required this.typeExpenseName,
    required this.lastUpdateDate,
    required this.status,
    required this.sumAllowance,
    required this.sumSurplus,
    required this.sumDays,
    required this.sumNet,
    required this.idEmpApprover,
    required this.ccEmail,
    required this.idPosition,
  });

  @override
  List<Object?> get props => [
        nameExpense,
        isInternational,
        listExpense,
        file,
        remark,
        typeExpense,
        typeExpenseName,
        lastUpdateDate,
        status,
        sumAllowance,
        sumSurplus,
        sumDays,
        sumNet,
        idEmpApprover,
        ccEmail,
        idPosition,
      ];
}

class ListExpenseEntity extends Equatable {
  final String? startDate;
  final String? endDate;
  final String? description;
  final double? countDays;

  const ListExpenseEntity({
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.countDays,
  });

  @override
  List<Object?> get props => [
        startDate,
        endDate,
        description,
        countDays,
      ];

  Map<String, dynamic> toJson() => {
        "startDate": startDate,
        "endDate": endDate,
        "description": description,
        "countDays": countDays,
      };
}
