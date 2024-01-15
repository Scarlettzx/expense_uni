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
  const AllowanceFinish({
    this.empsallrole,
    this.responseaddallowance,
    this.expenseallowancebyid,
  });

  @override
  List<Object?> get props => [
        empsallrole,
        responseaddallowance,
        expenseallowancebyid,
      ];
}

final class AllowanceFailure extends AllowanceState {
  final Failure error;
  const AllowanceFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
