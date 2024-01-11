import 'package:dartz/dartz.dart';
import '../../../../error/failure.dart';
import '../entities/login_entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginEntity>> login(String username, String password);
}
