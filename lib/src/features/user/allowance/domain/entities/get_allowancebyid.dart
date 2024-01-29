import 'package:equatable/equatable.dart';

class GetExpenseAllowanceByIdEntity extends Equatable {
  final String? documentId;
  final int? idExpense;
  final int? idExpenseAllowance;
  final int? status;
  final String? nameExpense;
  final bool? isInternational;
  final List<ListExpensegetallowancebyidEntity>? listExpense;
  final String? remark;
  final String? typeExpenseName;
  final int? expenseType;
  final int? sumDays;
  final int? sumAllowance;
  final int? sumSurplus;
  final int? net;
  final List<dynamic>? comments;
  final List<dynamic>? actions;
  final int? idEmpApprover;
  final String? approverName;
  final FileUrl? fileUrl;

  const GetExpenseAllowanceByIdEntity({
    required this.documentId,
    required this.idExpense,
    required this.idExpenseAllowance,
    required this.status,
    required this.nameExpense,
    required this.isInternational,
    required this.listExpense,
    required this.remark,
    required this.typeExpenseName,
    required this.expenseType,
    required this.sumDays,
    required this.sumAllowance,
    required this.sumSurplus,
    required this.net,
    required this.comments,
    required this.actions,
    required this.idEmpApprover,
    required this.approverName,
    required this.fileUrl,
  });

  @override
  List<Object?> get props => [
        documentId,
        idExpense,
        idExpenseAllowance,
        status,
        nameExpense,
        isInternational,
        listExpense,
        remark,
        typeExpenseName,
        expenseType,
        sumDays,
        sumAllowance,
        sumSurplus,
        net,
        comments,
        actions,
        idEmpApprover,
        approverName
      ];
}

class ListExpensegetallowancebyidEntity extends Equatable {
  final int? idExpenseAllowanceItem;
  final String? startDate;
  final String? endDate;
  final String? description;
  final int? countDays;

  const ListExpensegetallowancebyidEntity(
      {required this.idExpenseAllowanceItem,
      required this.startDate,
      required this.endDate,
      required this.description,
      required this.countDays});

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
