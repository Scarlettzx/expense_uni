import 'package:dartz/dartz.dart';
import 'package:uni_expense/src/core/error/failure.dart';
import 'package:uni_expense/src/features/user/welfare/domain/entities/entities.dart';
import 'package:uni_expense/src/features/user/welfare/domain/repositories/welfare_repository.dart';

class GetFamilys {
  final WelfareRepository repository;

  GetFamilys({required this.repository});
  Future<Either<Failure, List<FamilysEntity>>> call(int idEmployees) async {
    return await repository.getFamilys(idEmployees);
  }
}
