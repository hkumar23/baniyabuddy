import 'package:baniyabuddy/constants/app_constants.dart';
import 'package:baniyabuddy/data/models/bill_item.model.dart';

class InvoiceDetails {
  final String firebaseDocId;
  // Invoice Details
  final String invoiceNumber;
  final String invoiceDate;
  final String paymentMethod;
  // Client Details
  final String clientName;
  String? clientAddress;
  String? clientEmail;
  String? clientPhone;
  // Summary Details
  final String subtotal;
  String? extraDiscount;
  String? totalDiscount;
  String? totalTaxAmount;
  final String grandTotal;
  String? shippingCharges;

  final List<BillItem> billItems;

  String? notes;

  InvoiceDetails({
    required this.firebaseDocId,
    // Invoice Details
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.paymentMethod,
    // Client Details
    required this.clientName,
    this.clientAddress,
    this.clientEmail,
    this.clientPhone,
    // Summary Details
    required this.subtotal,
    this.extraDiscount,
    this.totalDiscount,
    this.totalTaxAmount,
    required this.grandTotal,
    this.shippingCharges,
    required this.billItems,
    this.notes,
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
      AppConstants.billItems: billItems.map((item) => item.toJson()).toList(),
      AppConstants.notes: notes,
    };
  }
}
