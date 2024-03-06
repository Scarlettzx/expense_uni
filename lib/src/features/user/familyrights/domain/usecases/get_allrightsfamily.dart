import 'package:dartz/dartz.dart';
import 'package:uni_expense/src/features/user/familyrights/domain/entities/get_allrightsemployeefamily.dart';
import 'package:uni_expense/src/features/user/familyrights/domain/repositories/familyrights_repository.dart';

import '../../../../../core/error/failure.dart';

class GetAllRightsFamily {
  final FamilyRightsRepository repository;

  GetAllRightsFamily({required this.repository});

  Future<Either<Failure, List<GetAllrightsEmployeeFamilyEntity>>> call(
      int idEmployees) async {
    return await repository.getAllrightsEmployeeFamily(idEmployees);
  }
}
