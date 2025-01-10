import 'package:baniyabuddy/data/models/business.model.dart';

abstract class SettingsEvent {}

class SaveBusinessInfoEvent extends SettingsEvent {
  final Business business;
  SaveBusinessInfoEvent({required this.business});
}

// class FetchBusinessInfoFromFirebaseEvent extends SettingsEvent {}

class SaveUpiIdEvent extends SettingsEvent {
  final String upiId;
  SaveUpiIdEvent({required this.upiId});
}

class SyncDataWithFirebaseEvent extends SettingsEvent {}

class FetchUserFromFirebaseEvent extends SettingsEvent {}

class UploadImageEvent extends SettingsEvent {}

class UpdateNameAndImageEvent extends SettingsEvent {
  final String? fullName;
  final String? imageUrl;
  UpdateNameAndImageEvent({required this.fullName, required this.imageUrl});
}
// class GenerateQrEvent extends SettingsEvent {
//   final String amount;
//   GenerateQrEvent({required this.amount});
// }
