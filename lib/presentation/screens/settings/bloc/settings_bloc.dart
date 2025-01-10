import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/models/user_model.dart';
import '../../../../constants/app_constants.dart';
import '../../../../data/repositories/invoice_repo.dart';
import '../../../../data/repositories/user_repo.dart';
import '../../../../utils/app_methods.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(InitialSettingsState()) {
    on<SaveBusinessInfoEvent>(_onSaveBusinessInfoEvent);
    // on<FetchBusinessInfoFromFirebaseEvent>(
    //     _onFetchBusinessInfoFromFirebaseEvent);
    on<SyncDataWithFirebaseEvent>(_onSyncDataWithFirebaseEvent);
    on<SaveUpiIdEvent>(_onSaveUpiIdEvent);
    on<FetchUserFromFirebaseEvent>(_onFetchUserFromFirebaseEvent);
    on<UploadImageEvent>(_onUploadImageEvent);
    on<UpdateNameAndImageEvent>(_onUpdateNameAndImageEvent);
  }

  void _onUpdateNameAndImageEvent(event, emit) async {
    emit(SettingsLoadingState());
    try {
      if (event.fullName == null || event.fullName!.isEmpty) {
        throw "Name cannot be empty";
      }
      if (event.imageUrl == null || event.imageUrl!.isEmpty) {
        throw "Please upload an image";
      }
      if (!await AppMethods.checkInternetConnection()) {
        throw "You are not connected to the Internet";
      }

      final userRepo = UserRepo();
      String? oldImageUrl = userRepo.getUser()!.imageUrl;
      String? imagePath;
      if (oldImageUrl != null && oldImageUrl.contains("googleusercontent")) {
        imagePath =
            Uri.decodeFull(event.oldImageUrl.split('/o/')[1].split('?')[0]);
      }
      if (imagePath != null) {
        await FirebaseStorage.instance.ref(imagePath).delete();
      }
      await userRepo.updateNameAndImage(event.fullName, event.imageUrl);
      emit(NameAndImageUpdatedState());
    } catch (err) {
      emit(SettingsErrorState(errorMessage: err.toString()));
    }
  }

  void _onUploadImageEvent(event, emit) async {
    emit(SettingsLoadingState());
    try {
      // print("Uploading image");
      final pickedImageXFile = await AppMethods.pickImage(ImageSource.gallery);
      if (pickedImageXFile == null) throw "No image selected";
      // print("Image picked");
      final croppedFile = await AppMethods.cropImage(pickedImageXFile.path);
      if (croppedFile == null) throw "Image cropping failed";
      // print("Image cropped");
      bool isConnected = await AppMethods.checkInternetConnection();
      if (!isConnected) throw "You are not connected to the Internet";

      String fileName = FirebaseAuth.instance.currentUser!.uid +
          DateTime.now().millisecondsSinceEpoch.toString();

      final storageRef =
          FirebaseStorage.instance.ref().child('profile_images/$fileName');
      final UploadTask uploadTask = storageRef.putFile(croppedFile);
      final TaskSnapshot taskSnapshot =
          await uploadTask.whenComplete(() => null);
      final imageUrl = await taskSnapshot.ref.getDownloadURL();

      emit(ImageUploadedState(imageUrl: imageUrl));
    } catch (err) {
      // print(err);
      emit(SettingsErrorState(errorMessage: err.toString()));
    }
  }

  void _onSyncDataWithFirebaseEvent(event, emit) async {
    emit(SyncDataLoadingState());
    final invoiceRepo = InvoiceRepo();
    // final businessRepo = BusinessRepo();
    final userRepo = UserRepo();

    try {
      bool isConnected = await AppMethods.checkInternetConnection();
      if (!isConnected) {
        throw "You are not connected to the Internet";
      }
      // await businessRepo.uploadBusinessInfoToFirebase();
      // await businessRepo.fetchBusinessInfoFromFirebase();
      await userRepo.uploadUserToFirebase();
      await userRepo.fetchUserFromFirebase();

      await invoiceRepo.uploadLocalInvoicesToFirebase();
      await invoiceRepo.fetchInvoicesFromFirebaseToLocal();
      // print("Syncing data with firebase");
      emit(DataSyncedWithFirebaseState());
    } catch (err) {
      emit(SettingsErrorState(errorMessage: err.toString()));
    }
  }

  // void _onFetchBusinessInfoFromFirebaseEvent(event, emit) async {
  //   // emit(SettingsLoadingState);
  //   try {
  //     if (!Hive.isBoxOpen(AppConstants.businessBox)) {
  //       await Hive.openBox<Business>(AppConstants.businessBox);
  //     }
  //     await BusinessRepo().fetchBusinessInfoFromFirebase();
  //     emit(BusinessInfoFetchedState());
  //   } catch (err) {
  //     debugPrint(err.toString());
  //     emit(
  //       SettingsErrorState(
  //         errorMessage: "Error in fetching business info from firebase..!",
  //       ),
  //     );
  //   }
  // }

  void _onFetchUserFromFirebaseEvent(event, emit) async {
    //FIXME: Check if this is needed
    // emit(SettingsLoadingState());
    try {
      if (!Hive.isBoxOpen(AppConstants.userBox)) {
        await Hive.openBox<UserModel>(AppConstants.userBox);
      }
      await UserRepo().fetchUserFromFirebase();
      emit(UserFetchedState());
    } catch (err) {
      debugPrint(err.toString());
      emit(SettingsErrorState(
        errorMessage: "Error in fetching user info from firebase..!",
      ));
    }
  }

  void _onSaveBusinessInfoEvent(event, emit) async {
    // print(event.business.toJson());
    emit(SettingsLoadingState());
    try {
      final UserRepo userRepo = UserRepo();
      await userRepo.updateBusinessInfo(event.business);
      // await businessRepo.saveBusinessInfo(event.business);
      // print("Details saved");
      emit(BusinessInfoSavedState());
    } catch (err) {
      debugPrint(err.toString());
      emit(SettingsErrorState(
        errorMessage: err.toString() == AppConstants.savedLocally
            ? AppConstants.savedLocally
            : "Something went wrong while saving Business details ..!",
      ));
    }
  }

  _onSaveUpiIdEvent(event, emit) async {
    emit(SettingsLoadingState());
    try {
      await UserRepo().saveUpiId(event.upiId);
      emit(UpiIdSavedState());
    } catch (err) {
      debugPrint(err.toString());
      emit(SettingsErrorState(
        errorMessage: err.toString() == AppConstants.savedLocally
            ? AppConstants.savedLocally
            : "Something went wrong while saving UPI ID ..!",
      ));
    }
  }
}
