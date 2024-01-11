import 'package:dartz/dartz.dart';
import 'package:uni_expense/src/features/user/manageitems/domain/entities/entities.dart';
import 'package:uni_expense/src/features/user/manageitems/domain/repositories/manageitems_repository.dart';

import '../../../../../core/error/failure.dart';

class GetManageItems {
  final ManageItemsRepository repository;

  GetManageItems({required this.repository});
  Future<Either<Failure, ManageItems>> call() async {
    return repository.getManageItems();
  }
}
