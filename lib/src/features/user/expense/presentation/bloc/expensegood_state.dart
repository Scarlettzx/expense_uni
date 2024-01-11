part of 'expensegood_bloc.dart';

// @immutable
abstract class ExpenseGoodState extends Equatable {
  const ExpenseGoodState();
}

final class ExpenseGoodInitial extends ExpenseGoodState {
  @override
  List<Object?> get props => [];
}

final class ExpenseGoodLoading extends ExpenseGoodState {
  @override
  List<Object?> get props => [];
}

final class ExpenseGoodFinish extends ExpenseGoodState {
  final List<EmployeesAllRolesEntity>? empsallrole;
  final List<EmployeeRoleAdminEntity>? empsroleadmin;
  const ExpenseGoodFinish({this.empsallrole, this.empsroleadmin});
  @override
  List<Object?> get props => [empsallrole, empsroleadmin];
}

final class ExpenseGoodFailure extends ExpenseGoodState {
  final Failure error;

  const ExpenseGoodFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
