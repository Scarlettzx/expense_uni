
import 'package:dartz/dartz.dart';
import '../../../../error/failure.dart';
import '../entity/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile();
}
