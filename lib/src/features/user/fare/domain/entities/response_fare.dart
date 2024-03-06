import 'package:equatable/equatable.dart';

class ResponseFareEntity extends Equatable {
  final String? status;
  final int? idExpense;
  final String? expenseStatus;

  const ResponseFareEntity(
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
