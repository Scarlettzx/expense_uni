part of 'expensegood_bloc.dart';

enum FetchStatus {
  initial,
  loading,
  finish,
  failure,
  list,
  loadcurrency,
  updatesuccess
}

class ExpenseGoodState extends Equatable {
  final FetchStatus status;
  final List<AddListExpenseGood> listExpense;
  final List<EmployeesAllRolesEntity> empsallrole;
  final List<EmployeeRoleAdminEntity> empsroleadmin;
  final ResponseAdddExpenseGoodEntity? responseaddexpensegood;
  final ResponseEditDraftExpenseGoodEntity? responseeditexpensegood;
  final ResponseDoDeleteExpenseGoodEntity? responsedodeletexpensegood;
  final ConcurrencyModel? selectedCurrency;
  final TypePriceModel? selectedTypePrice;
  final List<TypePriceModel>? typeprice;
  final GetExpenseGoodByIdEntity? getexpensebyid;
  final Failure? error;
  final bool? isdraft;
  final num? currencyRate;
  final num? total;
  final num? vat;
  final num? withholding;
  final num? net;
  // final bool? selectPriceisInter;
  final List<int>? deleteItem;
  final List<ConcurrencyModel>? currency;

  const ExpenseGoodState({
    this.status = FetchStatus.initial,
    this.listExpense = const [],
    this.empsallrole = const [],
    this.empsroleadmin = const [],
    this.responseaddexpensegood,
    this.responseeditexpensegood,
    this.responsedodeletexpensegood,
    this.selectedCurrency,
    this.error,
    this.isdraft = false,
    this.currencyRate,
    this.total = 0,
    this.vat = 0,
    this.withholding = 0,
    this.net = 0,
    this.currency = const [],
    this.typeprice = const [],
    this.getexpensebyid,
    this.selectedTypePrice,
    // this.selectPriceisInter = false,
    this.deleteItem = const [],
  });
  ExpenseGoodState copyWith({
    FetchStatus? status,
    List<AddListExpenseGood>? listExpense,
    List<EmployeesAllRolesEntity>? empsallrole,
    List<EmployeeRoleAdminEntity>? empsroleadmin,
    ResponseAdddExpenseGoodEntity? responseaddexpensegood,
    ResponseEditDraftExpenseGoodEntity? responseeditexpensegood,
    ResponseDoDeleteExpenseGoodEntity? responsedodeletexpensegood,
    List<TypePriceModel>? typeprice,
    ConcurrencyModel? selectedCurrency,
    TypePriceModel? selectedTypePrice,
    GetExpenseGoodByIdEntity? getexpensebyid,
    Failure? error,
    num? currencyRate,
    num? total,
    num? vat,
    num? withholding,
    num? net,
    bool? isdraft,
    List<ConcurrencyModel>? currency,
    List<int>? deleteItem,
  }) {
    return ExpenseGoodState(
      status: status ?? this.status,
      listExpense: listExpense ?? this.listExpense,
      empsallrole: empsallrole ?? this.empsallrole,
      empsroleadmin: empsroleadmin ?? this.empsroleadmin,
      responseaddexpensegood:
          responseaddexpensegood ?? this.responseaddexpensegood,
      responseeditexpensegood:
          responseeditexpensegood ?? this.responseeditexpensegood,
      responsedodeletexpensegood:
          responsedodeletexpensegood ?? this.responsedodeletexpensegood,
      typeprice: typeprice ?? this.typeprice,
      selectedCurrency: selectedCurrency ?? this.selectedCurrency,
      selectedTypePrice: selectedTypePrice ?? this.selectedTypePrice,
      error: error ?? this.error,
      currencyRate: currencyRate ?? this.currencyRate,
      getexpensebyid: getexpensebyid ?? this.getexpensebyid,
      total: total ?? this.total,
      vat: vat ?? this.vat,
      withholding: withholding ?? this.withholding,
      net: net ?? this.net,
      isdraft: isdraft ?? this.isdraft,
      currency: currency ?? this.currency,
      deleteItem: deleteItem ?? this.deleteItem,
    );
  }

  @override
  List<Object?> get props => [
        status,
        listExpense,
        empsallrole,
        empsroleadmin,
        responseaddexpensegood,
        responseeditexpensegood,
        responsedodeletexpensegood,
        typeprice,
        selectedCurrency,
        selectedTypePrice,
        getexpensebyid,
        error,
        currencyRate,
        total,
        vat,
        withholding,
        net,
        isdraft,
        currency,
        deleteItem,
      ];
}

final class ExpenseGoodInitial extends ExpenseGoodState {
  @override
  List<Object?> get props => [];
}

// final class ExpenseGoodLoading extends ExpenseGoodState {
//   @override
//   List<Object?> get props => [];
// }

// final class ExpenseGoodFinish extends ExpenseGoodState {
//   final List<EmployeesAllRolesEntity>? empsallrole;
//   final List<EmployeeRoleAdminEntity>? empsroleadmin;
//   const ExpenseGoodFinish({this.empsallrole, this.empsroleadmin});
//   @override
//   List<Object?> get props => [empsallrole, empsroleadmin];
// }

// final class ExpenseGoodFailure extends ExpenseGoodState {
//   final Failure error;

//   const ExpenseGoodFailure({required this.error});

//   @override
//   List<Object?> get props => [error];
// }
