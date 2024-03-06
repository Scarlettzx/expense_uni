import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

part 'familyrights_event.dart';
part 'familyrights_state.dart';

class FamilyrightsBloc extends Bloc<FamilyrightsEvent, FamilyrightsState> {
  final GetAllRightsFamily getAllRightsFamily;
  FamilyrightsBloc({
    required this.getAllRightsFamily,
  }) : super(FamilyrightsInitial()) {
    on<GetAllrightsEmployeeFamilyEvent>((event, emit) async {
      emit(FamilyrightsLoading());
      var resAllrightsFamily = await getAllRightsFamily(event.idEmployees);
      resAllrightsFamily.fold(
        (l) => emit(
          FamilyrightsFailure(
            error: l,
          ),
        ),
        (r) => emit(FamilyrightsFinish(
          allrightempfamily: r,
        )),
      );
    });
  }
}
