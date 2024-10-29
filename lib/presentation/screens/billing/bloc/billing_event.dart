import 'package:baniyabuddy/data/models/bill_item.model.dart';

import '../../../../data/models/invoice.model.dart';

abstract class BillingEvent {}

class GenerateInvoiceEvent extends BillingEvent {
  InvoiceDetails invoiceDetails;
  GenerateInvoiceEvent({required this.invoiceDetails});
}

class UpdateInvoiceEvent extends BillingEvent {}

class AddBillItemEvent extends BillingEvent {
  BillItem billItem;
  List<BillItem> billItemList;
  AddBillItemEvent({
    required this.billItem,
    required this.billItemList,
  });
}
