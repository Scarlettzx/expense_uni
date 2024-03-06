import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'src/features/user/allowance/domain/usecases/edit_draft_allowance.dart';
import 'src/features/user/fare/domain/repositories/fare_repository.dart';
import 'src/features/user/fare/presentation/bloc/fare_bloc.dart';
import 'src/features/user/fare/presentation/bloc/fare_observer.dart';
import 'src/features/user/manageitems/domain/repositories/manageitems_repository.dart';
import 'src/features/user/manageitems/presentation/bloc/manage_items_bloc.dart';
import 'src/features/user/welfare/data/data_sources/welfare_remote_datasource.dart';
import 'src/features/user/welfare/data/repositories/welfare_repositoryimpl.dart';
import 'src/features/user/welfare/domain/repositories/welfare_repository.dart';
import 'src/features/user/welfare/domain/usecases/usecases.dart';
import 'src/features/user/welfare/presentation/bloc/welfare_bloc.dart';
import 'src/core/features/login/data/data_sources/remote/login_api.dart';
import 'src/core/features/login/data/repositories/login_repository_impl.dart';
import 'src/core/features/login/domain/repositories/login_repository.dart';
import 'src/core/features/login/domain/use_cases/login_usecase.dart';
import 'src/core/features/login/presentation/bloc/login_bloc.dart';
import 'src/core/features/user/domain/usecase/get_profile.dart';
import 'src/features/user/allowance/data/repositories/allowance_repositoryimpl.dart';
import 'src/features/user/allowance/domain/usecases/usecases.dart';
import 'src/features/user/allowance/presentation/bloc/allowance_bloc.dart';
import 'src/features/user/expense/data/data_sources/expensegood_remote_datasource.dart';
import 'src/features/user/expense/data/repositories/expensegood_repository_impl.dart';
import 'src/features/user/expense/domain/repositories/expensegood_repository.dart';
import 'src/features/user/allowance/data/data_sources/allowance_remote_datasource.dart';
import 'src/features/user/allowance/domain/repositories/allowance_repository.dart';
import 'src/features/user/expense/domain/usecases/usecases.dart'
    as usecases_expense;
import 'src/features/user/allowance/domain/usecases/usecases.dart'
    as usecases_allowance;
import 'src/features/user/expense/presentation/bloc/expensegood_bloc.dart';
import 'src/features/user/familyrights/data/data_sources/familyrights_remote_datasource.dart';
import 'src/features/user/familyrights/data/repositories/familyrights_repositoryimpl.dart';
import 'src/features/user/familyrights/domain/repositories/familyrights_repository.dart';
import 'src/features/user/familyrights/domain/usecases/usecases.dart';
import 'src/features/user/familyrights/presentation/bloc/familyrights_bloc.dart';
import 'src/features/user/fare/data/data_sources/fare_remote_datasource.dart';
import 'src/features/user/fare/data/respositories/fare_repositoryimpl.dart';
import 'src/features/user/fare/domain/usecases/usecases.dart';
import 'src/features/user/manageitems/data/data_sources/manageitems_remote_datasource.dart';
import 'src/features/user/manageitems/data/reporitories/manageitems_repositoryimpl.dart';
import 'src/features/user/manageitems/domain/usecases/usecases.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ! ExpenseGood
  // * Bloc
  sl.registerFactory(() => ExpenseGoodBloc(
        getEmployeesAllrolesdata: sl(),
        getEmployeesRoleadmin: sl(),
      ));
  // * Usecase
  sl.registerLazySingleton(
      () => usecases_expense.GetEmployeesAllRoles(repository: sl()));
  sl.registerLazySingleton(
      () => usecases_expense.GetEmployeesRoleAdmin(repository: sl()));
  // * Repository
  sl.registerLazySingleton<ExpenseGoodRepository>(
      () => ExpenseGoodRepositoryImpl(remoteDatasource: sl()));
  // * Data Source
  sl.registerLazySingleton<ExpenseGoodRemoteDatasource>(
      () => ExpenseGoodRemoteDatasourceImpl(client: sl()));

  // ! Allowance
  // * Bloc
  sl.registerFactory(() => AllowanceBloc(
        deleteExpensallowancedata: sl(),
        getEmployeeAllrolesdata: sl(),
        addexpenseallowancedata: sl(),
        getexpenseAllowancebyId: sl(),
        updateAllowancedata: sl(),
      ));
  // * Usecase
  sl.registerLazySingleton(() => usecases_allowance.GetEmployeesAllRoles(
        repository: sl(),
      ));
  sl.registerLazySingleton(() => AddAllowance(
        repository: sl(),
      ));
  sl.registerLazySingleton(() => GetExpenseAllowanceById(
        repository: sl(),
      ));
  sl.registerLazySingleton(() => DeleteAllowance(
        repository: sl(),
      ));
  sl.registerLazySingleton(() => EditAllowance(
        repository: sl(),
      ));
  // * Repository
  sl.registerLazySingleton<AllowanceRepository>(
      () => AllowanceRepositoryImpl(remoteDatasource: sl()));
  // * Data Source
  sl.registerLazySingleton<AllowanceRemoteDatasource>(
      () => AllowanceRemoteDatasourceImpl(client: sl()));

