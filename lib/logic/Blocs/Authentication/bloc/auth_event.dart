import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  PhoneAuthCredential phoneAuthCredential;
  LoginEvent(this.phoneAuthCredential);
}

class LogoutEvent extends AuthEvent {}

class SendCodeEvent extends AuthEvent {
  final String phoneNumber;
  SendCodeEvent({required this.phoneNumber});
}

class VerifyCodeEvent extends AuthEvent {
  final String code;
  VerifyCodeEvent({required this.code});
}

class SignInWithEmailEvent extends AuthEvent {
  final String email;
  final String password;
  SignInWithEmailEvent({required this.email, required this.password});
}

class SignUpWithEmailEvent extends AuthEvent {
  final String email;
  final String password;
  SignUpWithEmailEvent({required this.email, required this.password});
}

class SignInWithGoogleEvent extends AuthEvent {}
