import 'package:baniyabuddy/logic/Blocs/Authentication/bloc/auth_event.dart';
import 'package:baniyabuddy/logic/Blocs/Authentication/bloc/auth_state.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;

  AuthBloc() : super(InitialAuthState()) {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      emit(LoggedOutState());
    } else {
      emit(LoggedInState(currentUser));
    }
    on<LoginEvent>((event, emit) async {
      try {
        UserCredential userCredential =
            await _auth.signInWithCredential(event.phoneAuthCredential);
        if (userCredential.user != null) {
          emit(LoggedInState(userCredential.user!));
        }
      } on FirebaseException catch (err) {
        emit(AuthErrorState(errorMessage: err.message.toString()));
      }
    });
    on<SendCodeEvent>((event, emit) async {
      emit(AuthLoadingState());
      // sendOtp(event.phoneNumber);
      // await Future.delayed(const Duration(seconds: 3));
      await _auth.verifyPhoneNumber(
        phoneNumber: event.phoneNumber,
        codeSent: (verificationId, forceResendingToken) {
          _verificationId = verificationId;
          emit(AuthCodeSentState());
        },
        verificationCompleted: (phoneAuthCredential) {
          // signInWithPhone();
          // print("LoginEvent added");
          add(LoginEvent(phoneAuthCredential));
        },
        codeAutoRetrievalTimeout: (verificationId) {
          _verificationId = verificationId;
        },
        verificationFailed: (err) {
          emit(AuthErrorState(errorMessage: err.message.toString()));
        },
      );
      // print("Verification Id-1: $_verificationId");
      emit(AuthCodeSentState());
    });
    on<VerifyCodeEvent>((event, emit) {
      emit(AuthLoadingState());
      // print("Verification Id-2: $_verificationId");
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: event.code,
      );
      add(LoginEvent(credential));
      // signInWithPhone(credential);
    });
    on<LogoutEvent>((event, emit) {
      // print("Verification Id-3: $_verificationId");
      // print("Current User: $currentUser");
      _auth.signOut();
      emit(LoggedOutState());
    });
  }
  // void sendOtp(String phoneNumber) async {}
  // void verifyOtp(String otp) {}
  // void signInWithPhone(PhoneAuthCredential credential) async {}
}
