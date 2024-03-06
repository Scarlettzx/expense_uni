import 'package:dartz/dartz.dart';
import 'package:uni_expense/src/features/user/fare/data/models/add_fare_model.dart';
import 'package:uni_expense/src/features/user/fare/data/models/edit_draft_fare_model.dart';
import 'package:uni_expense/src/features/user/fare/domain/entities/getfarebyid.dart';
import 'package:uni_expense/src/features/user/fare/domain/entities/response_editdraft_fare.dart';
import 'package:uni_expense/src/features/user/fare/domain/entities/response_fare.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/employees_allroles.dart';
import '../../domain/repositories/fare_repository.dart';
import '../data_sources/fare_remote_datasource.dart';

class FareRepositoryImpl implements FareRepository {
  FareRemoteDatasource remoteDatasource;
  FareRepositoryImpl({required this.remoteDatasource});
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
  Future<Either<Failure, ResponseFareEntity>> addExpenseFare(
      int idEmployees, AddFareModel formData) async {
    try {
      final data = await remoteDatasource.addExpenseFare(idEmployees, formData);
      return Right(data);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, GetFareByIdEntity>> getFareById(int idExpense) async {
    try {
      final data = await remoteDatasource.getFareById(idExpense);
      return Right(data);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ResponseEditDraftFareEntity>> updateDraftFare(
      int idEmployees, EditDraftFareModel dataupdate) async {
    try {
      final data = await remoteDatasource.updateFare(idEmployees, dataupdate);
      return Right(data);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
