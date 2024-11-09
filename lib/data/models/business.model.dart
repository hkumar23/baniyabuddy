import '../../constants/app_constants.dart';

class Business {
  String? name;
  String? address;
  String? email;
  String? phone;
  String? gstin;

  Business({
    this.name = "Shop Owner",
    this.address = "ABC, 123, State,pincode, Country",
    this.email = "customer@test.com",
    this.phone = "9999999999",
    this.gstin = "22AAAAA0000A1Z5",
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

  factory Business.fromJson(Map json) {
    return Business(
      name: json[AppConstants.name],
      address: json[AppConstants.address],
      email: json[AppConstants.email],
      phone: json[AppConstants.phone],
      gstin: json[AppConstants.gstin],
    );
  }
}
