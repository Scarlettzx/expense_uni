import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:flutter/foundation.dart';
import 'package:uni_expense/src/features/user/allowance/data/models/edit_draft_allowance_model.dart';
// import 'package:meta/meta.dart';

import '../../../../../core/error/failure.dart';
import '../../data/models/addexpenseallowance_model.dart';
import '../../data/models/delete_expenseallowance_model.dart';
import '../../data/models/listallowance.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/edit_draft_allowance.dart';
import '../../domain/usecases/usecases.dart';

part 'allowance_event.dart';
part 'allowance_state.dart';

class AllowanceBloc extends Bloc<AllowanceEvent, AllowanceState> {
  final GetEmployeesAllRoles getEmployeeAllrolesdata;
  final AddAllowance addexpenseallowancedata;
  final GetExpenseAllowanceById getexpenseAllowancebyId;
  final DeleteAllowance deleteExpensallowancedata;
  final EditAllowance updateAllowancedata;
  List<EmployeesAllRolesEntity> empallrolesData = [];
  AllowanceBloc({
    required this.deleteExpensallowancedata,
    required this.getEmployeeAllrolesdata,
    required this.addexpenseallowancedata,
    required this.getexpenseAllowancebyId,
    required this.updateAllowancedata,
  }) : super(AllowanceInitial()) {
    int allowanceRate = 500;
    int allowanceRateInternational = 4000;
    int govermentAllowanceRate = 270;
    int govermentAllowanceRateInternational = 3100;
    on<AllowanceEvent>((event, emit) {
      print(event.runtimeType);
    });
    on<ToggleIsInternationEvent>((event, emit) {
      final isInter = event.index;

      print(isInter);
      emit(state.copyWith(
        status: FetchStatus.toggle,
        isInternational: isInter,
        allowanceRate:
            (isInter == 0) ? allowanceRate : allowanceRateInternational,
        allowanceRateGoverment: (isInter == 0)
            ? govermentAllowanceRate
            : govermentAllowanceRateInternational,
      ));
    });
    on<CalculateSumEvent>((event, emit) {
      var listexpense = state.listExpense;
      // print('cacu');
      // print(listexpense);
      num? sumCountDay = listexpense.isNotEmpty
          ? listexpense
              .map((item) => item.countDays)
              .reduce((value, element) => value + element)
          : 0;
      num? sumAllowance = (sumCountDay * state.allowanceRate!).toDouble();
      num? totalGovermentAllowance =
          (sumCountDay.ceil() * state.allowanceRateGoverment!);
      num? sumSurplus = totalGovermentAllowance - sumAllowance < 0
          ? sumAllowance - totalGovermentAllowance
          : 0;
      emit(state.copyWith(
        status: FetchStatus.list,
        sumAllowance: sumAllowance.toInt(),
        sumDays: sumCountDay,
        sumNet: sumAllowance.toInt(),
        sumSurplus: sumSurplus.toInt(),
      ));
    });

    on<AddListAllowanceEvent>((event, emit) {
      final newListallowance = List.of(state.listExpense)
        ..add(event.listallowance);
      emit(
        state.copyWith(
          status: FetchStatus.list,
          listExpense: newListallowance,
        ),
      );
    });
    on<DeleteListAllowanceEvent>((event, emit) {
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
    on<UpdateListAllowanceEvent>((event, emit) {
      final newListallowance = state.listExpense.map((list) {
        if (list.idExpenseAllowanceItem ==
            event.listallowance.idExpenseAllowanceItem) {
          return event.listallowance;
        } else {
          return list;
        }
      }).toList();
      emit(
        state.copyWith(
          status: FetchStatus.list,
          listExpense: newListallowance,
        ),
      );
    });
    // ! API
    on<GetEmployeesAllRolesDataEvent>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.loading));
      var resEmpallroles = await getEmployeeAllrolesdata();
      resEmpallroles.fold(
        (l) => emit(state.copyWith(
          status: FetchStatus.failure,
          error: l,
        )),
        (r) => empallrolesData = r,
      );
      emit(state.copyWith(
        status: FetchStatus.finish,
        empsallrole: empallrolesData,
      ));
    });
    on<AddExpenseAllowanceEvent>(((event, emit) async {
      emit(state.copyWith(status: FetchStatus.loading));
      var resaddallowance = await addexpenseallowancedata(
        event.idEmployees,
        event.addallowancedata,
      );
      resaddallowance.fold(
          (l) => emit(state.copyWith(
                status: FetchStatus.failure,
                error: l,
              )), (r) {
        emit(state.copyWith(
          status: FetchStatus.finish,
          responseaddallowance: r,
        ));
      });
    }));
    on<GetExpenseAllowanceByIdData>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.loading));
      var resallowancegetbyid = await getexpenseAllowancebyId(
        event.idExpense,
      );
      resallowancegetbyid.fold(
          (l) => emit(state.copyWith(
                status: FetchStatus.failure,
                error: l,
              )), (r) {
        emit(state.copyWith(
          status: FetchStatus.finish,
          expenseallowancebyid: r,
          listExpense: r.listExpense!.map((e) {
            return ListAllowance(
              idExpenseAllowanceItem: e.idExpenseAllowanceItem.toString(),
              startDate: e.startDate!,
              endDate: e.endDate!,
              description: e.description!,
              countDays: e.countDays!,
            );
          }).toList(),
          isdraft: true,
          isInternational: (r.isInternational == false) ? 0 : 1,
          allowanceRate: (r.isInternational == false)
              ? allowanceRate
              : allowanceRateInternational,
          allowanceRateGoverment: (r.isInternational == false)
              ? govermentAllowanceRate
              : govermentAllowanceRateInternational,
          sumAllowance: r.sumAllowance,
          sumDays: r.sumDays,
          sumNet: r.sumSurplus,
          sumSurplus: r.sumSurplus,
        ));
      });
    });
    on<DeleteExpenseAllowanceEvent>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.loading));
      var resdeleteExpensallowance = await deleteExpensallowancedata(
          event.idEmp, event.deleteallowancedata);
      resdeleteExpensallowance.fold(
          (l) => emit(state.copyWith(
                status: FetchStatus.failure,
                error: l,
              )), (r) {
        emit(state.copyWith(
          status: FetchStatus.finish,
          responsedeleteallowance: r,
        ));
      });
    });
    on<UpdateExpenseAllowanceEvent>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.loading));
      var resEditdraftallowance =
          await updateAllowancedata(event.idEmp, event.editallowancedata);
      resEditdraftallowance.fold(
          (l) => emit(state.copyWith(
                status: FetchStatus.loading,
                error: l,
              )),
          (r) => emit(
                state.copyWith(
                  status: FetchStatus.updatesuccess,
                  responseeditallowance: r,
                ),
              ));
    });
  }
}
