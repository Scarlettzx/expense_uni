import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

class EditDraftAllowanceEntity extends Equatable {
  final String? nameExpense;
  final int? idExpense;
  final int? idExpenseAllowance;
  final String? documentId;
  final int? isInternational;
  final List<ListExpenseEntity>? listExpense;
  final PlatformFile? file;
  final String? remark;
  final int? typeExpense;
  final String? typeExpenseName;
  final String? lastUpdateDate;
  final int? status;
  final int? sumAllowance;
  final int? sumSurplus;
  final int? sumDays;
  final int? sumNet;
  final dynamic comment;
  final List<dynamic>? deletedItem;
  final int? idEmpApprover;
  const EditDraftAllowanceEntity({
    required this.nameExpense,
    required this.idExpense,
    required this.idExpenseAllowance,
    required this.documentId,
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
    required this.comment,
    required this.deletedItem,
    required this.idEmpApprover,
  });

  @override
  List<Object?> get props => [
        nameExpense,
        idExpense,
        idExpenseAllowance,
        documentId,
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
        comment,
        deletedItem,
        idEmpApprover,
      ];
}

class ListExpenseEntity extends Equatable {
  final int? idExpenseAllowanceItem;
  final String? startDate;
  final String? endDate;
  final String? description;
  final num? countDays;

  const ListExpenseEntity({
    required this.idExpenseAllowanceItem,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.countDays,
  });

  @override
  List<Object?> get props => [
        idExpenseAllowanceItem,
        startDate,
        endDate,
        description,
        countDays,
      ];

  Map<String, dynamic> toJson() => {
        "idExpenseAllowanceItem": idExpenseAllowanceItem,
        "startDate": startDate,
        "endDate": endDate,
        "description": description,
        "countDays": countDays,
      };
}
