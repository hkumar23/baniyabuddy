import 'package:baniyabuddy/data/models/business.model.dart';

abstract class SettingsEvent {}

class SaveBusinessInfoEvent extends SettingsEvent {
  final Business business;
  SaveBusinessInfoEvent({required this.business});
}

class FetchBusinessInfoFromFirebaseEvent extends SettingsEvent {}

class SaveUpiIdEvent extends SettingsEvent {}
