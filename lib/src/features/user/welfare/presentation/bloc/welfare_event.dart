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
