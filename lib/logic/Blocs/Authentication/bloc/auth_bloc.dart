import 'package:baniyabuddy/constants/app_language.dart';
import 'package:baniyabuddy/logic/Blocs/Authentication/bloc/auth_event.dart';
import 'package:baniyabuddy/logic/Blocs/Authentication/bloc/auth_state.dart';
import 'package:baniyabuddy/utils/app_methods.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["profile", "email"]);
  String? _verificationId;

  AuthBloc() : super(InitialAuthState()) {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      emit(LoggedOutState());
    } else {
      emit(LoggedInState(currentUser));
    }
    on<LoginEvent>(_onLoginEvent);
    on<SendCodeEvent>(_onSendCodeEvent);
    on<VerifyCodeEvent>(_onVerifyCodeEvent);
    on<LogoutEvent>(_onLogoutEvent);
    on<SignUpWithEmailEvent>(_onSignUpWithEmailEvent);
    on<SignInWithEmailEvent>(_onSignInWithEmailEvent);
    on<SignInWithGoogleEvent>(_onSignInWithGoogleEvent);
  }
  void _onSignInWithGoogleEvent(event, emit) async {
    emit(AuthLoadingState());
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        emit(AuthErrorState(errorMessage: "Sign in with Google cancelled"));
        return;
      }
      // print(googleUser.toString());
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      // print(googleAuth.toString());
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // print(credential.toString());
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      // print(userCredential.toString());
      if (userCredential.user != null) {
        emit(LoggedInState(userCredential.user!));
      } else {
        emit(AuthErrorState(
            errorMessage: "Sign in with Google failed, Try Again Later!"));
      }
    } on FirebaseException catch (err) {
      emit(AuthErrorState(errorMessage: err.message.toString()));
    } catch (err) {
      emit(AuthErrorState(errorMessage: err.toString()));
    }
  }

  void _onSignInWithEmailEvent(event, emit) async {
    emit(AuthLoadingState());
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      if (userCredential.user != null) {
        emit(LoggedInState(userCredential.user!));
      } else {
        emit(AuthErrorState(errorMessage: "User not found"));
      }
    } on FirebaseException catch (err) {
      emit(AuthErrorState(errorMessage: err.message.toString()));
    }
  }

  void _onSignUpWithEmailEvent(event, emit) async {
    emit(AuthLoadingState());
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      if (userCredential.user != null) {
        emit(SignUpWithEmailSuccessState(userCredential.user!));
      } else {
        emit(AuthErrorState(errorMessage: "User not created"));
      }
    } on FirebaseException catch (err) {
      emit(AuthErrorState(errorMessage: err.message.toString()));
    }
  }

  void _onLogoutEvent(event, emit) async {
    for (final provider in _auth.currentUser!.providerData) {
      if (provider.providerId == 'google.com') {
        // It is a good practice to check before signout but if called directly won't give any error
        _googleSignIn.signOut();
        break;
      }
    }
    await _auth.signOut();
    emit(LoggedOutState());
  }

  void _onVerifyCodeEvent(event, emit) {
    emit(AuthLoadingState());
    // print("Verification Id-2: $_verificationId");
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: event.code,
    );
    add(LoginEvent(credential));
    // signInWithPhone(credential);
  }

  void _onLoginEvent(event, emit) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithCredential(event.phoneAuthCredential);
      if (userCredential.user != null) {
        emit(LoggedInState(userCredential.user!));
      }
    } on FirebaseException catch (err) {
      emit(AuthErrorState(errorMessage: err.message.toString()));
    }
  }

  void _onSendCodeEvent(event, emit) async {
    emit(AuthLoadingState());
    // sendOtp(event.phoneNumber);
    // await Future.delayed(const Duration(seconds: 3));
    String phoneNumber = event.phoneNumber;
    if (phoneNumber.length < 10 || !AppMethods.isNumeric(phoneNumber)) {
      emit(AuthErrorState(errorMessage: AppLanguage.invalidPhoneNumber));
      return;
    }
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91$phoneNumber",
      codeSent: (verificationId, forceResendingToken) {
        _verificationId = verificationId;
        emit(AuthCodeSentState(phoneNumber: phoneNumber));
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
    emit(AuthCodeSentState(phoneNumber: phoneNumber));
  }
  // void sendOtp(String phoneNumber) async {}
  // void verifyOtp(String otp) {}
  // void signInWithPhone(PhoneAuthCredential credential) async {}
}
