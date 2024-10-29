import '../../constants/app_constants.dart';
import 'bill_item.model.dart';

class InvoiceDetails {
  String? firebaseDocId;
  // Invoice Details
  int? invoiceNumber;
  final DateTime? invoiceDate;
  final String? paymentMethod;
  // Client Details
  final String clientName;
  final String? clientAddress;
  final String? clientEmail;
  final String? clientPhone;
  // Summary Details
  double? subtotal;
  double? extraDiscount;
  double? totalDiscount;
  double? totalTaxAmount;
  double? grandTotal;
  final double? shippingCharges;

  final List<BillItem>? billItems;

  final String? notes;

  InvoiceDetails({
    required this.firebaseDocId,
    // Invoice Details
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.paymentMethod,
    // Client Details
    required this.clientName,
    required this.clientAddress,
    required this.clientEmail,
    required this.clientPhone,
    // Summary Details
    required this.subtotal,
    required this.extraDiscount,
    required this.totalDiscount,
    required this.totalTaxAmount,
    required this.grandTotal,
    required this.shippingCharges,
    required this.billItems,
    required this.notes,
  });

  factory InvoiceDetails.fromJson(Map json) {
    return InvoiceDetails(
      firebaseDocId: json[AppConstants.firebaseDocId],
      invoiceNumber: json[AppConstants.invoiceNumber],
      invoiceDate: json[AppConstants.invoiceDate],
      paymentMethod: json[AppConstants.paymentMethod],
      clientName: json[AppConstants.clientName],
      clientAddress: json[AppConstants.clientAddress],
      clientEmail: json[AppConstants.clientEmail],
      clientPhone: json[AppConstants.clientPhone],
      subtotal: json[AppConstants.subtotal],
      extraDiscount: json[AppConstants.extraDiscount],
      totalDiscount: json[AppConstants.totalDiscount],
      totalTaxAmount: json[AppConstants.totalTaxAmount],
      grandTotal: json[AppConstants.grandTotal],
      shippingCharges: json[AppConstants.shippingCharges],
      billItems: json[AppConstants.billItems],
      notes: json[AppConstants.notes],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppConstants.firebaseDocId: firebaseDocId,
      AppConstants.invoiceNumber: invoiceNumber,
      AppConstants.invoiceDate: invoiceDate,
      AppConstants.paymentMethod: paymentMethod,
      AppConstants.clientName: clientName,
      AppConstants.clientAddress: clientAddress,
      AppConstants.clientEmail: clientEmail,
      AppConstants.clientPhone: clientPhone,
      AppConstants.subtotal: subtotal,
      AppConstants.extraDiscount: extraDiscount,
      AppConstants.totalDiscount: totalDiscount,
      AppConstants.totalTaxAmount: totalTaxAmount,
      AppConstants.grandTotal: grandTotal,
      AppConstants.shippingCharges: shippingCharges,
      AppConstants.billItems: billItems?.map((item) => item.toJson()).toList(),
      AppConstants.notes: notes,
    };
  }
}
