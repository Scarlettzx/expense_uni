import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../entities/entities.dart';

abstract class ManageItemsRepository {
  Future<Either<Failure, ManageItems>> getManageItems();
}
