import 'package:dartz/dartz.dart';
import 'package:uni_expense/src/features/user/welfare/domain/entities/entities.dart';
import 'package:uni_expense/src/features/user/welfare/domain/repositories/welfare_repository.dart';

import '../../../../../core/error/failure.dart';

class GetWelfareByid {
  final WelfareRepository repository;

  GetWelfareByid({required this.repository});
  Future<Either<Failure, GetWelfareByIdEntity>> call(int idExpense) async {
    return await repository.getWelfareById(idExpense);
  }
}
