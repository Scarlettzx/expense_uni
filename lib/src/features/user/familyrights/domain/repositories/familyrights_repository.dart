import 'package:dartz/dartz.dart';
import 'package:uni_expense/src/features/user/familyrights/domain/entities/get_allrightsemployeefamily.dart';

import '../../../../../core/error/failure.dart';

abstract class FamilyRightsRepository {
  Future<Either<Failure, List<GetAllrightsEmployeeFamilyEntity>>>
      getAllrightsEmployeeFamily(int idEmployees);
}
