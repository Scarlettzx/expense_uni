import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../data/models/delete_expensegood_model.dart';
import '../entities/entities.dart';
import '../repositories/expensegood_repository.dart';

class DeleteExpenseGood {
  final ExpenseGoodRepository repository;
  DeleteExpenseGood({required this.repository});

  Future<Either<Failure, ResponseDoDeleteExpenseGoodEntity>> call(
      int idEmployees, DeleteDraftExpenseGoodModel data) async {
    return await repository.deleteDraftExpense(idEmployees, data);
  }
}
