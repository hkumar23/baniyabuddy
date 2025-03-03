import 'package:baniyabuddy/constants/app_constants.dart';
import 'package:baniyabuddy/data/repositories/transaction_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../data/repositories/user_repo.dart';
// import '../../../../data/repositories/business_repo.dart';
import '../../../../constants/app_language.dart';
import '../../../../data/repositories/invoice_repo.dart';
import '../../../../logic/Blocs/Authentication/bloc/auth_event.dart';
import '../../../../logic/Blocs/Authentication/bloc/auth_state.dart';
import '../../../../utils/app_methods.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["profile", "email"]);
  String? _verificationId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
        final res = await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();
        if (res.exists) {
          final userData = res.data();
          // To handle the old accounts, since they don't have email and uid in users collection
          if (userData![AppConstants.globalInvoiceNumber] == null) {
            await _firestore
                .collection('users')
                .doc(userCredential.user!.uid)
                .update({
              //FIXME: Before pushing to production, check if this is correct
              AppConstants.email: userCredential.user!.email,
              AppConstants.uid: userCredential.user!.uid,
              AppConstants.fullName: userCredential.user!.displayName,
              AppConstants.imageUrl: userCredential.user!.photoURL,
              AppConstants.globalInvoiceNumber: 0,
            });
          }
        } else {
          // To handle new accounts
          await UserRepo().createUser(userCredential.user!.uid);
        }
        emit(LoggedInState(userCredential.user!));
      } else {
        emit(AuthErrorState(
            errorMessage: "Sign in with Google failed, Try Again Later!"));
      }
    } on FirebaseException catch (err) {
      // emit(AuthErrorState(errorMessage: err.message.toString()));
      firebaseAuthErrorHandling(err, emit);
    } catch (err) {
      emit(AuthErrorState(
          errorMessage:
              'An unknown error occurred. Please try again after some time.'));
      // emit(AuthErrorState(errorMessage: err.toString()));
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
        final res = await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();
        final userData = res.data();
        if (userData![AppConstants.globalInvoiceNumber] == null) {
          await _firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .update({
            AppConstants.email: userCredential.user!.email,
            AppConstants.uid: userCredential.user!.uid,
            AppConstants.fullName: userCredential.user!.displayName,
            AppConstants.imageUrl: userCredential.user!.photoURL,
            AppConstants.globalInvoiceNumber: 0,
          });
        }
        emit(LoggedInState(userCredential.user!));
      } else {
        emit(AuthErrorState(errorMessage: "User not found"));
      }
    } on FirebaseException catch (err) {
      // print(err.code);
      firebaseAuthErrorHandling(err, emit);
    } catch (e) {
      emit(AuthErrorState(
          errorMessage:
              'An unknown error occurred. Please try again after some time.'));
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
        // await _firestore.collection('users').doc(userCredential.user!.uid).set({
        //   'email': userCredential.user!.email,
        //   'uid': userCredential.user!.uid,
        //   'userName': userCredential.user!.displayName,
        //   'photoUrl': userCredential.user!.photoURL,
        // });

        await UserRepo().createUser(userCredential.user!.uid);
        emit(SignUpWithEmailSuccessState(userCredential.user!));
      } else {
        emit(AuthErrorState(errorMessage: "User not created"));
      }
    } on FirebaseException catch (err) {
      // emit(AuthErrorState(errorMessage: err.message.toString()));
      firebaseAuthErrorHandling(err, emit);
    } catch (e) {
      emit(AuthErrorState(
          errorMessage:
              'An unknown error occurred. Please try again after some time.'));
    }
  }

  void _onLogoutEvent(event, emit) async {
    InvoiceRepo invoiceRepo = InvoiceRepo();
    UserRepo userRepo = UserRepo();
    TransactionRepo transactionRepo = TransactionRepo();

    emit(AuthLoadingState());
    try {
      await invoiceRepo.uploadLocalInvoicesToFirebase();
      await userRepo.uploadUserToFirebase();
      await transactionRepo.uploadLocalTransactionsToFirebase();

      for (UserInfo provider in _auth.currentUser!.providerData) {
        if (provider.providerId == 'google.com') {
          // It is a good practice to check before signout but if called directly won't give any error
          _googleSignIn.signOut();
          break;
        }
      }
      await _auth.signOut();

      await userRepo.deleteUserFromLocal();
      await invoiceRepo.deleteAllInvoiceFromLocal();
      await transactionRepo.deleteAllTransactionsFromLocal();

      emit(LoggedOutState());
    } catch (err) {
      emit(AuthErrorState(errorMessage: err.toString()));
    }
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

  void firebaseAuthErrorHandling(err, emit) {
    switch (err.code) {
      case 'invalid-email':
        emit(AuthErrorState(errorMessage: 'The email address is not valid.'));
        break;
      case 'user-disabled':
        emit(AuthErrorState(errorMessage: 'This user has been disabled.'));
        break;
      case 'user-not-found':
        emit(AuthErrorState(errorMessage: 'Account not found. Sign up first.'));
        break;
      case 'wrong-password':
        emit(AuthErrorState(errorMessage: 'Wrong password provided.'));
        break;
      case 'email-already-in-use':
        emit(AuthErrorState(
            errorMessage: 'The email address is already in use.'));
        break;
      case 'weak-password':
        emit(AuthErrorState(errorMessage: 'The password is too weak.'));
        break;
      case 'too-many-requests':
        emit(AuthErrorState(
            errorMessage: 'Too many requests. Please try again later.'));
        break;
      // Google Sign-In specific errors
      case 'account-exists-with-different-credential':
        emit(AuthErrorState(
            errorMessage:
                'An account already exists with a different sign-in method.'));
        break;
      case 'invalid-credential':
        emit(AuthErrorState(
            errorMessage: 'The sign-in credentials are invalid.'));
        break;
      case 'popup-closed-by-user':
        emit(AuthErrorState(errorMessage: 'The sign-in window was closed.'));
        break;
      case 'popup-blocked':
        emit(AuthErrorState(
            errorMessage: 'Popup blocked. Please allow popups.'));
        break;
      // Avoid showing these codes to users
      case 'internal-error':
      case 'operation-not-supported-in-this-environment':
      case 'app-not-authorized':
      case 'invalid-action-code':
      case 'expired-action-code':
      case 'credential-already-in-use':
        emit(AuthErrorState(
            errorMessage: 'An error occurred. Please try again later.'));
        break;

      default:
        emit(AuthErrorState(
            errorMessage:
                'An unknown error occurred. Please try again later.'));
    }
  }

  // void sendOtp(String phoneNumber) async {}
  // void verifyOtp(String otp) {}
  // void signInWithPhone(PhoneAuthCredential credential) async {}
}
