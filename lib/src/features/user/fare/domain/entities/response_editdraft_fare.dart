import 'package:equatable/equatable.dart';

class ResponseEditDraftFareEntity extends Equatable {
  final String? status;
  final String? expenseStatus;

  const ResponseEditDraftFareEntity({
    required this.status,
    required this.expenseStatus,
  });

  @override
  List<Object?> get props => [
        status,
        expenseStatus,
      ];
}
