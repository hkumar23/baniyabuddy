import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class InitialAuthState extends AuthState {}

class AuthCodeSentState extends AuthState {}

class AuthCodeVerifiedState extends AuthState {}

class LoggedInState extends AuthState {
  final User user;
  LoggedInState(this.user);
}

class LoggedOutState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthErrorState extends AuthState {
  final String errorMessage;
  AuthErrorState({required this.errorMessage});
}
