import 'package:equatable/equatable.dart';

class ResponseEditWelfareEntity extends Equatable {
  final String? status;
  final String? expenseStatus;

  const ResponseEditWelfareEntity({
    required this.status,
    required this.expenseStatus,
  });

  @override
  List<Object?> get props => [
        status,
        expenseStatus,
      ];
}
