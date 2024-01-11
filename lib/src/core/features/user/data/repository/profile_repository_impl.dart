import 'package:dartz/dartz.dart';

import '../../../../error/exception.dart';
import '../../../../error/failure.dart';
import '../../domain/entity/profile_entity.dart';
import '../../domain/repository/profile_repository.dart';
import '../datasource/remote/profile_remote_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    try {
      final data = await remoteDataSource.getProfile();
      return Right(data);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
