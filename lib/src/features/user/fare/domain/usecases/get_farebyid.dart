import 'package:dartz/dartz.dart';
import 'package:uni_expense/src/features/user/fare/domain/entities/entities.dart';
import 'package:uni_expense/src/features/user/fare/domain/repositories/fare_repository.dart';
import '../../../../../core/error/failure.dart';

class GetFareByid {
  final FareRepository repository;

  GetFareByid({required this.repository});
  Future<Either<Failure, GetFareByIdEntity>> call(int idExpense) async {
    return await repository.getFareById(idExpense);
  }
}
