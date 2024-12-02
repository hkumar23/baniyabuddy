import 'package:baniyabuddy/constants/app_constants.dart';
import 'package:baniyabuddy/data/models/business.model.dart';
import 'package:bloc/bloc.dart';
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

  void _onSaveBusinessInfoEvent(
      SaveBusinessInfoEvent event, Emitter<SettingsState> emit) async {
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
        errorMessage: "Something went wrong while saving Business details ..!",
      ));
    }
  }
}
