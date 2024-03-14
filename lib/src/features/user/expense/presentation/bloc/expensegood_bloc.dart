import 'dart:convert';

import 'package:bloc/bloc.dart';
// import 'package:dartz/dartz_unsafe.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:uni_expense/src/features/user/expense/data/models/addexpensegood_model.dart';
import '../../../../../components/models/concurrency_model,.dart';
import '../../../../../components/models/typeprice_model.dart';
import '../../../../../core/error/failure.dart';
import '../../data/models/addlist_expensegood.dart';
import '../../data/models/delete_expensegood_model.dart';
import '../../data/models/editdraft_expensegood_model.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

part 'expensegood_event.dart';
part 'expensegood_state.dart';

class ExpenseGoodBloc extends Bloc<ExpenseGoodEvent, ExpenseGoodState> {
  final GetEmployeesAllRoles getEmployeesAllrolesdata;
  final GetEmployeesRoleAdmin getEmployeesRoleadmin;
  final AddExpenseGood addexpensegooddata;
  final GetExpenseById getexpensebyiddata;
  final DeleteExpenseGood dodeletedata;
  final EditExpenseGood editexpensegooddata;
  List<EmployeesAllRolesEntity> empallrolesData = [];
  List<EmployeeRoleAdminEntity> emproleadminData = [];
  ExpenseGoodBloc({
    required this.getEmployeesAllrolesdata,
    required this.getEmployeesRoleadmin,
    required this.addexpensegooddata,
    required this.getexpensebyiddata,
    required this.editexpensegooddata,
    required this.dodeletedata,
  }) : super(ExpenseGoodInitial()) {
    on<ExpenseGoodEvent>((event, emit) {
      print(event.runtimeType);
    });
    on<GetEmployeesAllRolesDataEvent>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.loading));
      var resEmpallroles = await getEmployeesAllrolesdata();
      var resEmproleadmin = await getEmployeesRoleadmin();
      final jsonContent =
          await rootBundle.loadString('assets/json/concurrency.json');
      final jsonContent2 =
          await rootBundle.loadString('assets/json/typeprice.json');
      print(concurrencyModelFromJson(jsonContent));
      print(concurrencyModelFromJson(jsonContent2));
      final loadedCurrencies = concurrencyModelFromJson(jsonContent);
      final loadedTypPrice = typePriceModelFromJson(jsonContent2);
      resEmpallroles.fold(
          (l) => emit(state.copyWith(
                status: FetchStatus.failure,
                error: l,
              )),
          (r) => empallrolesData = r);
      resEmproleadmin.fold(
          (l) => emit(state.copyWith(
                status: FetchStatus.failure,
                error: l,
              )),
          (r) => emproleadminData = r);
      emit(state.copyWith(
        status: FetchStatus.finish,
        // selectedTypePrice: loadedTypPrice.first,
        // selectedCurrency: loadedCurrencies.first,
        empsallrole: empallrolesData,
        empsroleadmin: emproleadminData,
        currency: loadedCurrencies,
        typeprice: loadedTypPrice,
      ));
    });
    on<SelectTypePriceEvent>((event, emit) {
      print('---------------------------------------');
      print(jsonEncode(event.selectedTypePrice));
      print('---------------------------------------');
      final selectTypePrice = event.selectedTypePrice;
      emit(state.copyWith(
        status: FetchStatus.loadcurrency,
        selectedTypePrice: selectTypePrice,
      ));
    });
    on<CalcualteSumEvent>((event, emit) {
      num convertCurrency(num value) {
        return (state.currencyRate != null && state.currencyRate != 0)
            ? double.parse((value * state.currencyRate!).toStringAsFixed(2))
            : 0;
      }

      // print(jsonEncode(event.dataTypePrice));
      print("state.listExpense");
      print(state.listExpense);
      print("state.selectedTypePrice");
      print(jsonEncode(state.selectedTypePrice));
      print("state.selectedCurrency");
      print(jsonEncode(state.selectedCurrency));
      print("state.currencyRate----");
      print(state.currencyRate);
      // print("jsonEncode(state.listExpense)");
      var listexpense = state.listExpense;
      for (int index = 0; index < listexpense.length; index++) {
        var item = listexpense[index];
        final unitPrice = (state.selectedTypePrice!.isVatIncluded == true)
            ? double.parse(((item.unitPrice! * 100) /
                    (100 + state.selectedTypePrice!.vat!.toDouble()))
                .toStringAsFixed(4))
            : double.parse(item.unitPrice!.toStringAsFixed(2));
        final newtotal = double.parse(
            (item.amount!.toDouble() * unitPrice).toStringAsFixed(2));

        final newtax = double.parse(
            (newtotal * state.selectedTypePrice!.vat!.toDouble() / 100)
                .toStringAsFixed(2));

        final newwithholding = double.parse(
            (newtotal * item.withholdingPercent!.toDouble() / 100)
                .toStringAsFixed(2));
        final newTotalPrice = newtotal + newtax;
        final net = newtotal + newtax - newwithholding;
        print(state.listExpense);
        print(unitPrice);
        print(newtotal);
        print(newtax);
        print(newTotalPrice);
        print(newwithholding);
        print(net);
        print("---------------");
        print(convertCurrency(unitPrice));
        print(convertCurrency(newtotal));
        print(convertCurrency(newtax));
        print(convertCurrency(newTotalPrice));
        print(convertCurrency(newwithholding));
        print(convertCurrency(net));
        if (state.selectedCurrency!.code == "TH") {
          var updatedItem = item.copyWith(
            taxPercent: state.selectedTypePrice!.vat!,
            tax: newtax,
            withholding: newwithholding,
            total: newtotal,
            totalPrice: newTotalPrice,
            net: net,
            unitPriceInternational: -1,
            taxInternational: -1,
            withholdingInternational: -1,
            totalBeforeTaxInternational: -1,
            totalPriceInternational: -1,
            netInternational: -1,
          );
          listexpense[index] = updatedItem;
          print("listexpense");
          print(listexpense[index]);
          print("updatedItem");
          print(updatedItem);
        } else if (state.selectedCurrency!.code != "TH") {
          // print('state.selectedCurrency!.code != "TH"');
          var updatedItem = item.copyWith(
            taxPercent: state.selectedTypePrice!.vat!,
            tax: newtax,
            withholding: newwithholding,
            total: newtotal,
            totalPrice: newTotalPrice,
            net: net,
            unitPriceInternational: convertCurrency(item.unitPrice!),
            taxInternational: convertCurrency(newtax),
            withholdingInternational: convertCurrency(newwithholding),
            totalBeforeTaxInternational: convertCurrency(newtotal),
            totalPriceInternational: convertCurrency(newTotalPrice),
            netInternational: convertCurrency(net),
          );
          listexpense[index] = updatedItem;
          print("listexpenseinter");
          print(listexpense[index]);
        }
      }

      num? total = state.listExpense.isNotEmpty
          ? state.listExpense
              .map((item) => item.total)
              .reduce((value, element) => value! + element!)
          : 0;

      num? vat = state.listExpense.isNotEmpty
          ? state.listExpense
              .map((item) => item.tax)
              .reduce((value, element) => value! + element!)
          : 0;

      num? withholding = state.listExpense.isNotEmpty
          ? state.listExpense
              .map((item) => item.withholding)
              .reduce((value, element) => value! + element!)
          : 0;
      num? net = total! + vat! - withholding!;
      // print(jsonEncode(listexpense));
      emit(state.copyWith(
        status: FetchStatus.list,
        listExpense: listexpense,
        total: (state.selectedCurrency!.code != "TH")
            ? convertCurrency(total)
            : total,
        vat:
            (state.selectedCurrency!.code != "TH") ? convertCurrency(vat) : vat,
        withholding: (state.selectedCurrency!.code != "TH")
            ? convertCurrency(withholding)
            : withholding,
        net:
            (state.selectedCurrency!.code != "TH") ? convertCurrency(net) : net,
      ));
    });
    on<SelectCurrenyEvent>((event, emit) {
      print('---------------------------------------');
      print(jsonEncode(event.selectedCurrency));
      print('---------------------------------------');
      // print(state.currencyRate);
      final selectcurrency = event.selectedCurrency;
      (state.currencyRate == null)
          ? emit(state.copyWith(
              status: FetchStatus.loadcurrency,
              selectedCurrency: selectcurrency,
              currencyRate: (selectcurrency.code == "TH") ? null : 1,
            ))
          : emit(state.copyWith(
              status: FetchStatus.loadcurrency,
              selectedCurrency: selectcurrency,
              currencyRate:
                  (selectcurrency.code == "TH") ? 1 : state.currencyRate,
            ));

      // if(event.selectedCurrency.code == 'TH'){

      // }
      // emit(state.copyWith(status: FetchStatus.loading));
    });
    on<UpdateCurrency>((event, emit) {
      emit(state.copyWith(status: FetchStatus.loading));
      final currencyrate = event.currenRate;
      print(event.currenRate);
      print(state.currencyRate);
      emit(state.copyWith(
        status: FetchStatus.loadcurrency,
        currencyRate: double.tryParse(currencyrate!),
      ));
    });

    on<UpdateListExpenseEvent>((event, emit) {
      final newListLocationandFuel = state.listExpense.map((list) {
        if (list.idExpenseGoodsItem == event.listExpense.idExpenseGoodsItem) {
          return event.listExpense;
        } else {
          return list;
        }
      }).toList();
      // print("newListLocationandFuel");
      // print(newListLocationandFuel);
      emit(
        state.copyWith(
          status: FetchStatus.list,
          listExpense: newListLocationandFuel,
        ),
      );
    });
    on<DeleteListExpenseEvent>((event, emit) {
      final indexToRemove = event.index;
      print(state.isdraft);
      final newListLocationandFuel = List.of(state.listExpense);
      if (indexToRemove >= 0 && indexToRemove < newListLocationandFuel.length) {
        if (state.isdraft == true && event.id != null) {
          final datadeleteItem = List.of(state.deleteItem!)
            ..add(int.tryParse(event.id!)!);
          print(datadeleteItem);
          newListLocationandFuel.removeAt(indexToRemove);
          emit(state.copyWith(
            status: FetchStatus.list,
            listExpense: newListLocationandFuel,
            deleteItem: datadeleteItem,
          ));
        } else {
          newListLocationandFuel.removeAt(indexToRemove);
          emit(state.copyWith(
              status: FetchStatus.list, listExpense: newListLocationandFuel));
        }
      }
    });
    on<AddListExpenseEvent>((event, emit) {
      final newListExpense = List.of(state.listExpense)..add(event.listExpense);
      print(newListExpense);
      emit(state.copyWith(
          status: FetchStatus.list, listExpense: newListExpense));
    });
    // ! Add Api(addfare) passing Formdata
    on<AddExpenseGoodEvent>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.loading));
      var resddexepnsefaredata =
          await addexpensegooddata(event.idEmployees, event.addexpensegooddata);
      resddexepnsefaredata.fold(
          (l) => emit(state.copyWith(
                error: l,
                status: FetchStatus.failure,
              )),
          (r) => emit(
                state.copyWith(
                  status: FetchStatus.finish,
                  responseaddexpensegood: r,
                ),
              ));
      // print(state);
      // emit.
    });
    on<GetExpenseGoodByIdEvent>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.loading));
      var responsegetexpensebyid = await getexpensebyiddata(event.idExpense);
      responsegetexpensebyid.fold(
        (l) => emit(state.copyWith(
          error: l,
          status: FetchStatus.failure,
        )),
        (r) {
          emit(
            state.copyWith(
              status: FetchStatus.finish,
              listExpense: r.listExpense!.map((e) {
                return AddListExpenseGood(
                  idExpenseGoodsItem: e.idExpenseGoodsItem.toString(),
                  documentDate: e.documentDate,
                  service: e.service,
                  description: e.description,
                  amount: e.amount,
                  unitPrice: e.unitPrice,
                  net: e.net,
                  tax: e.tax,
                  taxPercent: e.taxPercent,
                  total: e.total,
                  totalPrice: e.totalPrice,
                  withholdingPercent: e.withholdingPercent,
                  withholding: e.withholding,
                  unitPriceInternational: e.unitPriceInternational,
                  totalBeforeTaxInternational: e.totalBeforeTaxInternational,
                  totalPriceInternational: e.totalPriceInternational,
                  taxInternational: e.taxInternational,
                  withholdingInternational: e.withholdingInternational,
                  netInternational: e.netInternational,
                );
              }).toList(),
              getexpensebyid: r,
              isdraft: true,
              currencyRate: r.currencyRate,
              total: r.total,
              vat: r.vat,
              withholding: r.withholding,
              net: r.net,
            ),
          );
        },
      );
    });
    on<UpdateExpenseGoodEvent>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.loading));
      var responseeditfare = await editexpensegooddata(
          event.idEmployees, event.editexpensegooddata);
      responseeditfare.fold(
          (l) => emit(state.copyWith(
                error: l,
                status: FetchStatus.failure,
              )),
          (r) => emit(
                state.copyWith(
                  status: FetchStatus.updatesuccess,
                  responseeditexpensegood: r,
                ),
              ));
    });
    on<DeleteExpenseGoodEvent>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.loading));
      var responsedeletefare =
          await dodeletedata(event.idEmp, event.deletefaredata);
      responsedeletefare.fold(
          (l) => emit(state.copyWith(
                error: l,
                status: FetchStatus.failure,
              )),
          (r) => emit(
                state.copyWith(
                  status: FetchStatus.finish,
                  responsedodeletexpensegood: r,
                ),
              ));
    });
  }
}
