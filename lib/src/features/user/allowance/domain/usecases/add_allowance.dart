import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../data/models/addexpenseallowance_model.dart';
import '../entities/entities.dart';
import '../repositories/allowance_repository.dart';

class AddAllowance {
  final AllowanceRepository repository;
  AddAllowance({required this.repository});

  Future<Either<Failure, ResponseAllowanceEntity>> call(
      int idCompany, AddExpenseAllowanceModel formData) async {
    return await repository.addExpenseAllowance(idCompany, formData);
  }
}
