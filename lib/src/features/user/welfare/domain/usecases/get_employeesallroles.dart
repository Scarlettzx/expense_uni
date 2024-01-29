import 'package:dartz/dartz.dart';
import 'package:uni_expense/src/features/user/welfare/domain/repositories/welfare_repository.dart';
import '../../../../../core/error/failure.dart';
import '../entities/entities.dart';

class GetEmployeesAllRolesWelfare {
  final WelfareRepository repository;
  GetEmployeesAllRolesWelfare({required this.repository});

  Future<Either<Failure, List<EmployeesAllRolesEntity>>> call() async {
    return await repository.getEmployeesAllRoles();
  }
}
