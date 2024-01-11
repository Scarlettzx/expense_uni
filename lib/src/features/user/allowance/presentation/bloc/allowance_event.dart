part of 'allowance_bloc.dart';

// @immutable
abstract class AllowanceEvent extends Equatable {
  const AllowanceEvent();
}

class GetEmployeesAllRolesDataEvent extends AllowanceEvent {
  @override
  List<Object?> get props => [];
}

class AddExpenseAllowanceEvent extends AllowanceEvent {
  final int idCompany;
  final AddExpenseAllowanceModel addallowancedata;
  const AddExpenseAllowanceEvent({
    required this.addallowancedata,
    required this.idCompany,
  }); // Fix the constructor name here

  @override
  List<Object?> get props => [
        idCompany,
        addallowancedata,
      ];
}
