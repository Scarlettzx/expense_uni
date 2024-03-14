import 'package:dartz/dartz.dart';
import 'package:uni_expense/src/core/error/failure.dart';
import 'package:uni_expense/src/features/user/expense/data/data_sources/expensegood_remote_datasource.dart';
import 'package:uni_expense/src/features/user/expense/data/models/addexpensegood_model.dart';
import 'package:uni_expense/src/features/user/expense/data/models/delete_expensegood_model.dart';
import 'package:uni_expense/src/features/user/expense/data/models/editdraft_expensegood_model.dart';
import 'package:uni_expense/src/features/user/expense/domain/entities/employees_allroles.dart';
import 'package:uni_expense/src/features/user/expense/domain/entities/employees_roleadmin.dart';
import 'package:uni_expense/src/features/user/expense/domain/entities/getexpensegoodbyid.dart';
import 'package:uni_expense/src/features/user/expense/domain/entities/response_addexpensegood.dart';
import 'package:uni_expense/src/features/user/expense/domain/entities/response_deletedraft_expensegood.dart';
import 'package:uni_expense/src/features/user/expense/domain/entities/response_editdraft_expensegood.dart';
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

  @override
  Future<Either<Failure, ResponseAdddExpenseGoodEntity>> addExpenseGood(
      int idEmployees, AddExpenseGoodModel formdata) async {
    try {
      final data = await remoteDatasource.addExpenseGood(idEmployees, formdata);
      return Right(data);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, GetExpenseGoodByIdEntity>> getExpenseById(
      int idExpense) async {
    try {
      final data = await remoteDatasource.getExpenseById(idExpense);
      return Right(data);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ResponseEditDraftExpenseGoodEntity>>
      updateDraftExpenseGood(
          int idEmployees, EditDraftExpenseGoodModel dataupdate) async {
    try {
      final data =
          await remoteDatasource.updateExpenseGood(idEmployees, dataupdate);
      return Right(data);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ResponseDoDeleteExpenseGoodEntity>> deleteDraftExpense(
      int idEmployees, DeleteDraftExpenseGoodModel deletedata) async {
    try {
      final data =
          await remoteDatasource.deleteExpense(idEmployees, deletedata);
      return Right(data);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
