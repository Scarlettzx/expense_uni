import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/entities.dart';
import '../repositories/allowance_repository.dart';

class GetExpenseAllowanceById {
  final AllowanceRepository repository;
  GetExpenseAllowanceById({required this.repository});

  Future<Either<Failure, GetExpenseAllowanceByIdEntity>> call(
      int idExpense) async {
    return await repository.getExpenseAllowanceById(idExpense);
  }
}
