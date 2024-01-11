import 'package:dartz/dartz.dart';
import 'package:uni_expense/src/core/error/failure.dart';
import 'package:uni_expense/src/features/user/manageitems/data/data_sources/manageitems_remote_datasource.dart';
import 'package:uni_expense/src/features/user/manageitems/domain/entities/manage_items.dart';
import 'package:uni_expense/src/features/user/manageitems/domain/repositories/manageitems_repository.dart';

import '../../../../../core/error/exception.dart';

class ManageItemsRepositoryImpl implements ManageItemsRepository {
  ManageItemsRemoteDatasource remoteDatasource;
  ManageItemsRepositoryImpl({required this.remoteDatasource});
  @override
  Future<Either<Failure, ManageItems>> getManageItems() async {
    try {
      final data = await remoteDatasource.getManageItems();
      return Right(data);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
