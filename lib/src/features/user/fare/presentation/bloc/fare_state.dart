part of 'fare_bloc.dart';

enum FetchStatus { initial, loading, finish, failure, updatesuccess, list }

class FareState extends Equatable {
  final FetchStatus status;
  final List<ListLocationandFuel> listlocationandfuel;
  final List<EmployeesAllRolesEntity> empallrole;
  final ResponseFareEntity? responseaddfare;
  final ResponseEditDraftFareEntity? responseeditfare;
  final ResponseDoDeleteFareEntity? responsdodeletefare;
  final GetFareByIdEntity? getfarebyid;
  final Failure? error;
  final bool? isdraft;
  final List<int>? deleteItem;
  const FareState({
    this.status = FetchStatus.initial,
    this.listlocationandfuel = const [],
    this.empallrole = const [],
    this.responseaddfare,
    this.responseeditfare,
    this.responsdodeletefare,
    this.getfarebyid,
    this.isdraft = false,
    this.deleteItem = const [],
    this.error,
  });

  FareState copyWith({
    FetchStatus? status,
    List<ListLocationandFuel>? listlocationandfuel,
    List<EmployeesAllRolesEntity>? empallrole,
    ResponseFareEntity? responseaddfare,
    ResponseEditDraftFareEntity? responseeditfare,
    ResponseDoDeleteFareEntity? responsdodeletefare,
    GetFareByIdEntity? getfarebyid,
    List<int>? deleteItem,
    bool? isdraft,
    Failure? error,
  }) {
    return FareState(
      status: status ?? this.status,
      empallrole: empallrole ?? this.empallrole,
      listlocationandfuel: listlocationandfuel ?? this.listlocationandfuel,
      responseaddfare: responseaddfare ?? this.responseaddfare,
      responseeditfare: responseeditfare ?? this.responseeditfare,
      responsdodeletefare: responsdodeletefare ?? this.responsdodeletefare,
      getfarebyid: getfarebyid ?? this.getfarebyid,
      isdraft: isdraft ?? this.isdraft,
      deleteItem: deleteItem ?? this.deleteItem,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        listlocationandfuel,
        empallrole,
        responseaddfare,
        isdraft,
        error,
      ];
}

final class FareInitial extends FareState {
  @override
  List<Object?> get props => [];
}

// final class FareLoading extends FareState {
//   @override
//   List<Object?> get props => [];
// }

// final class FareFinish extends FareState {
//   final List<EmployeesAllRolesEntity>? empallrole;
//   const FareFinish({
//     this.empallrole,
//   });
//   @override
//   List<Object?> get props => [empallrole];
// }

// final class FareFailure extends FareState {
//   final Failure error;
//   const FareFailure({required this.error});
//   @override
//   List<Object?> get props => [error];
// }

// final class ListCompleted extends FareState {
//   final List<ListLocationandFuel> listlocationandfueldata;
//   const ListCompleted({
//     required this.listlocationandfueldata,
//   }) : super(listlocationandfuel: listlocationandfueldata);

//   @override
//   List<Object?> get props => [listlocationandfueldata];
// }

// final class CalculateSummaryData extends FareState {
//   final num? totalDistance;
//   final num? personalDistance;
//   final num? netDistance;
//   final num? net;
//   const CalculateSummaryData({
//     required this.totalDistance,
//     required this.personalDistance,
//     required this.netDistance,
//     required this.net,
//   });

//   @override
//   List<Object?> get props => [
//         totalDistance,
//         personalDistance,
//         netDistance,
//         net,
//       ];
// }
