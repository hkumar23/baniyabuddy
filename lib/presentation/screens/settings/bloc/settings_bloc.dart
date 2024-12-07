import 'package:baniyabuddy/constants/app_constants.dart';
import 'package:baniyabuddy/data/models/business.model.dart';
import 'package:baniyabuddy/data/repositories/invoice_repo.dart';
import 'package:baniyabuddy/data/repositories/user_repo.dart';
import 'package:baniyabuddy/utils/app_methods.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'settings_event.dart';
import 'settings_state.dart';
import '../../../../data/repositories/business_repo.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(InitialSettingsState()) {
    on<SaveBusinessInfoEvent>(_onSaveBusinessInfoEvent);
    on<FetchBusinessInfoFromFirebaseEvent>(
        _onFetchBusinessInfoFromFirebaseEvent);
    on<SyncDataWithFirebaseEvent>(_onSyncDataWithFirebaseEvent);
    on<SaveUpiIdEvent>(_onSaveUpiIdEvent);
  }
  void _onSyncDataWithFirebaseEvent(event, emit) async {
    emit(SyncDataLoadingState());
    final invoiceRepo = InvoiceRepo();
    final businessRepo = BusinessRepo();
    final userRepo = UserRepo();

    try {
      bool isConnected = await AppMethods.checkInternetConnection();
      if (!isConnected) {
        throw "You are not connected to the Internet";
      }
      await businessRepo.uploadBusinessInfoToFirebase();
      await businessRepo.fetchBusinessInfoFromFirebase();

      await userRepo.uploadUserToFirebase();
      await userRepo.fetchUserFromFirebase();

      await invoiceRepo.uploadLocalInvoicesToFirebase();
      await invoiceRepo.fetchInvoicesFromFirebaseToLocal();
      emit(DataSyncedWithFirebaseState());
    } catch (err) {
      emit(SettingsErrorState(errorMessage: err.toString()));
    }
  }

  void _onFetchBusinessInfoFromFirebaseEvent(event, emit) async {
    emit(SettingsLoadingState);
    try {
      if (!Hive.isBoxOpen(AppConstants.businessBox)) {
        await Hive.openBox<Business>(AppConstants.businessBox);
      }
      await BusinessRepo().fetchBusinessInfoFromFirebase();
      emit(BusinessInfoFetchedState());
    } catch (err) {
      debugPrint(err.toString());
      emit(
        SettingsErrorState(
          errorMessage: "Error in fetching business info from firebase..!",
        ),
      );
    }
  }

  void _onSaveBusinessInfoEvent(event, emit) async {
    // print(event.business.toJson());
    emit(SettingsLoadingState());
    try {
      final businessRepo = BusinessRepo();
      await businessRepo.saveBusinessInfo(event.business);
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
