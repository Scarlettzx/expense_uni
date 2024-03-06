import 'package:dartz/dartz.dart';

import 'package:uni_expense/src/core/error/failure.dart';

import 'package:uni_expense/src/features/user/familyrights/domain/entities/get_allrightsemployeefamily.dart';

import '../../../../../core/error/exception.dart';
import '../../domain/repositories/familyrights_repository.dart';
import '../data_sources/familyrights_remote_datasource.dart';

class FamilyRightsRepositoryImpl implements FamilyRightsRepository {
  FamilyRightsRemoteDataSource remoteDatasource;
  FamilyRightsRepositoryImpl({required this.remoteDatasource});
  @override
  Future<Either<Failure, List<GetAllrightsEmployeeFamilyEntity>>>
      getAllrightsEmployeeFamily(int idEmployees) async {
    try {
      final data =
          await remoteDatasource.getAllrightsEmployeeFamily(idEmployees);
      return Right(data);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
