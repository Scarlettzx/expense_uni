import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:meta/meta.dart';

import '../../../../../core/error/failure.dart';
import '../../data/models/addexpenseallowance_model.dart';
import '../../data/models/delete_expenseallowance_model.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

part 'allowance_event.dart';
part 'allowance_state.dart';

class AllowanceBloc extends Bloc<AllowanceEvent, AllowanceState> {
  final GetEmployeesAllRoles getEmployeeAllrolesdata;
  final AddAllowance addexpenseallowancedata;
  final GetExpenseAllowanceById getexpenseAllowancebyId;
  final DeleteAllowance deleteExpensallowancedata;
  List<EmployeesAllRolesEntity> empallrolesData = [];
  // late ResponseAllowanceEntity listaddexpenseallowancedata;
  AllowanceBloc({
    required this.deleteExpensallowancedata,
    required this.getEmployeeAllrolesdata,
    required this.addexpenseallowancedata,
    required this.getexpenseAllowancebyId,
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
        AllowanceFinish(
          empsallrole: empallrolesData,
          expenseallowancebyid: r,
        );
      });
    });
    on<DeleteExpenseAllowance>((event, emit) {});
  }
}
