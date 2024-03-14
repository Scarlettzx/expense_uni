import 'package:equatable/equatable.dart';

class DeleteDraftExpenseGoodEntity extends Equatable {
  final String? filePath;
  final int? idExpense;
  final int? idExpenseGoods;
  final bool? isAttachFile;
  final List<int>? listExpense;

  const DeleteDraftExpenseGoodEntity({
    required this.filePath,
    required this.idExpense,
    required this.idExpenseGoods,
    required this.isAttachFile,
    required this.listExpense,
  });

  @override
  List<Object?> get props => [
        filePath,
        idExpense,
        idExpenseGoods,
        isAttachFile,
        listExpense,
      ];
}
