part of 'allowance_bloc.dart';

enum FetchStatus {
  initial,
  loading,
  finish,
  failure,
  list,
  updatesuccess,
  toggle
}

class AllowanceState extends Equatable {
  final FetchStatus status;
  final List<ListAllowance> listExpense;
  final int? allowanceRate;
  final int? allowanceRateGoverment;
  final int? sumAllowance;
  final int? sumSurplus;
  final num? sumDays;
  final int? sumNet;
  final int? isInternational;
  final List<EmployeesAllRolesEntity> empsallrole;
  final ResponseAllowanceEntity? responseaddallowance;
  final GetExpenseAllowanceByIdEntity? expenseallowancebyid;
  final ResponseDoDeleteAllowanceEntity? responsedeleteallowance;
  final ResponseEditDraftAllowanceEntity? responseeditallowance;
  final List<int>? deleteItem;
  final Failure? error;
  final bool? isdraft;
  const AllowanceState({
    this.status = FetchStatus.initial,
    this.listExpense = const [],
    this.allowanceRate = 500,
    this.allowanceRateGoverment = 270,
    this.sumAllowance = 0,
    this.sumSurplus = 0,
    this.sumDays = 0,
    this.sumNet = 0,
    this.isInternational = 0,
    this.empsallrole = const [],
    this.responseaddallowance,
    this.expenseallowancebyid,
    this.responsedeleteallowance,
    this.responseeditallowance,
    this.deleteItem = const [],
    this.error,
    this.isdraft = false,
  });
  AllowanceState copyWith({
    FetchStatus? status,
    List<ListAllowance>? listExpense,
    int? allowanceRate,
    int? allowanceRateGoverment,
    int? sumAllowance,
    int? sumSurplus,
    num? sumDays,
    int? sumNet,
    int? isInternational,
    List<EmployeesAllRolesEntity>? empsallrole,
    ResponseAllowanceEntity? responseaddallowance,
    GetExpenseAllowanceByIdEntity? expenseallowancebyid,
    ResponseDoDeleteAllowanceEntity? responsedeleteallowance,
    ResponseEditDraftAllowanceEntity? responseeditallowance,
    List<int>? deleteItem,
    Failure? error,
    bool? isdraft,
  }) {
    return AllowanceState(
      status: status ?? this.status,
      listExpense: listExpense ?? this.listExpense,
      empsallrole: empsallrole ?? this.empsallrole,
      allowanceRate: allowanceRate ?? this.allowanceRate,
      allowanceRateGoverment:
          allowanceRateGoverment ?? this.allowanceRateGoverment,
      sumAllowance: sumAllowance ?? this.sumAllowance,
      sumSurplus: sumSurplus ?? this.sumSurplus,
      sumDays: sumDays ?? this.sumDays,
      sumNet: sumNet ?? this.sumNet,
      isInternational: isInternational ?? this.isInternational,
      responseaddallowance: responseaddallowance ?? this.responseaddallowance,
      expenseallowancebyid: expenseallowancebyid ?? this.expenseallowancebyid,
      responsedeleteallowance:
          responsedeleteallowance ?? this.responsedeleteallowance,
      responseeditallowance:
          responseeditallowance ?? this.responseeditallowance,
      deleteItem: deleteItem ?? this.deleteItem,
      error: error ?? this.error,
      isdraft: isdraft ?? this.isdraft,
    );
  }

  @override
  List<Object?> get props => [
        status,
        listExpense,
        allowanceRate,
        allowanceRateGoverment,
        sumAllowance,
        sumSurplus,
        sumDays,
        sumNet,
        isInternational,
        empsallrole,
        responseaddallowance,
        expenseallowancebyid,
        responsedeleteallowance,
        responseeditallowance,
        deleteItem,
        error,
        isdraft,
      ];
}

final class AllowanceInitial extends AllowanceState {
  @override
  List<Object?> get props => [];
}

// final class AllowanceLoading extends AllowanceState {
//   @override
//   List<Object?> get props => [];
// }

// final class AllowanceFinish extends AllowanceState {
//   const AllowanceFinish({
//     this.empsallrole,
//     this.responseaddallowance,
//     this.expenseallowancebyid,
//     this.responsedeleteallowance,
//     this.responseeditallowance,
//   });

//   @override
//   List<Object?> get props => [
//         empsallrole,
//         responseaddallowance,
//         expenseallowancebyid,
//         responsedeleteallowance
//       ];
// }

// final class AllowanceFailure extends AllowanceState {
//   final Failure error;
//   const AllowanceFailure({required this.error});

//   @override
//   List<Object?> get props => [error];
// }
