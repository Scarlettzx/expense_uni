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

class GetExpenseAllowanceByIdData extends AllowanceEvent {
  final int idExpense;
  const GetExpenseAllowanceByIdData({required this.idExpense});

  @override
  List<Object?> get props => [
        idExpense,
      ];
}

class DeleteExpenseAllowanceEvent extends AllowanceEvent {
  final int idEmp;
  final DeleteExpenseAllowanceModel deleteallowancedata;

  const DeleteExpenseAllowanceEvent({
    required this.idEmp,
    required this.deleteallowancedata,
  });
  @override
  List<Object?> get props => [
        idEmp,
        deleteallowancedata,
      ];
}

class UpdateExpenseAllowanceEvent extends AllowanceEvent {
  final int idEmp;
  final EditDraftAllowanceModel editallowancedata;

  const UpdateExpenseAllowanceEvent({
    required this.idEmp,
    required this.editallowancedata,
  });
  @override
  List<Object?> get props => [
        idEmp,
        editallowancedata,
      ];
}
