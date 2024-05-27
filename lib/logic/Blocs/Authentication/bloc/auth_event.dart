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
