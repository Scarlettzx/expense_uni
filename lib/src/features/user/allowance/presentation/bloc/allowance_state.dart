part of 'allowance_bloc.dart';

// @immutable
abstract class AllowanceState extends Equatable {
  const AllowanceState();
}

final class AllowanceInitial extends AllowanceState {
  @override
  List<Object?> get props => [];
}

final class AllowanceLoading extends AllowanceState {
  @override
  List<Object?> get props => [];
}

final class AllowanceFinish extends AllowanceState {
  final List<EmployeesAllRolesEntity>? empsallrole;
  final ResponseAllowanceEntity? responseaddallowance;
  final GetExpenseAllowanceByIdEntity? expenseallowancebyid;
  final ResponseDoDeleteAllowanceEntity? responsedeleteallowance;
  final ResponseEditDraftAllowanceEntity? responseeditallowance;
  const AllowanceFinish({
    this.empsallrole,
    this.responseaddallowance,
    this.expenseallowancebyid,
    this.responsedeleteallowance,
    this.responseeditallowance,
  });

  @override
  List<Object?> get props => [
        empsallrole,
        responseaddallowance,
        expenseallowancebyid,
        responsedeleteallowance
      ];
}

final class AllowanceFailure extends AllowanceState {
  final Failure error;
  const AllowanceFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
