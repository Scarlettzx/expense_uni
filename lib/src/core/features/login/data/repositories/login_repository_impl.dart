import 'package:dartz/dartz.dart';
import '../../../../error/exception.dart';
import '../../../../error/failure.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/repositories/login_repository.dart';
import '../data_sources/remote/login_api.dart';


class LoginRepositoryImpl implements LoginRepository{
  final LoginApi loginApi;
  LoginRepositoryImpl({required this.loginApi});
  @override
  Future<Either<Failure, LoginEntity>> login(String username, String password) async{
    try{
      final data = await loginApi.login(username, password);
      return Right(data);
    } on ServerException{
      return Left(ServerFailure());
    }
  }
  
}