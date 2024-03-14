import 'package:equatable/equatable.dart';

class ResponseEditDraftExpenseGoodEntity extends Equatable {
  final String? status;
  final String? expenseStatus;

  const ResponseEditDraftExpenseGoodEntity({
    required this.status,
    required this.expenseStatus,
  });

  @override
  List<Object?> get props => [
        status,
        expenseStatus,
      ];
}
