part of 'expensegood_bloc.dart';

// @immutable
abstract class ExpenseGoodEvent extends Equatable {
  const ExpenseGoodEvent();
}

class GetEmployeesAllRolesDataEvent extends ExpenseGoodEvent {
  @override
  List<Object?> get props => [];
}

class GetEmployeesRoleAdminEvent extends ExpenseGoodEvent {
  @override
  List<Object?> get props => [];
}

class CalcualteSumEvent extends ExpenseGoodEvent {
  // final TypePriceModel dataTypePrice;

  // const CalcualteSumEvent({
  //   required this.dataTypePrice,
  // });
  @override
  List<Object?> get props => [];
}

class SelectCurrenyEvent extends ExpenseGoodEvent {
  final ConcurrencyModel selectedCurrency;
  // final num? currentRate;

  const SelectCurrenyEvent({
    required this.selectedCurrency,
    // this.currentRate,
  });
  // final List<ConcurrencyModel> currencies concurrency;

  // const LoadCurrenyEvent({
  //   required this.dataTypePrice,
  // });
  @override
  List<Object?> get props => [selectedCurrency];
}

class SelectTypePriceEvent extends ExpenseGoodEvent {
  final TypePriceModel? selectedTypePrice;

  const SelectTypePriceEvent({
    required this.selectedTypePrice,
  });
  @override
  List<Object?> get props => [selectedTypePrice];
}

class AddListExpenseEvent extends ExpenseGoodEvent {
  final AddListExpenseGood listExpense;

  const AddListExpenseEvent({required this.listExpense});

  @override
  List<Object?> get props => [listExpense];
}

class UpdateListExpenseEvent extends ExpenseGoodEvent {
  final AddListExpenseGood listExpense;

  const UpdateListExpenseEvent({required this.listExpense});

  @override
  List<Object?> get props => [listExpense];
}

class UpdateCurrency extends ExpenseGoodEvent {
  final String? currenRate;

  const UpdateCurrency({required this.currenRate});

  @override
  List<Object?> get props => [currenRate];
}

class DeleteListExpenseEvent extends ExpenseGoodEvent {
  final int index;
  final String? id;
  const DeleteListExpenseEvent({
    required this.index,
    required this.id,
  });

  @override
  List<Object?> get props => [index];
}

class AddExpenseGoodEvent extends ExpenseGoodEvent {
  final int idEmployees;
  final AddExpenseGoodModel addexpensegooddata;
  const AddExpenseGoodEvent({
    required this.idEmployees,
    required this.addexpensegooddata,
  });

  @override
  List<Object?> get props => [
        idEmployees,
        addexpensegooddata,
      ];
}

class GetExpenseGoodByIdEvent extends ExpenseGoodEvent {
  final int idExpense;

  const GetExpenseGoodByIdEvent({
    required this.idExpense,
  });

  @override
  List<Object?> get props => [idExpense];
}

class UpdateExpenseGoodEvent extends ExpenseGoodEvent {
  final int idEmployees;
  final EditDraftExpenseGoodModel editexpensegooddata;
  const UpdateExpenseGoodEvent({
    required this.idEmployees,
    required this.editexpensegooddata,
  });

  @override
  List<Object?> get props => [
        idEmployees,
        editexpensegooddata,
      ];
}

class DeleteExpenseGoodEvent extends ExpenseGoodEvent {
  final int idEmp;
  final DeleteDraftExpenseGoodModel deletefaredata;

  const DeleteExpenseGoodEvent({
    required this.idEmp,
    required this.deletefaredata,
  });
  @override
  List<Object?> get props => [
        idEmp,
        deletefaredata,
      ];
}
