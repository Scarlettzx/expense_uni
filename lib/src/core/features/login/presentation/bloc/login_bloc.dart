import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../error/failure.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/use_cases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  LoginBloc({
    required this.loginUseCase,
  }) : super(LoginInitial()) {
    on<LoginEventDoLogin>((event, emit) async {
      emit(LoginStateLoading());
      await Future.delayed(const Duration(seconds: 2));
      var resultLogin = await loginUseCase(event.username, event.password);
      resultLogin.fold(
        (l) => emit(
          LoginStateFailure(error: l),
        ),
        (r) => emit(
          LoginStateSuccess(
            loginEntity: r,
            isLogin: true,
          ),
        ),
      );
    });
  }
}
