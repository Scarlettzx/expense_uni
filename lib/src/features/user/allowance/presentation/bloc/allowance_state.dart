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
  const AllowanceFinish({
    this.empsallrole,
    this.responseaddallowance,
  });

  @override
  List<Object?> get props => [empsallrole];
}

final class AllowanceFailure extends AllowanceState {
  final Failure error;
  const AllowanceFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
