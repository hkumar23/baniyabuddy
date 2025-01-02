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

// class GenerateQrEvent extends SettingsEvent {
//   final String amount;
//   GenerateQrEvent({required this.amount});
// }
