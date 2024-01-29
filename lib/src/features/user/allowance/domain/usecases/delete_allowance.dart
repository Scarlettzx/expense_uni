import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../data/models/delete_expenseallowance_model.dart';
import '../entities/entities.dart';
import '../repositories/allowance_repository.dart';

class DeleteAllowance {
  final AllowanceRepository repository;
  DeleteAllowance({required this.repository});

  Future<Either<Failure, ResponseDoDeleteAllowanceEntity>> call(
      int idEmp, DeleteExpenseAllowanceModel data) async {
    return await repository.deleteExpenseAllowance(idEmp, data);
  }
}
