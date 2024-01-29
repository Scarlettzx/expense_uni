import 'package:dartz/dartz.dart';
import 'package:uni_expense/src/core/error/failure.dart';
import 'package:uni_expense/src/features/user/allowance/data/models/delete_expenseallowance_model.dart';
import 'package:uni_expense/src/features/user/allowance/data/models/edit_draft_allowance_model.dart';
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
      int idEmp, AddExpenseAllowanceModel formData) async {
    try {
      final data = await remoteDatasource.addExpenseAllowance(idEmp, formData);
      return Right(data);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, GetExpenseAllowanceByIdEntity>>
      getExpenseAllowanceById(int idExpense) async {
    try {
      final data = await remoteDatasource.getExpenseAllowanceById(idExpense);
      return Right(data);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ResponseDoDeleteAllowanceEntity>>
      deleteExpenseAllowance(
    int idEmp,
    DeleteExpenseAllowanceModel datadelete,
  ) async {
    try {
      final data =
          await remoteDatasource.deleteExpenseAllowance(idEmp, datadelete);
      return Right(data);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ResponseEditDraftAllowanceEntity>>
      updateDraftExpenseAllowance(
          int idEmp, EditDraftAllowanceModel dataupdate) async {
    try {
      final data =
          await remoteDatasource.updateExpenseAllowance(idEmp, dataupdate);
      return Right(data);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
