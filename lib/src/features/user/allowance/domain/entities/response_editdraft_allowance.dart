import 'package:equatable/equatable.dart';

class ResponseEditDraftAllowanceEntity extends Equatable {
  final String? status;
  final String? expenseStatus;

  const ResponseEditDraftAllowanceEntity({
    required this.status,
    required this.expenseStatus,
  });

  @override
  List<Object?> get props => [
        status,
        expenseStatus,
      ];
}
