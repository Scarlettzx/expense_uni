part of 'expensegood_bloc.dart';

// @immutable
abstract class ExpenseGoodEvent extends Equatable {
  const ExpenseGoodEvent();
}

class GetEmployeesAllRolesDataEvent extends ExpenseGoodEvent {
  @override
  List<Object?> get props => [];
}

class GetEmployeesRoleAdminEvent extends ExpenseGoodEvent {
  @override
  List<Object?> get props => [];
}
