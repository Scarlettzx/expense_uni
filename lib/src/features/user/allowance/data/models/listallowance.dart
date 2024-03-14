import 'package:equatable/equatable.dart';

class ListAllowance extends Equatable {
  final String? idExpenseAllowanceItem;
  final String startDate;
  final String endDate;
  final String description;
  final num countDays;

  const ListAllowance({
    required this.idExpenseAllowanceItem,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.countDays,
  });

  ListAllowance copyWith({
    String? idExpenseAllowanceItem,
    String? startDate,
    String? endDate,
    String? description,
    num? countDays,
  }) {
    return ListAllowance(
      idExpenseAllowanceItem:
          idExpenseAllowanceItem ?? this.idExpenseAllowanceItem,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      description: description ?? this.description,
      countDays: countDays ?? this.countDays,
    );
  }

  @override
  List<Object?> get props => [
        idExpenseAllowanceItem,
        startDate,
        endDate,
        description,
        countDays,
      ];
}
