import 'package:dartz/dartz.dart';
import 'package:uni_expense/src/features/user/fare/data/models/add_fare_model.dart';
import 'package:uni_expense/src/features/user/fare/domain/entities/entities.dart';
import 'package:uni_expense/src/features/user/fare/domain/repositories/fare_repository.dart';

import '../../../../../core/error/failure.dart';

class AddFare {
  final FareRepository repository;

  AddFare({required this.repository});
  Future<Either<Failure, ResponseFareEntity>> call(
      int idEmployees, AddFareModel formdata) async {
    return await repository.addExpenseFare(idEmployees, formdata);
  }
}
