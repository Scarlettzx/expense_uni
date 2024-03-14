import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../data/models/delete_fare_model.dart';
import '../entities/entities.dart';
import '../repositories/fare_repository.dart';

class DeleteFare {
  final FareRepository repository;
  DeleteFare({required this.repository});

  Future<Either<Failure, ResponseDoDeleteFareEntity>> call(
      int idEmployees, DeleteDraftFareModel data) async {
    return await repository.deleteDraftFare(idEmployees, data);
  }
}
