import 'package:dartz/dartz.dart';
import 'package:uni_expense/src/features/user/welfare/domain/entities/entities.dart';
import 'package:uni_expense/src/features/user/welfare/domain/repositories/welfare_repository.dart';

import '../../../../../core/error/failure.dart';
import '../../data/models/delete_welfare_model.dart';

class DeleteWelfare {
  final WelfareRepository repository;
  DeleteWelfare({required this.repository});
  Future<Either<Failure, ResponseDoDeleteWelfareEntity>> call(
      int idEmployees, DeleteWelfareModel data) async {
    return await repository.deleteWelfare(idEmployees, data);
  }
}
