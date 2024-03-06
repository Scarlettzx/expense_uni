part of 'welfare_bloc.dart';

abstract class WelfareEvent extends Equatable {
  const WelfareEvent();
}

class GetFamilysEvent extends WelfareEvent {
  final int idEmployees;

  const GetFamilysEvent({
    required this.idEmployees,
  });
  @override
  List<Object?> get props => [idEmployees];
}

class AddWelfareEvent extends WelfareEvent {
  final int idEmployees;
  final AddWelfareModel addwelfaredata;
  const AddWelfareEvent({
    required this.addwelfaredata,
    required this.idEmployees,
  }); // Fix the constructor name here

  @override
  List<Object?> get props => [
        idEmployees,
        addwelfaredata,
      ];
}

class GetWelfareByIdEvent extends WelfareEvent {
  final int idExpense;

  const GetWelfareByIdEvent({
    required this.idExpense,
  });

  @override
  List<Object?> get props => [idExpense];
}

class UpdateWelfareEvent extends WelfareEvent {
  final int idEmployees;
  final EditWelfareModel editwelfaredata;

  const UpdateWelfareEvent({
    required this.idEmployees,
    required this.editwelfaredata,
  });

  @override
  List<Object?> get props => [
        idEmployees,
        editwelfaredata,
      ];
}

class DeleteWelfareEvent extends WelfareEvent {
  final int idEmployees;
  final DeleteWelfareModel deletewelfaredata;

  const DeleteWelfareEvent(
      {required this.idEmployees, required this.deletewelfaredata});
  @override
  List<Object?> get props => [
        idEmployees,
        deletewelfaredata,
      ];
}
