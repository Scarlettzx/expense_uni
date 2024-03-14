// import 'package:uni_expense/src/features/user/expense/domain/entities/employees_roleadmin.dart';

import '../../../../../core/error/failure.dart';
import '../../data/models/addexpensegood_model.dart';
import '../../data/models/delete_expensegood_model.dart';
import '../../data/models/editdraft_expensegood_model.dart';
import '../entities/entities.dart';
import 'package:dartz/dartz.dart';

abstract class ExpenseGoodRepository {
  Future<Either<Failure, List<EmployeesAllRolesEntity>>> getEmployeesAllRoles();
  Future<Either<Failure, List<EmployeeRoleAdminEntity>>>
      getEmployeesRoleAdmin();
  Future<Either<Failure, ResponseAdddExpenseGoodEntity>> addExpenseGood(
      int idEmployees, AddExpenseGoodModel data);
  Future<Either<Failure, GetExpenseGoodByIdEntity>> getExpenseById(
      int idExpense);
  Future<Either<Failure, ResponseEditDraftExpenseGoodEntity>>
      updateDraftExpenseGood(int idEmployees, EditDraftExpenseGoodModel data);
  Future<Either<Failure, ResponseDoDeleteExpenseGoodEntity>> deleteDraftExpense(
      int idEmployees, DeleteDraftExpenseGoodModel data);
}
