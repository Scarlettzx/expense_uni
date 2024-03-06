part of 'familyrights_bloc.dart';

abstract class FamilyrightsState extends Equatable {
  const FamilyrightsState();
}

final class FamilyrightsInitial extends FamilyrightsState {
  @override
  List<Object?> get props => [];
}

final class FamilyrightsLoading extends FamilyrightsState {
  @override
  List<Object?> get props => [];
}

final class FamilyrightsFinish extends FamilyrightsState {
  final List<GetAllrightsEmployeeFamilyEntity> allrightempfamily;

  const FamilyrightsFinish({required this.allrightempfamily});

  @override
  List<Object?> get props => [allrightempfamily];
}

final class FamilyrightsFailure extends FamilyrightsState {
  final Failure error;

  const FamilyrightsFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
