import 'package:hive/hive.dart';

import '../../constants/app_constants.dart';
import '../../utils/hive_adapter_typeids.dart';
import '../../utils/hive_adapter_names.dart';

part 'bill_item.model.g.dart';

@HiveType(
  typeId: HiveAdapterTypeids.billItem,
  adapterName: HiveAdapterNames.billItem,
)
class BillItem {
  @HiveField(0)
  final String? itemName;
  @HiveField(1)
  final int? quantity;
  @HiveField(2)
  final double? unitPrice;
  @HiveField(3)
  double? tax;
  @HiveField(4)
  double? discount;
  @HiveField(5)
  final double? totalPrice;

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
      AppConstants.itemName: itemName,
      AppConstants.quantity: quantity,
      AppConstants.unitPrice: unitPrice,
      AppConstants.tax: tax,
      AppConstants.discount: discount,
      AppConstants.totalPrice: totalPrice,
    };
  }

  factory BillItem.fromJson(Map<String, dynamic> json) {
    return BillItem(
      itemName: json[AppConstants.itemName] as String,
      quantity: json[AppConstants.quantity] as int,
      unitPrice: double.parse(json[AppConstants.unitPrice].toString()),
      totalPrice: json[AppConstants.totalPrice] as double,
      discount: json[AppConstants.discount] == null
          ? 0
          : double.parse(json[AppConstants.discount].toString()),
      tax: json[AppConstants.tax] == null
          ? 0
          : double.parse(json[AppConstants.tax].toString()),
    );
  }
}
