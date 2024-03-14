part of 'fare_bloc.dart';

abstract class FareEvent extends Equatable {
  const FareEvent();
}

class GetEmployeesAllRolesEvent extends FareEvent {
  @override
  List<Object?> get props => [];
}

class NameExpenseText extends FareEvent {
  @override
  List<Object?> get props => [];
}

// ! AddList
class AddListLocationAndFuelEvent extends FareEvent {
  final ListLocationandFuel listlocationandfuel;

  const AddListLocationAndFuelEvent({
    required this.listlocationandfuel,
  });
  @override
  List<Object?> get props => [listlocationandfuel];
}

class UpdateListLocationAndFuelEvent extends FareEvent {
  final ListLocationandFuel listlocationandfuel;

  const UpdateListLocationAndFuelEvent({
    required this.listlocationandfuel,
  });

  @override
  List<Object?> get props => [listlocationandfuel];
}

class DeleteListLocationAndFuelEvent extends FareEvent {
  final int index;
  final String? id;
  const DeleteListLocationAndFuelEvent({
    required this.index,
    required this.id,
  });

  @override
  List<Object?> get props => [index];
}

class AddExpenseFareEvent extends FareEvent {
  final int idEmployees;
  final AddFareModel addfaredata;
  const AddExpenseFareEvent({
    required this.idEmployees,
    required this.addfaredata,
  });

  @override
  List<Object?> get props => [
        idEmployees,
        addfaredata,
      ];
}

class GetFareByIdEvent extends FareEvent {
  final int idExpense;

  const GetFareByIdEvent({
    required this.idExpense,
  });

  @override
  List<Object?> get props => [idExpense];
}

class UpdateFareEvent extends FareEvent {
  final int idEmployees;
  final EditDraftFareModel editfaredata;
  const UpdateFareEvent({
    required this.idEmployees,
    required this.editfaredata,
  });

  @override
  List<Object?> get props => [
        idEmployees,
        editfaredata,
      ];
}

class DeleteExpenseFareEvent extends FareEvent {
  final int idEmp;
  final DeleteDraftFareModel deletefaredata;

  const DeleteExpenseFareEvent({
    required this.idEmp,
    required this.deletefaredata,
  });
  @override
  List<Object?> get props => [
        idEmp,
        deletefaredata,
      ];
}

// class GetListLocationAndFuelEvent extends FareEvent {
//   @override
//   List<Object?> get props => [];
// }

// // ! Calculate List
// class CalculateSummaryEvent extends FareEvent {
//   @override
//   List<Object?> get props => [];
// }
