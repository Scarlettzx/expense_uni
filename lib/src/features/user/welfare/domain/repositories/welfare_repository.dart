import 'package:dartz/dartz.dart';
import 'package:uni_expense/src/core/error/failure.dart';
import 'package:uni_expense/src/features/user/welfare/data/models/add_welfare_model.dart';
import 'package:uni_expense/src/features/user/welfare/domain/entities/entities.dart';
import 'package:uni_expense/src/features/user/welfare/domain/entities/response_doaddwelfare.dart';

abstract class WelfareRepository {
  Future<Either<Failure, List<FamilysEntity>>> getFamilys(int idEmployees);
  Future<Either<Failure, List<EmployeesAllRolesEntity>>> getEmployeesAllRoles();
  Future<Either<Failure, ResponseWelfareEntity>> addWelfare(
    int idEmployees,
    AddWelfareModel data,
  );
}
