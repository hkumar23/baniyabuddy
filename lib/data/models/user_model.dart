import 'package:hive_flutter/hive_flutter.dart';

import '../../constants/app_constants.dart';
import '../../utils/hive_adapter_typeids.dart';
import '../../utils/hive_adapter_names.dart';
import 'business.model.dart';

part 'user_model.g.dart';

@HiveType(
  typeId: HiveAdapterTypeids.user,
  adapterName: HiveAdapterNames.user,
)
class UserModel {
  @HiveField(0)
  final String uid;
  @HiveField(1)
  final String email;
  @HiveField(2)
  String? fullName;
  @HiveField(3)
  String? imageUrl;

  @HiveField(4)
  String? upiId;

  @HiveField(5)
  int globalInvoiceNumber;

  @HiveField(6)
  Business? business;

  UserModel({
    required this.uid,
    required this.email,
    required this.fullName,
    this.imageUrl,
    this.upiId,
    this.globalInvoiceNumber = 0,
    this.business,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json[AppConstants.uid],
      email: json[AppConstants.email],
      fullName: json[AppConstants.fullName],
      imageUrl: json[AppConstants.imageUrl],
      upiId: json['upiId'],
      globalInvoiceNumber: json['globalInvoiceNumber'],
      business: json['business'] ?? Business.fromJson(json['business']),
    );
  }
  Map<String, Object?> toJson() {
    return {
      AppConstants.uid: uid,
      AppConstants.email: email,
      AppConstants.fullName: fullName,
      AppConstants.imageUrl: imageUrl,
      AppConstants.upiId: upiId,
      AppConstants.globalInvoiceNumber: globalInvoiceNumber,
      AppConstants.business: business?.toJson(),
    };
  }
}
