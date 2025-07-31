import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  LoginEvent(this.email);
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>((event, emit) {
      if (event.email.isEmpty) {
        emit(AuthError('Введите email'));
      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(event.email)) {
        emit(AuthError('Некорректный email'));
      } else {
        emit(AuthSuccess());
      }
    });
  }
}