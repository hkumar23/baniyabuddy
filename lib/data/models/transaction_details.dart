import 'package:baniyabuddy/constants/app_constants.dart';

class TransactionDetails {
  final String costumerName;
  final String mobNumber;
  final String notes;
  final String paymentMethod;

  TransactionDetails({
    required this.costumerName,
    required this.mobNumber,
    required this.notes,
    required this.paymentMethod,
  });
  factory TransactionDetails.fromJson(Map json) {
    return TransactionDetails(
      costumerName: json[AppConstants.costumerName],
      mobNumber: json[AppConstants.mobNumber],
      notes: json[AppConstants.notes],
      paymentMethod: json[AppConstants.paymentMethod],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppConstants.costumerName: costumerName,
      AppConstants.mobNumber: mobNumber,
      AppConstants.notes: notes,
      AppConstants.paymentMethod: paymentMethod,
    };
  }
}
