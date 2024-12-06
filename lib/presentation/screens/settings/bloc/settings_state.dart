abstract class SettingsState {}

class InitialSettingsState extends SettingsState {}

class SettingsLoadingState extends SettingsState {}

class SyncDataLoadingState extends SettingsState {}

class SettingsErrorState extends SettingsState {
  SettingsErrorState({required this.errorMessage});
  final String errorMessage;
}

class BusinessInfoSavedState extends SettingsState {}

class BusinessInfoFetchedState extends SettingsState {}

class DataSyncedWithFirebaseState extends SettingsState {}

class UpiIdSavedState extends SettingsState {}
