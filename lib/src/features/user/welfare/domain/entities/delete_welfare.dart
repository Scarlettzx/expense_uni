import 'package:equatable/equatable.dart';

class DeleteWelfareEntity extends Equatable {
  final String? filePath;
  final int? idExpense;
  final int? idExpenseWelfare;
  final bool? isAttachFile;
  final List<int>? listExpense;

  const DeleteWelfareEntity(
      {required this.filePath,
      required this.idExpense,
      required this.idExpenseWelfare,
      required this.isAttachFile,
      required this.listExpense});

  @override
  List<Object?> get props => [
        filePath,
        idExpense,
        idExpenseWelfare,
        isAttachFile,
        listExpense,
      ];
}
