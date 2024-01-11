import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/entities.dart';
import '../repositories/allowance_repository.dart';

class GetEmployeesAllRoles {
  final AllowanceRepository repository;
  GetEmployeesAllRoles({required this.repository});

  Future<Either<Failure, List<EmployeesAllRolesEntity>>> call() async {
    return await repository.getEmployeesAllRoles();
  }
}
