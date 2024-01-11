import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:meta/meta.dart';

import '../../../../../core/error/failure.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

part 'manage_items_event.dart';
part 'manage_items_state.dart';

class ManageItemsBloc extends Bloc<ManageItemsEvent, ManageItemsState> {
  final GetManageItems getmanageitems;
  late ManageItems manageitemsData;
  ManageItemsBloc({required this.getmanageitems})
      : super(ManageItemsInitial()) {
    on<GetManageItemsDataEvent>((event, emit) async {
      emit(ManageItemsLoading());
      var resManageitems = await getmanageitems();
      resManageitems.fold(
        (l) => emit(ManageItemsFailure(error: l)),
        (r) => manageitemsData = r,
      );
      // print(manageitemsData);
      // print(manageitemsData.all);
      emit(ManageItemsFinish(manageItems: manageitemsData));
    });
  }
}
