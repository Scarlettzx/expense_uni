part of 'welfare_bloc.dart';

abstract class WelfareState extends Equatable {
  const WelfareState();
}

final class WelfareInitial extends WelfareState {
  @override
  List<Object?> get props => [];
}

final class WelfareLoading extends WelfareState {
  @override
  List<Object?> get props => [];
}

final class WelfareFinish extends WelfareState {
  final List<EmployeesAllRolesEntity>? empsallrole;
  final List<FamilysEntity>? resfamily;
  final ResponseWelfareEntity? resaddwelfare;
  final GetWelfareByIdEntity? getwelfarebyid;
  final ResponseEditWelfareEntity? reseditwelfare;
  final ResponseDoDeleteWelfareEntity? resdeletewelfare;

  const WelfareFinish({
    this.empsallrole,
    this.resfamily,
    this.resaddwelfare,
    this.getwelfarebyid,
    this.reseditwelfare,
    this.resdeletewelfare,
  });
  @override
  List<Object?> get props => [
        empsallrole,
        resfamily,
        resaddwelfare,
        getwelfarebyid,
        reseditwelfare,
        resdeletewelfare,
      ];
}

final class WelfareFailure extends WelfareState {
  final Failure error;
  const WelfareFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
