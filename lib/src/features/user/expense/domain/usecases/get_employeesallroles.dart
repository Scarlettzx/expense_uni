import 'package:dartz/dartz.dart';
import '../entities/entities.dart';
import '../repositories/expensegood_repository.dart';
import '../../../../../core/error/failure.dart';

class GetEmployeesAllRoles {
  final ExpenseGoodRepository repository;
  GetEmployeesAllRoles({required this.repository});

  Future<Either<Failure, List<EmployeesAllRolesEntity>>> call() async {
    return await repository.getEmployeesAllRoles();
  }
}
