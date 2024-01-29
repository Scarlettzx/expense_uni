import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../allowance/domain/entities/entities.dart';
import '../../data/models/addexpenseallowance_model.dart';
import '../../data/models/delete_expenseallowance_model.dart';
import '../../data/models/edit_draft_allowance_model.dart';

abstract class AllowanceRepository {
  Future<Either<Failure, List<EmployeesAllRolesEntity>>> getEmployeesAllRoles();
  Future<Either<Failure, ResponseAllowanceEntity>> addExpenseAllowance(
      int idEmp, AddExpenseAllowanceModel formData);
  Future<Either<Failure, GetExpenseAllowanceByIdEntity>>
      getExpenseAllowanceById(int idExpense);
  // Future<Either<Failure, ResponseDoDeleteAllowanceEntity>>
  //     deleteExpenseAllowance(
  //   int idEmp, String filepath, int idExpense, int
  Future<Either<Failure, ResponseDoDeleteAllowanceEntity>>
      deleteExpenseAllowance(int idEmp, DeleteExpenseAllowanceModel data);
  Future<Either<Failure, ResponseEditDraftAllowanceEntity>>
      updateDraftExpenseAllowance(int idEmp, EditDraftAllowanceModel data);
}
