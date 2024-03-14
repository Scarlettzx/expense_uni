import 'package:dartz/dartz.dart';
import 'package:uni_expense/src/features/user/expense/domain/repositories/expensegood_repository.dart';

import '../../../../../core/error/failure.dart';
import '../../data/models/editdraft_expensegood_model.dart';
import '../entities/entities.dart';

class EditExpenseGood {
  final ExpenseGoodRepository repository;

  EditExpenseGood({required this.repository});
  Future<Either<Failure, ResponseEditDraftExpenseGoodEntity>> call(
      int idEmployees, EditDraftExpenseGoodModel data) async {
    return await repository.updateDraftExpenseGood(idEmployees, data);
  }
}
