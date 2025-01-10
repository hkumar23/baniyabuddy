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

class UserFetchedState extends SettingsState {}

class ImageUploadedState extends SettingsState {
  final String imageUrl;
  ImageUploadedState({required this.imageUrl});
}

class NameAndImageUpdatedState extends SettingsState {}
// class QrGeneratedState extends SettingsState {
//   final String amount;
//   final String businessName;
//   final String upiId;
//   QrGeneratedState({
//     required this.amount,
//     required this.businessName,
//     required this.upiId,
//   });
// }
