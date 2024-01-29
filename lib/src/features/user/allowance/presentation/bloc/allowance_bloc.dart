import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:uni_expense/src/features/user/allowance/data/models/edit_draft_allowance_model.dart';
// import 'package:meta/meta.dart';

import '../../../../../core/error/failure.dart';
import '../../data/models/addexpenseallowance_model.dart';
import '../../data/models/delete_expenseallowance_model.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/edit_draft_allowance.dart';
import '../../domain/usecases/usecases.dart';

part 'allowance_event.dart';
part 'allowance_state.dart';

class AllowanceBloc extends Bloc<AllowanceEvent, AllowanceState> {
  final GetEmployeesAllRoles getEmployeeAllrolesdata;
  final AddAllowance addexpenseallowancedata;
  final GetExpenseAllowanceById getexpenseAllowancebyId;
  final DeleteAllowance deleteExpensallowancedata;
  final EditAllowance updateAllowancedata;
  List<EmployeesAllRolesEntity> empallrolesData = [];
  // late ResponseAllowanceEntity listaddexpenseallowancedata;
  AllowanceBloc({
    required this.deleteExpensallowancedata,
    required this.getEmployeeAllrolesdata,
    required this.addexpenseallowancedata,
    required this.getexpenseAllowancebyId,
    required this.updateAllowancedata,
  }) : super(AllowanceInitial()) {
    on<GetEmployeesAllRolesDataEvent>((event, emit) async {
      emit(AllowanceLoading());
      var resEmpallroles = await getEmployeeAllrolesdata();
      resEmpallroles.fold(
        (l) => emit(AllowanceFailure(error: l)),
        (r) => empallrolesData = r,
      );
      emit(AllowanceFinish(empsallrole: empallrolesData));
    });
    on<AddExpenseAllowanceEvent>(((event, emit) async {
      emit(AllowanceLoading());
      var resaddallowance = await addexpenseallowancedata(
        event.idCompany,
        event.addallowancedata,
      );
      resaddallowance.fold(
          (l) => emit(
                AllowanceFailure(
                  error: l,
                ),
              ), (r) {
        print(r);
        emit(
          AllowanceFinish(
            empsallrole: empallrolesData,
            responseaddallowance: r,
          ),
        );
      });
    }));
    on<GetExpenseAllowanceByIdData>((event, emit) async {
      // emit(AllowanceLoading());
      var resallowancegetbyid = await getexpenseAllowancebyId(
        event.idExpense,
      );
      resallowancegetbyid.fold(
          (l) => emit(
                AllowanceFailure(
                  error: l,
                ),
              ), (r) {
        print("GetExpenseAllowanceByIdData $r");
        emit(AllowanceFinish(
          empsallrole: empallrolesData,
          expenseallowancebyid: r,
        ));
      });
    });
    on<DeleteExpenseAllowanceEvent>((event, emit) async {
      emit(AllowanceLoading());
      var resdeleteExpensallowance = await deleteExpensallowancedata(
          event.idEmp, event.deleteallowancedata);
      resdeleteExpensallowance.fold(
          (l) => emit(
                AllowanceFailure(
                  error: l,
                ),
              ), (r) {
        debugPrint('delete');
        emit(AllowanceFinish(
          empsallrole: empallrolesData,
          responsedeleteallowance: r,
        ));
      });
    });
    on<UpdateExpenseAllowanceEvent>((event, emit) async {
      emit(AllowanceLoading());
      var resEditdraftallowance =
          await updateAllowancedata(event.idEmp, event.editallowancedata);
      resEditdraftallowance.fold(
        (l) => emit(
          AllowanceFailure(
            error: l,
          ),
        ),
        (r) {
          debugPrint('edit');
          emit(
            AllowanceFinish(
              // expenseallowancebyid: ,
              empsallrole: empallrolesData,
              responseeditallowance: r,
            ),
          );
        },
      );
    });
  }
}
