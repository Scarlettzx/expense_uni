import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

part 'expensegood_event.dart';
part 'expensegood_state.dart';

class ExpenseGoodBloc extends Bloc<ExpenseGoodEvent, ExpenseGoodState> {
  final GetEmployeesAllRoles getEmployeesAllrolesdata;
  final GetEmployeesRoleAdmin getEmployeesRoleadmin;
  List<EmployeesAllRolesEntity> empallrolesData = [];
  List<EmployeeRoleAdminEntity> emproleadminData = [];
  ExpenseGoodBloc(
      {required this.getEmployeesAllrolesdata,
      required this.getEmployeesRoleadmin})
      : super(ExpenseGoodInitial()) {
    on<GetEmployeesAllRolesDataEvent>((event, emit) async {
      emit(ExpenseGoodLoading());
      var resEmpallroles = await getEmployeesAllrolesdata();
      var resEmproleadmin = await getEmployeesRoleadmin();
      resEmpallroles.fold((l) => emit(ExpenseGoodFailure(error: l)),
          (r) => empallrolesData = r);
      resEmproleadmin.fold((l) => emit(ExpenseGoodFailure(error: l)),
          (r) => emproleadminData = r);
      emit(ExpenseGoodFinish(
        empsallrole: empallrolesData,
        empsroleadmin: emproleadminData,
      ));
    });
  }
}
