import 'package:dartz/dartz.dart';
import 'package:uni_expense/src/features/user/allowance/data/models/edit_draft_allowance_model.dart';
import 'package:uni_expense/src/features/user/allowance/domain/entities/entities.dart';

import '../../../../../core/error/failure.dart';
import '../repositories/allowance_repository.dart';

class EditAllowance {
  final AllowanceRepository repository;
  EditAllowance({required this.repository});

  Future<Either<Failure, ResponseEditDraftAllowanceEntity>> call(
      int idEmp, EditDraftAllowanceModel data) async {
    return await repository.updateDraftExpenseAllowance(idEmp, data);
  }
}
