import 'package:dartz/dartz.dart';
import 'package:uni_expense/src/core/error/failure.dart';
import 'package:uni_expense/src/features/user/welfare/data/models/add_welfare_model.dart';
import 'package:uni_expense/src/features/user/welfare/data/models/edit_draft_welfare_model.dart';
import 'package:uni_expense/src/features/user/welfare/domain/entities/entities.dart';

import '../../data/models/delete_welfare_model.dart';

abstract class WelfareRepository {
  Future<Either<Failure, List<FamilysEntity>>> getFamilys(int idEmployees);
  Future<Either<Failure, List<EmployeesAllRolesEntity>>> getEmployeesAllRoles();
  Future<Either<Failure, ResponseWelfareEntity>> addWelfare(
    int idEmployees,
    AddWelfareModel data,
  );
  Future<Either<Failure, GetWelfareByIdEntity>> getWelfareById(int idExpense);
  Future<Either<Failure, ResponseEditWelfareEntity>> updateDraftWelfare(
      int idEmployees, EditWelfareModel data);
  Future<Either<Failure, ResponseDoDeleteWelfareEntity>> deleteWelfare(
      int tdEmployees, DeleteWelfareModel data);
}
