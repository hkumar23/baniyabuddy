class BillItem {
  final String itemName;
  final int quantity;
  final double unitPrice;
  double? tax;
  double? discount;
  final double totalPrice;

  BillItem({
    required this.itemName,
    required this.quantity,
    required this.unitPrice,
    this.tax,
    this.discount,
    required this.totalPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      'itemName': itemName,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'tax': tax,
      'discount': discount,
      'totalPrice': totalPrice,
    };
  }
}
