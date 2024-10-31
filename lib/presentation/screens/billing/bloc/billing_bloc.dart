import 'package:baniyabuddy/data/models/bill_item.model.dart';
import 'package:baniyabuddy/data/models/invoice.model.dart';
import 'package:bloc/bloc.dart';

import 'billing_state.dart';
import 'billing_event.dart';

class BillingBloc extends Bloc<BillingEvent, BillingState> {
  BillingBloc() : super(InitialBillingState()) {
    // print("Entered Bloc");
    on<GenerateInvoiceEvent>(_onGenerateInvoiceEvent);
  }

  void _onGenerateInvoiceEvent(
      GenerateInvoiceEvent event, Emitter<BillingState> emit) {
    Invoice invoice = event.invoice;
    // print(invoice.toJson());
    if (invoice.billItems == null || invoice.billItems!.isEmpty) {
      emit(BillingErrorState(errorMessage: "You should add atleast 1 item"));
      return;
    }

    double subTotal = calcSubtotal(invoice.billItems!);
    invoice.subtotal =
        double.parse(subTotal.toStringAsFixed(2)); //Updating Invoice Object

    List<double> totalTaxAndDiscount = calcTotalTaxAndDiscount(invoice);
    invoice.totalTaxAmount =
        double.parse(totalTaxAndDiscount[0].toStringAsFixed(2));
    invoice.totalDiscount =
        double.parse(totalTaxAndDiscount[1].toStringAsFixed(2));

    double grandTotal = subTotal;
    grandTotal -= invoice.totalDiscount!;
    grandTotal += invoice.totalTaxAmount!;
    grandTotal += invoice.shippingCharges ?? 0;
    invoice.grandTotal =
        double.parse(grandTotal.toStringAsFixed(2)); //Updating Invoice Object
    print(invoice.toJson());
  }

  double calcSubtotal(List<BillItem> billItems) {
    double subTotal = 0;
    for (int i = 0; i < billItems.length; ++i) {
      subTotal += billItems[i].quantity * billItems[i].unitPrice;
    }
    return subTotal;
  }

  List<double> calcTotalTaxAndDiscount(Invoice invoice) {
    final billItems = invoice.billItems!;
    double totalTaxAmount = 0;
    double totalDiscount = 0;

    for (int i = 0; i < billItems.length; ++i) {
      double currDiscount = 0;
      double currPrice = billItems[i].quantity * billItems[i].unitPrice;
      if (billItems[i].discount != null) {
        currDiscount = (currPrice * billItems[i].discount!) / 100;
      }
      totalDiscount += currDiscount;

      double currTaxAmount = 0;
      if (billItems[i].tax != null) {
        currTaxAmount = ((currPrice - currDiscount) * billItems[i].tax!) / 100;
      }
      totalTaxAmount += currTaxAmount;
    }
    totalDiscount += invoice.extraDiscount ?? 0;
    return [totalTaxAmount, totalDiscount];
  }
}
