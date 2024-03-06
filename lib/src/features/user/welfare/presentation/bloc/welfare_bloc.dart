import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uni_expense/src/features/user/welfare/data/models/delete_welfare_model.dart';
import 'package:uni_expense/src/features/user/welfare/data/models/edit_draft_welfare_model.dart';
import 'package:uni_expense/src/features/user/welfare/domain/entities/entities.dart';
import 'package:uni_expense/src/features/user/welfare/domain/usecases/usecases.dart';

import '../../../../../core/error/failure.dart';
import '../../data/models/add_welfare_model.dart';

part 'welfare_event.dart';
part 'welfare_state.dart';

class WelfareBloc extends Bloc<WelfareEvent, WelfareState> {
  final GetEmployeesAllRolesWelfare getEmployeeAllrolesdata;
  final GetFamilys getFamilysdata;
  final AddWelfare addWelfare;
  final GetWelfareByid getWelfareByiddata;
  final EditWelfare editWelfare;
  final DeleteWelfare deleteWelfare;
  List<EmployeesAllRolesEntity> empallrolesData = [];
  List<FamilysEntity> familysData = [];
  GetWelfareByIdEntity? welfarebyid;
  WelfareBloc({
    required this.editWelfare,
    required this.getEmployeeAllrolesdata,
    required this.getFamilysdata,
    required this.addWelfare,
    required this.getWelfareByiddata,
    required this.deleteWelfare,
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
    on<GetWelfareByIdEvent>((event, emit) async {
      // emit(WelfareLoading());
      var responsegetwelfarebyid = await getWelfareByiddata(event.idExpense);
      responsegetwelfarebyid.fold(
        (l) => emit(WelfareFailure(error: l)),
        (r) {
          welfarebyid = r;
        },
      );
      emit(WelfareFinish(
        empsallrole: empallrolesData,
        resfamily: familysData,
        getwelfarebyid: welfarebyid,
      ));
    });
    on<UpdateWelfareEvent>((event, emit) async {
      emit(WelfareLoading());
      var responseditwelfare =
          await editWelfare(event.idEmployees, event.editwelfaredata);
      responseditwelfare.fold(
          (l) => emit(
                WelfareFailure(
                  error: l,
                ),
              ),
          (r) =>
              // (event.editwelfaredata.status == 1)
              emit(
                WelfareFinish(
                  getwelfarebyid: welfarebyid,
                  empsallrole: empallrolesData,
                  resfamily: familysData,
                  reseditwelfare: r,
                ),
              )
          // // ! status == 8
          // //  ? submit
          // : emit(
          //     WelfareFinish(
          //       reseditwelfare: r,
          //     ),
          // );
          );
    });
    on<DeleteWelfareEvent>((event, emit) async {
      emit(WelfareLoading());
      var resdeleteWelfare =
          await deleteWelfare(event.idEmployees, event.deletewelfaredata);
      resdeleteWelfare.fold(
          (l) => emit(WelfareFailure(error: l)),
          (r) => emit(WelfareFinish(
                empsallrole: empallrolesData,
                resfamily: familysData,
                resdeletewelfare: r,
              )));
    });
  }
}
