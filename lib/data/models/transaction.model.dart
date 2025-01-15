import 'package:hive_flutter/hive_flutter.dart';

import '../../constants/app_constants.dart';
import '../../utils/hive_adapter_names.dart';
import '../../utils/hive_adapter_typeids.dart';

part 'transaction.model.g.dart';

@HiveType(
  typeId: HiveAdapterTypeids.transaction,
  adapterName: HiveAdapterNames.transaction,
)
class TransactionDetails {
  @HiveField(0)
  final String docId;
  @HiveField(1)
  final String customerName;
  @HiveField(2)
  final String mobNumber;
  @HiveField(3)
  final String notes;
  @HiveField(4)
  final String paymentMethod;
  @HiveField(5)
  final DateTime timeStamp;
  @HiveField(6)
  final String? totalAmount;
  @HiveField(7)
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
