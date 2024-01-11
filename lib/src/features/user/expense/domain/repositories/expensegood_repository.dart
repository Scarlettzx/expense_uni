// import 'package:uni_expense/src/features/user/expense/domain/entities/employees_roleadmin.dart';

import '../../../../../core/error/failure.dart';
import '../entities/entities.dart';
import 'package:dartz/dartz.dart';

abstract class ExpenseGoodRepository {
  Future<Either<Failure, List<EmployeesAllRolesEntity>>> getEmployeesAllRoles();
  Future<Either<Failure, List<EmployeeRoleAdminEntity>>>
      getEmployeesRoleAdmin();
}
