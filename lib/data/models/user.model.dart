import '../../constants/app_constants.dart';

class User {
  String? name;
  String? address;
  String? email;
  String? phone;
  String? gstin;

  User({
    this.name,
    this.address,
    this.email,
    this.phone,
    this.gstin,
  });

  Map<String, dynamic> toJson() {
    return {
      AppConstants.name: name,
      AppConstants.address: address,
      AppConstants.email: email,
      AppConstants.phone: phone,
      AppConstants.gstin: gstin,
    };
  }

  factory User.fromJson(Map json) {
    return User(
      name: json[AppConstants.name],
      address: json[AppConstants.address],
      email: json[AppConstants.email],
      phone: json[AppConstants.phone],
      gstin: json[AppConstants.gstin],
    );
  }
}
