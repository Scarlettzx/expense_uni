import 'package:dartz/dartz.dart';
import 'package:uni_expense/src/features/user/fare/domain/repositories/fare_repository.dart';
import '../../../../../core/error/failure.dart';
import '../entities/entities.dart';

class GetEmployeesAllRolesFare {
  final FareRepository repository;
  GetEmployeesAllRolesFare({required this.repository});

  Future<Either<Failure, List<EmployeesAllRolesEntity>>> call() async {
    return await repository.getEmployeesAllRoles();
  }
}
