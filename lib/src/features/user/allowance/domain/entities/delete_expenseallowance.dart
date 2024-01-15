import 'package:equatable/equatable.dart';

class DeleteExpenseAllowance extends Equatable {
  final String? filePath;
  final int? idExpense;
  final int? idExpenseAllowance;
  final bool? isAttachFile;
  final List<int>? listExpense;

  const DeleteExpenseAllowance(
      {required this.filePath,
      required this.idExpense,
      required this.idExpenseAllowance,
      required this.isAttachFile,
      required this.listExpense});

  @override
  List<Object?> get props => [
        filePath,
        idExpense,
        idExpenseAllowance,
        isAttachFile,
        listExpense,
      ];
}
