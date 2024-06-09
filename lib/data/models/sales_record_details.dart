import 'package:baniyabuddy/constants/app_constants.dart';

class SalesRecordDetails {
  final String costumerName;
  final String mobNumber;
  final String notes;
  final String paymentMethod;
  final DateTime timeStamp;
  final String? totalAmount;
  final String? inputExpression;
  SalesRecordDetails({
    required this.costumerName,
    required this.mobNumber,
    required this.notes,
    required this.paymentMethod,
    required this.timeStamp,
    this.totalAmount,
    this.inputExpression,
  });

  factory SalesRecordDetails.fromJson(Map json) {
    return SalesRecordDetails(
      costumerName: json[AppConstants.costumerName],
      mobNumber: json[AppConstants.mobNumber],
      notes: json[AppConstants.notes],
      paymentMethod: json[AppConstants.paymentMethod],
      timeStamp: json[AppConstants.timeStamp],
      totalAmount: json[AppConstants.totalAmount],
      inputExpression: json[AppConstants.inputExpression],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppConstants.costumerName: costumerName,
      AppConstants.mobNumber: mobNumber,
      AppConstants.notes: notes,
      AppConstants.paymentMethod: paymentMethod,
      AppConstants.timeStamp: timeStamp,
      AppConstants.totalAmount: totalAmount,
      AppConstants.inputExpression: inputExpression,
    };
  }
}
