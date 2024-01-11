part of 'manage_items_bloc.dart';

abstract class ManageItemsEvent extends Equatable {
  const ManageItemsEvent();
}

class GetManageItemsDataEvent extends ManageItemsEvent {
  @override
  List<Object?> get props => [];
}
