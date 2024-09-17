import 'package:baniyabuddy/constants/app_constants.dart';

class TransactionDetails {
  final String docId;
  final String customerName;
  final String mobNumber;
  final String notes;
  final String paymentMethod;
  final DateTime timeStamp;
  final String? totalAmount;
  final String? inputExpression;
  TransactionDetails({
    required this.docId,
    required this.customerName,
    required this.mobNumber,
    required this.notes,
    required this.paymentMethod,
    required this.timeStamp,
    this.totalAmount,
    this.inputExpression,
  });

  factory TransactionDetails.fromJson(Map json) {
    return TransactionDetails(
      docId: json[AppConstants.docId],
      customerName: json[AppConstants.customerName],
      mobNumber: json[AppConstants.mobNumber],
      notes: json[AppConstants.notes],
      paymentMethod: json[AppConstants.paymentMethod],
      timeStamp: DateTime.fromMicrosecondsSinceEpoch(
          json[AppConstants.timeStamp].microsecondsSinceEpoch),
      totalAmount: json[AppConstants.totalAmount],
      inputExpression: json[AppConstants.inputExpression],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppConstants.docId: docId,
      AppConstants.customerName: customerName,
      AppConstants.mobNumber: mobNumber,
      AppConstants.notes: notes,
      AppConstants.paymentMethod: paymentMethod,
      AppConstants.timeStamp: timeStamp,
      AppConstants.totalAmount: totalAmount,
      AppConstants.inputExpression: inputExpression,
    };
  }
}
