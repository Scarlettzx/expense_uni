import 'package:dartz/dartz.dart';
import 'package:uni_expense/src/features/user/expense/domain/entities/entities.dart';
import 'package:uni_expense/src/features/user/expense/domain/repositories/expensegood_repository.dart';

import '../../../../../core/error/failure.dart';

class GetExpenseById {
  final ExpenseGoodRepository repository;

  GetExpenseById({required this.repository});
  Future<Either<Failure, GetExpenseGoodByIdEntity>> call(int idExpense) async {
    return await repository.getExpenseById(idExpense);
  }
}
