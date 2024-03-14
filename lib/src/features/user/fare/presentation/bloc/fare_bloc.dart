import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failure.dart';
import '../../data/models/add_fare_model.dart';
import '../../data/models/addlist_location_fuel.dart';
import '../../data/models/delete_fare_model.dart';
import '../../data/models/edit_draft_fare_model.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

part 'fare_event.dart';
part 'fare_state.dart';

class FareBloc extends Bloc<FareEvent, FareState> {
  final GetEmployeesAllRolesFare getEmployeesAllrolesdata;
  final AddFare addexepnsefaredata;
  final GetFareByid getfarebyiddata;
  final EditFare editfaredata;
  final DeleteFare deletefaredata;
  List<EmployeesAllRolesEntity> empallrolesData = [];
  FareBloc({
    required this.getEmployeesAllrolesdata,
    required this.addexepnsefaredata,
    required this.editfaredata,
    required this.getfarebyiddata,
    required this.deletefaredata,
  }) : super(FareInitial()) {
    on<FareEvent>((event, emit) {
      print(event.runtimeType);
    });

    on<AddListLocationAndFuelEvent>((event, emit) {
      final newListLocationandFuel = List.of(state.listlocationandfuel)
        ..add(event.listlocationandfuel);
      emit(
        state.copyWith(
          status: FetchStatus.list,
          listlocationandfuel: newListLocationandFuel,
        ),
      );
    });

    on<UpdateListLocationAndFuelEvent>((event, emit) {
      final newListLocationandFuel = state.listlocationandfuel.map((list) {
        if (list.id == event.listlocationandfuel.id) {
          return event.listlocationandfuel;
        } else {
          return list;
        }
      }).toList();
      emit(
        state.copyWith(
          status: FetchStatus.list,
          listlocationandfuel: newListLocationandFuel,
        ),
      );
    });
    //! Delete Todo Event Hanlder
    on<DeleteListLocationAndFuelEvent>((event, emit) {
      final indexToRemove = event.index;
      // print(state.isdraft);
      final newListLocationandFuel = List.of(state.listlocationandfuel);
      if (indexToRemove >= 0 && indexToRemove < newListLocationandFuel.length) {
        if (state.isdraft == true && event.id != null) {
          final datadeleteItem = List.of(state.deleteItem!)
            ..add(int.tryParse(event.id!)!);
          print(datadeleteItem);
          newListLocationandFuel.removeAt(indexToRemove);
          emit(state.copyWith(
            status: FetchStatus.list,
            listlocationandfuel: newListLocationandFuel,
            deleteItem: datadeleteItem,
          ));
        } else {
          newListLocationandFuel.removeAt(indexToRemove);
          emit(state.copyWith(
              status: FetchStatus.list,
              listlocationandfuel: newListLocationandFuel));
        }
      }
    });
    on<GetEmployeesAllRolesEvent>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.loading));
      var resEmpallroles = await getEmployeesAllrolesdata();
      resEmpallroles.fold(
        (l) => emit(state.copyWith(status: FetchStatus.failure, error: l)),
        (r) => empallrolesData = r,
      );
      emit(state.copyWith(
          status: FetchStatus.finish, empallrole: empallrolesData));
    });
    // ! Add Api(addfare) passing Formdata
    on<AddExpenseFareEvent>((event, emit) async {
      // print(state);
      emit(state.copyWith(status: FetchStatus.loading));
      var resddexepnsefaredata =
          await addexepnsefaredata(event.idEmployees, event.addfaredata);
      resddexepnsefaredata.fold(
          (l) => emit(state.copyWith(error: l)),
          (r) => emit(
                state.copyWith(
                  status: FetchStatus.finish,
                  responseaddfare: r,
                ),
              ));
      // print(state);
      // emit.
    });
    on<GetFareByIdEvent>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.loading));
      var responsegetfarebyid = await getfarebyiddata(event.idExpense);
      responsegetfarebyid.fold(
        (l) => emit(state.copyWith(error: l)),
        (r) => emit(
          state.copyWith(
            status: FetchStatus.finish,
            listlocationandfuel: r.listExpense!.map((e) {
              // สร้าง ListLocationandFuel จากข้อมูลที่ได้รับ
              return ListLocationandFuel(
                id: e.idExpenseMileageItem.toString(),
                date: e.date!,
                startMile: e.startMile!,
                stopMile: e.stopMile!,
                startLocation: e.startLocation!,
                stopLocation: e.stopLocation!,
                net: e.net!,
                personal: e.personal!,
                total: e.total!,
              );
            }).toList(),
            getfarebyid: r,
            isdraft: true,
          ),
        ),
      );
    });
    on<UpdateFareEvent>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.loading));
      var responseeditfare =
          await editfaredata(event.idEmployees, event.editfaredata);
      responseeditfare.fold(
          (l) => emit(state.copyWith(
                status: FetchStatus.failure,
              )),
          (r) => emit(
                state.copyWith(
                  status: FetchStatus.updatesuccess,
                  responseeditfare: r,
                ),
              ));
    });

    on<DeleteExpenseFareEvent>((event, emit) async {
      emit(state.copyWith(status: FetchStatus.loading));
      var responsedeletefare =
          await deletefaredata(event.idEmp, event.deletefaredata);
      responsedeletefare.fold(
          (l) => emit(state.copyWith(
                status: FetchStatus.failure,
              )),
          (r) => emit(
                state.copyWith(
                  status: FetchStatus.finish,
                  responsdodeletefare: r,
                ),
              ));
    });
  }
}
