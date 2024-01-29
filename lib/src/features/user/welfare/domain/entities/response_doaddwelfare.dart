import 'package:equatable/equatable.dart';

class ResponseWelfareEntity extends Equatable {
  final String? status;
  final int? idExpense;
  final String? expenseStatus;

  const ResponseWelfareEntity(
      {required this.status,
      required this.idExpense,
      required this.expenseStatus});

  @override
  List<Object?> get props => [
        status,
        idExpense,
        expenseStatus,
      ];
}
