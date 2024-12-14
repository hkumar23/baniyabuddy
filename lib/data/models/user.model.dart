import 'package:hive_flutter/hive_flutter.dart';

import '../../constants/app_constants.dart';
import '../../utils/hive_adapter_typeids.dart';
import '../../utils/hive_adapter_names.dart';

@HiveType(
  typeId: HiveAdapterTypeids.user,
  adapterName: HiveAdapterNames.user,
)
class User {
  @HiveField(0)
  final String uid;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String userName;
  @HiveField(3)
  final String? photoUrl;
  // final String? upiId;
  // final int globalInvoiceNumber;
  User({
    required this.uid,
    required this.email,
    required this.userName,
    this.photoUrl,
    // this.upiId,
    // this.globalInvoiceNumber = 0,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json[AppConstants.uid],
      email: json[AppConstants.email],
      userName: json[AppConstants.userName],
      photoUrl: json[AppConstants.photoUrl],
      // upiId: json['upiId'],
      // globalInvoiceNumber: json['globalInvoiceNumber'],
    );
  }
  Map<String, Object?> toJson(User user) {
    return {
      AppConstants.uid: user.uid,
      AppConstants.email: user.email,
      AppConstants.userName: user.userName,
      AppConstants.photoUrl: user.photoUrl,
      // 'upiId': user.upiId,
      // 'globalInvoiceNumber': user.globalInvoiceNumber,
    };
  }
}
