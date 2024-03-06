part of 'familyrights_bloc.dart';

abstract class FamilyrightsEvent extends Equatable {
  const FamilyrightsEvent();
}

class GetAllrightsEmployeeFamilyEvent extends FamilyrightsEvent {
  final int idEmployees;

  const GetAllrightsEmployeeFamilyEvent({required this.idEmployees});
  @override
  List<Object?> get props => [
        idEmployees,
      ];
}
