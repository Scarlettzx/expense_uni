import 'package:equatable/equatable.dart';

class DeleteDraftFareEntity extends Equatable {
  final String? filePath;
  final int? idExpense;
  final int? idExpenseMileage;
  final bool? isAttachFile;
  final List<int>? listExpense;

  const DeleteDraftFareEntity({
    required this.filePath,
    required this.idExpense,
    required this.idExpenseMileage,
    required this.isAttachFile,
    required this.listExpense,
  });

  @override
  List<Object?> get props => [
        filePath,
        idExpense,
        idExpenseMileage,
        isAttachFile,
        listExpense,
      ];
}
