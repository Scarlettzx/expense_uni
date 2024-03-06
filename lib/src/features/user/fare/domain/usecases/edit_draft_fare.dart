import 'package:dartz/dartz.dart';
import 'package:uni_expense/src/features/user/fare/data/models/edit_draft_fare_model.dart';
import 'package:uni_expense/src/features/user/fare/domain/entities/entities.dart';
import 'package:uni_expense/src/features/user/fare/domain/repositories/fare_repository.dart';

import '../../../../../core/error/failure.dart';

class EditFare {
  final FareRepository repository;
  EditFare({required this.repository});

  Future<Either<Failure, ResponseEditDraftFareEntity>> call(
      int idEmployees, EditDraftFareModel data) async {
    return await repository.updateDraftFare(idEmployees, data);
  }
}
