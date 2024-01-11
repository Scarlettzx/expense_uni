import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../entities/entities.dart';
import '../repositories/expensegood_repository.dart';

class GetEmployeesRoleAdmin {
  final ExpenseGoodRepository repository;

  GetEmployeesRoleAdmin({required this.repository});
  Future<Either<Failure, List<EmployeeRoleAdminEntity>>> call() async {
    return await repository.getEmployeesRoleAdmin();
  }
}
