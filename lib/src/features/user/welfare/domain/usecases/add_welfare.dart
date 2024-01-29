import 'package:dartz/dartz.dart';
import 'package:uni_expense/src/features/user/welfare/data/models/add_welfare_model.dart';
import 'package:uni_expense/src/features/user/welfare/domain/entities/response_doaddwelfare.dart';

import '../../../../../core/error/failure.dart';
import '../repositories/welfare_repository.dart';

class AddWelfare {
  final WelfareRepository repository;
  AddWelfare({required this.repository});

  Future<Either<Failure, ResponseWelfareEntity>> call(
      int idEmployees, AddWelfareModel formdata) async {
    return await repository.addWelfare(idEmployees, formdata);
  }
}