// ! ManageItems
  // * Bloc
  sl.registerFactory(() => ManageItemsBloc(
        getmanageitems: sl(),
      ));
  // * Usecase
  sl.registerLazySingleton(() => GetManageItems(
        repository: sl(),
      ));
  // * Repository
  sl.registerLazySingleton<ManageItemsRepository>(
      () => ManageItemsRepositoryImpl(remoteDatasource: sl()));
  // * Data Source
  sl.registerLazySingleton<ManageItemsRemoteDatasource>(
      () => ManageItemsRemoteDatasourceImpl(client: sl()));

// ! Welfare
  // * Bloc
  sl.registerFactory(() => WelfareBloc(
        editWelfare: sl(),
        getFamilysdata: sl(),
        getEmployeeAllrolesdata: sl(),
        addWelfare: sl(),
        getWelfareByiddata: sl(),
        deleteWelfare: sl(),
      ));
  // * Usecase
  sl.registerLazySingleton(() => GetEmployeesAllRolesWelfare(repository: sl()));
  sl.registerLazySingleton(() => GetFamilys(repository: sl()));
  sl.registerLazySingleton(() => AddWelfare(repository: sl()));
  sl.registerLazySingleton(() => GetWelfareByid(repository: sl()));
  sl.registerLazySingleton(() => EditWelfare(repository: sl()));
  sl.registerLazySingleton(() => DeleteWelfare(repository: sl()));

  // * Repository
  sl.registerLazySingleton<WelfareRepository>(
      () => WelfareRepositoryImpl(remoteDatasource: sl()));
  // * Data Source
  sl.registerLazySingleton<WelfareRemoteDatasource>(
      () => WelfareRemoteDatasourceImpl(client: sl()));

// ! Familyrights
  // * Bloc
  sl.registerFactory(() => FamilyrightsBloc(
        getAllRightsFamily: sl(),
      ));
  // * Usecase
  sl.registerLazySingleton(() => GetAllRightsFamily(
        repository: sl(),
      ));
  // * Repository
  sl.registerLazySingleton<FamilyRightsRepository>(
      () => FamilyRightsRepositoryImpl(remoteDatasource: sl()));
  // * Data Source
  sl.registerLazySingleton<FamilyRightsRemoteDataSource>(
      () => FamilyRightsRemoteDataSourceImpl(client: sl()));

// ! Fare
  // sl.registerLazySingleton(() => FareObserver());

  // * Bloc
  sl.registerFactory(() => FareBloc(
        addexepnsefaredata: sl(),
        getEmployeesAllrolesdata: sl(),
        getfarebyiddata: sl(),
        editfaredata: sl(),
      ));
  // * Usecase
  sl.registerLazySingleton(() => GetEmployeesAllRolesFare(
        repository: sl(),
      ));
  sl.registerLazySingleton(() => AddFare(
        repository: sl(),
      ));
  sl.registerLazySingleton(() => GetFareByid(
        repository: sl(),
      ));
  sl.registerLazySingleton(() => EditFare(
        repository: sl(),
      ));
  // * Repository
  sl.registerLazySingleton<FareRepository>(
      () => FareRepositoryImpl(remoteDatasource: sl()));
  // * Data Source
  sl.registerLazySingleton<FareRemoteDatasource>(
      () => FareRemoteDatasourceImpl(client: sl()));
// ! User
  // * Bloc
  sl.registerFactory(() => LoginBloc(
        loginUseCase: sl(),
      ));
  // * UseCase
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetProfile(repository: sl()));
  // * Repository
  sl.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(loginApi: sl()));
  // * Data Source
  sl.registerLazySingleton<LoginApi>(() => LoginApiImpl(client: sl()));

  // * External
  sl.registerLazySingleton(() => http.Client());
}
