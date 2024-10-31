import 'package:hive/hive.dart';

import '../../utils/hive_adapter_typeids.dart';
import '../../utils/hive_adapter_names.dart';

part 'bill_item.model.g.dart';

@HiveType(
  typeId: HiveAdapterTypeids.billItem,
  adapterName: HiveAdapterNames.billItem,
)
class BillItem {
  @HiveField(0)
  final String itemName;
  @HiveField(1)
  final int quantity;
  @HiveField(2)
  final double unitPrice;
  @HiveField(3)
  double? tax;
  @HiveField(4)
  double? discount;
  @HiveField(5)
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
