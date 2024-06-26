import 'package:baniyabuddy/constants/app_constants.dart';

class TransactionDetails {
  final String docId;
  final String costumerName;
  final String mobNumber;
  final String notes;
  final String paymentMethod;
  final DateTime timeStamp;
  final String? totalAmount;
  final String? inputExpression;
  TransactionDetails({
    required this.docId,
    required this.costumerName,
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
      costumerName: json[AppConstants.costumerName],
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
