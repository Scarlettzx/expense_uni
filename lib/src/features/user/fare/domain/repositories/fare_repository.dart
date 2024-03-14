import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../data/models/add_fare_model.dart';
import '../../data/models/delete_fare_model.dart';
import '../entities/entities.dart';
import '../../data/models/edit_draft_fare_model.dart';

abstract class FareRepository {
  Future<Either<Failure, List<EmployeesAllRolesEntity>>> getEmployeesAllRoles();
  Future<Either<Failure, ResponseFareEntity>> addExpenseFare(
      int idEmployees, AddFareModel formData);
  Future<Either<Failure, GetFareByIdEntity>> getFareById(int idExpense);
  Future<Either<Failure, ResponseEditDraftFareEntity>> updateDraftFare(
      int idEmployees, EditDraftFareModel data);
  Future<Either<Failure, ResponseDoDeleteFareEntity>> deleteDraftFare(
      int idEmployees, DeleteDraftFareModel data);
}
