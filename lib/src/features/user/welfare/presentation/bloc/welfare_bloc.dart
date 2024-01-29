import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uni_expense/src/features/user/welfare/domain/entities/entities.dart';
import 'package:uni_expense/src/features/user/welfare/domain/usecases/get_employeesallroles.dart';
import 'package:uni_expense/src/features/user/welfare/domain/usecases/usecases.dart';

import '../../../../../core/error/failure.dart';
import '../../data/models/add_welfare_model.dart';
import '../../domain/entities/response_doaddwelfare.dart';

part 'welfare_event.dart';
part 'welfare_state.dart';

class WelfareBloc extends Bloc<WelfareEvent, WelfareState> {
  final GetEmployeesAllRolesWelfare getEmployeeAllrolesdata;
  final GetFamilys getFamilysdata;
  final AddWelfare addWelfare;
  List<EmployeesAllRolesEntity> empallrolesData = [];
  List<FamilysEntity> familysData = [];
  WelfareBloc({
    required this.getEmployeeAllrolesdata,
    required this.getFamilysdata,
    required this.addWelfare,
  }) : super(WelfareInitial()) {
    on<GetFamilysEvent>((event, emit) async {
      emit(WelfareLoading());
      var resFamilys = await getFamilysdata(event.idEmployees);
      var resEmpallroles = await getEmployeeAllrolesdata();
      resFamilys.fold(
          (l) => emit(WelfareFailure(error: l)), (r) => familysData = r);
      resEmpallroles.fold(
          (l) => emit(WelfareFailure(error: l)), (r) => empallrolesData = r);
      emit(WelfareFinish(
        empsallrole: empallrolesData,
        resfamily: familysData,
      ));
    });
    on<AddWelfareEvent>(((event, emit) async {
      emit(WelfareLoading());
      var responseaddwelfare = await addWelfare(
        event.idEmployees,
        event.addwelfaredata,
      );
      responseaddwelfare.fold(
          (l) => (l) => emit(WelfareFailure(error: l)),
          (r) => emit(
                WelfareFinish(
                  empsallrole: empallrolesData,
                  resfamily: familysData,
                  resaddwelfare: r,
                ),
              ));
    }));
  }
}
