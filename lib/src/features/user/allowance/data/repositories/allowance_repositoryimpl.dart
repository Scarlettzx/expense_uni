import 'package:dartz/dartz.dart';
import 'package:uni_expense/src/core/error/failure.dart';
import 'package:uni_expense/src/features/user/allowance/domain/entities/addexpense_allowance.dart';
import 'package:uni_expense/src/features/user/allowance/domain/entities/employees_allroles.dart';
import 'package:uni_expense/src/features/user/allowance/domain/repositories/allowance_repository.dart';

import '../../../../../core/error/exception.dart';
import '../../domain/entities/entities.dart';
import '../data_sources/allowance_remote_datasource.dart';
import '../models/addexpenseallowance_model.dart';

class AllowanceRepositoryImpl implements AllowanceRepository {
  AllowanceRemoteDatasource remoteDatasource;
  AllowanceRepositoryImpl({required this.remoteDatasource});
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
  Future<Either<Failure, ResponseAllowanceEntity>> addExpenseAllowance(
      int idCompany, AddExpenseAllowanceModel formData) async {
    try {
      final data =
          await remoteDatasource.addExpenseAllowance(idCompany, formData);
      return Right(data);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
