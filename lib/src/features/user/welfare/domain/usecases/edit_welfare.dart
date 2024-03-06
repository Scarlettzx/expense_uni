import 'package:dartz/dartz.dart';
import 'package:uni_expense/src/features/user/welfare/domain/entities/entities.dart';
import 'package:uni_expense/src/features/user/welfare/domain/repositories/welfare_repository.dart';

import '../../../../../core/error/failure.dart';
import '../../data/models/edit_draft_welfare_model.dart';

class EditWelfare {
  final WelfareRepository repository;

  EditWelfare({required this.repository});
  Future<Either<Failure, ResponseEditWelfareEntity>> call(
      int idEmployees, EditWelfareModel data) async {
    return await repository.updateDraftWelfare(idEmployees, data);
  }
}
