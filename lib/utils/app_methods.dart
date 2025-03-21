import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

// import '../constants/app_constants.dart';
import '../constants/app_language.dart';
import '../data/models/transaction.model.dart';
import '../logic/Blocs/Authentication/bloc/auth_bloc.dart';
import '../logic/Blocs/Authentication/bloc/auth_event.dart';
import '../presentation/screens/billing/bloc/billing_bloc.dart';
import '../presentation/screens/billing/bloc/billing_event.dart';
import '../presentation/screens/sales_history/bloc/sales_history_bloc.dart';
import '../presentation/screens/sales_history/bloc/sales_history_event.dart';
import '../presentation/screens/settings/bloc/settings_bloc.dart';
import '../presentation/screens/settings/bloc/settings_event.dart';

class AppMethods {
  static Future<bool> requestStoragePermission() async {
    if (Platform.isAndroid) {
      var status = await Permission.storage.request();
      return status.isGranted;
    }
    return true;
  }

  static Future<bool> isAndroid10OrAbove() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      return androidInfo.version.sdkInt >= 29;
    }
    return false;
  }

  static void resetAppData(BuildContext context) {
    // print("Resetting App Data");
    context.read<BillingBloc>().add(FetchInvoiceFromFirebaseToLocalEvent());
    context.read<SalesHistoryBloc>().add(FetchTransactionsFromFirebaseEvent());
    context.read<SettingsBloc>().add(FetchUserFromFirebaseEvent());
    // context.read<SalesHistoryBloc>().add(FetchSalesHistoryEvent());
  }

  static Future<XFile?> pickImage(ImageSource source) async {
    try {
      ImagePicker picker = ImagePicker();
      final XFile? pickedXFile = await picker.pickImage(
        source: source,
      );
      return pickedXFile;
    } catch (e) {
      rethrow;
    }
  }

  static Future<File?> cropImage(String path) async {
    try {
      final croppedFile = await ImageCropper().cropImage(
          sourcePath: path,
          aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
          // uiSettings: [
          //   AndroidUiSettings(
          //     toolbarTitle: 'Crop Image',
          //     toolbarColor: Colors.blue,
          //     toolbarWidgetColor:
          //     initAspectRatio: CropAspectRatioPreset.square,
          //     hideBottomControls: true,
          //     aspectRatioPresets: [CropAspectRatioPreset.square],
          //   )
          // ],
          compressFormat: ImageCompressFormat.jpg,
          compressQuality: 60,
          aspectRatioPresets: [CropAspectRatioPreset.square]);
      if (croppedFile == null) return null;
      return File(croppedFile.path);
      // return null;
    } catch (e) {
      rethrow;
    }
  }

  static bool isOperator(String value) {
    return ['+', '-', '*', '/', '%', 'a', '=', 'd'].contains(value);
  }

  static String removeLastChar(String value) {
    if (value.length <= 1) return "";
    return value.substring(0, value.length - 1);
  }

  static String calculateResult(String infixExpression) {
    if (infixExpression.isEmpty) return "";
    try {
      // Create a parser
      Parser p = Parser();

      // Parse the expression
      Expression exp = p.parse(infixExpression);

      // Create a context
      ContextModel cm = ContextModel();

      // Evaluate the expression
      double result = exp.evaluate(EvaluationType.REAL, cm);

      return result.toString();
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("Invalid Expression");
    }
  }

  static bool isNumeric(String s) {
    return RegExp(r'^[0-9]+$').hasMatch(s);
  }

  static void logoutWithDialog(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (BuildContext context) {
        return AlertDialog(
          shadowColor: Theme.of(context).colorScheme.shadow,
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: const Text("Are you sure you want to logout?"),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<AuthBloc>().add(LogoutEvent());
              },
              child: const Text(AppLanguage.yes),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(AppLanguage.no),
            )
          ],
        );
      },
    );
  }

  static String calcTransactionTotal(
      List<TransactionDetails> transactionsList) {
    double total = 0.0;
    for (int i = 0; i < transactionsList.length; i++) {
      String? currAmount = transactionsList[i].totalAmount == ""
          ? "0.0"
          : transactionsList[i].totalAmount;
      total += double.parse(currAmount ?? "0.0");
    }
    return total.toStringAsFixed(1);
    // return "Testing";
  }

  static Future<bool> doesImagePathExist(String imagePath) async {
    try {
      final ref = FirebaseStorage.instance.ref(imagePath);

      await ref.getMetadata();
      return true;
    } catch (e) {
      if (e is FirebaseException && e.code == 'object-not-found') {
        return false;
      }
      rethrow;
    }
  }
  // static Future<void> modifyingAllUserData() async {
  //   try {
  //     // print("running");
  //     final FirebaseFirestore firestore = FirebaseFirestore.instance;
  //     final response = await firestore.collection("users").get();
  //     // print(response.docs.length);
  //     for (var user in response.docs) {
  //       // print("Yes");
  //       final newResponse = await firestore
  //           .collection("users")
  //           .doc(user.id)
  //           .collection("transactions")
  //           .get();
  //       for (var transaction in newResponse.docs) {
  //         if (transaction.data().isEmpty) continue;
  //         final data = transaction.data();
  //         final transactionRef = transaction.reference;
  //         if (data[AppConstants.customerName] == "Unknown") {
  //           await transactionRef.update({
  //             AppConstants.customerName: "",
  //           });
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  static Future<void> logUserActivity() async {
    final userActivity = FirebaseFirestore.instance.collection("user_activity");
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser == null) return;
    try {
      final userId = auth.currentUser!.uid;
      await userActivity.doc(userId).set({
        "email": auth.currentUser!.email,
        "created_at": Timestamp.now(),
      });
    } catch (e) {
      debugPrint("Saving Log Error: $e");
    }
  }

  static Future<bool> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.ethernet) {
      return true;
    }
    return false;
  }

  static bool isNegative(String value) {
    double number = double.tryParse(value) ?? 0;
    if (number < 0) return true;
    return false;
  }

  static void shouldPopDialog(BuildContext context) async {
    bool shouldPop = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Data will be lost, if you leave !!",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text(AppLanguage.cancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text(AppLanguage.exit),
            ),
          ],
        );
      },
    );
    if (shouldPop == true) {
      Navigator.of(context).pop();
    }
  }

  // static DateTime getPreviousDate(int n, String timePeriod) {
  //   LocalDate today = LocalDate.today();
  //   LocalDate targetDate = today;
  //   if (timePeriod == AppConstants.days) {
  //     targetDate = today.subtract(Period(days: n));
  //   } else if (AppConstants.weeks == timePeriod) {
  //     targetDate = today.subtract(Period(weeks: n));
  //   } else {
  //     targetDate = today.subtract(Period(months: n));
  //   }
  //   print(
  //       "${targetDate.year} ${targetDate.monthOfYear} ${targetDate.dayOfMonth}");
  //   return DateTime(
  //     targetDate.year,
  //     targetDate.monthOfYear,
  //     targetDate.dayOfMonth,
  //   );
  // }
}
