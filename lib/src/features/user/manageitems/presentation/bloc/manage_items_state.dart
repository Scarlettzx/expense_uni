part of 'manage_items_bloc.dart';

// @immutable
abstract class ManageItemsState extends Equatable {
  const ManageItemsState();
}

final class ManageItemsInitial extends ManageItemsState {
  @override
  List<Object?> get props => [];
}

final class ManageItemsLoading extends ManageItemsState {
  @override
  List<Object?> get props => [];
}

final class ManageItemsFinish extends ManageItemsState {
  final ManageItems? manageItems;

  const ManageItemsFinish({required this.manageItems});
  @override
  List<Object?> get props => [manageItems];
}

final class ManageItemsFailure extends ManageItemsState {
  final Failure error;

  const ManageItemsFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
