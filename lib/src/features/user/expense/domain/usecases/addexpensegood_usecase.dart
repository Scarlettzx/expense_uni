import 'package:dartz/dartz.dart';
import 'package:uni_expense/src/features/user/expense/data/models/addexpensegood_model.dart';
import 'package:uni_expense/src/features/user/expense/domain/entities/entities.dart';
import 'package:uni_expense/src/features/user/expense/domain/repositories/expensegood_repository.dart';

import '../../../../../core/error/failure.dart';

class AddExpenseGood {
  final ExpenseGoodRepository repository;

  AddExpenseGood({required this.repository});
  Future<Either<Failure, ResponseAdddExpenseGoodEntity>> call(
      int idEmployees, AddExpenseGoodModel data) async {
    return await repository.addExpenseGood(idEmployees, data);
  }
}
