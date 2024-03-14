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
  final int idEmployees;
  final AddExpenseAllowanceModel addallowancedata;
  const AddExpenseAllowanceEvent({
    required this.idEmployees,
    required this.addallowancedata,
  }); // Fix the constructor name here

  @override
  List<Object?> get props => [
        idEmployees,
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

class CalculateSumEvent extends AllowanceEvent {
  @override
  List<Object?> get props => [];
}

class ToggleIsInternationEvent extends AllowanceEvent {
  final int? index;

  const ToggleIsInternationEvent({required this.index});

  @override
  List<Object?> get props => [
        index,
      ];
}

class AddListAllowanceEvent extends AllowanceEvent {
  final ListAllowance listallowance;

  const AddListAllowanceEvent({required this.listallowance});

  @override
  List<Object?> get props => [
        listallowance,
      ];
}

class UpdateListAllowanceEvent extends AllowanceEvent {
  final ListAllowance listallowance;

  const UpdateListAllowanceEvent({required this.listallowance});

  @override
  List<Object?> get props => [
        listallowance,
      ];
}

class DeleteListAllowanceEvent extends AllowanceEvent {
  final int index;
  final String? id;
  const DeleteListAllowanceEvent({
    required this.index,
    required this.id,
  });

  @override
  List<Object?> get props => [index];
}
