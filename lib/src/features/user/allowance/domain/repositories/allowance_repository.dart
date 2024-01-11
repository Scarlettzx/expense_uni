import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../allowance/domain/entities/entities.dart';
import '../../data/models/addexpenseallowance_model.dart';

abstract class AllowanceRepository {
  Future<Either<Failure, List<EmployeesAllRolesEntity>>> getEmployeesAllRoles();
  Future<Either<Failure, ResponseAllowanceEntity>> addExpenseAllowance(
      int idCompany, AddExpenseAllowanceModel formData);
}
