import 'package:dartz/dartz.dart';
import 'package:uni_expense/src/core/error/failure.dart';
import 'package:uni_expense/src/features/user/welfare/data/models/add_welfare_model.dart';
import 'package:uni_expense/src/features/user/welfare/data/models/delete_welfare_model.dart';
import 'package:uni_expense/src/features/user/welfare/domain/entities/employees_allroles.dart';
import 'package:uni_expense/src/features/user/welfare/domain/entities/familys.dart';
import 'package:uni_expense/src/features/user/welfare/domain/entities/get_welfarebyid.dart';
import 'package:uni_expense/src/features/user/welfare/domain/entities/response_doaddwelfare.dart';
import 'package:uni_expense/src/features/user/welfare/domain/entities/response_dodelete_welfare.dart';
import 'package:uni_expense/src/features/user/welfare/domain/entities/response_editdraft_welfare.dart';
import 'package:uni_expense/src/features/user/welfare/domain/repositories/welfare_repository.dart';

import '../../../../../core/error/exception.dart';
import '../data_sources/welfare_remote_datasource.dart';
import '../models/edit_draft_welfare_model.dart';

class WelfareRepositoryImpl implements WelfareRepository {
  WelfareRemoteDatasource remoteDatasource;
  WelfareRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, List<FamilysEntity>>> getFamilys(
      int idEmployees) async {
    try {
      final data = await remoteDatasource.getFamilys(idEmployees);
      return Right(data);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

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
  Future<Either<Failure, ResponseWelfareEntity>> addWelfare(
      int idEmployees, AddWelfareModel formdata) async {
    try {
      final data = await remoteDatasource.addWelfare(idEmployees, formdata);
      return Right(data);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, GetWelfareByIdEntity>> getWelfareById(
      int idExpense) async {
    try {
      final data = await remoteDatasource.getWelfareById(idExpense);
      return Right(data);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ResponseEditWelfareEntity>> updateDraftWelfare(
      int idEmployees, EditWelfareModel dataupdate) async {
    try {
      final data =
          await remoteDatasource.updateWelfare(idEmployees, dataupdate);
      return Right(data);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ResponseDoDeleteWelfareEntity>> deleteWelfare(int idEmployees, DeleteWelfareModel datadelete)async {
       try {
      final data =
          await remoteDatasource.deleteWelfare(idEmployees, datadelete);
      return Right(data);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
