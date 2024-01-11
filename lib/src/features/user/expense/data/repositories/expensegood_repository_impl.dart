import 'package:dartz/dartz.dart';
import 'package:uni_expense/src/core/error/failure.dart';
import 'package:uni_expense/src/features/user/expense/data/data_sources/expensegood_remote_datasource.dart';
import 'package:uni_expense/src/features/user/expense/domain/entities/employees_allroles.dart';
import 'package:uni_expense/src/features/user/expense/domain/entities/employees_roleadmin.dart';
import 'package:uni_expense/src/features/user/expense/domain/repositories/expensegood_repository.dart';

import '../../../../../core/error/exception.dart';

class ExpenseGoodRepositoryImpl implements ExpenseGoodRepository {
  ExpenseGoodRemoteDatasource remoteDatasource;
  ExpenseGoodRepositoryImpl({required this.remoteDatasource});
  @override
  Future<Either<Failure, List<EmployeesAllRolesEntity>>>
      getEmployeesAllRoles() async {
    try {
      final data = await remoteDatasource.getEmployeesAllRoles();
      return Right(data);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<EmployeeRoleAdminEntity>>>
      getEmployeesRoleAdmin() async {
    try {
      final data = await remoteDatasource.getEmployeesRoleAdmin();
      return Right(data);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
