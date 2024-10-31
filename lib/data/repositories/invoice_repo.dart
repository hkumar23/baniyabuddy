import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

import '../../constants/app_constants.dart';
import '../models/invoice.model.dart';

class InvoiceRepository {
  final Box<int> invoiceNumberBox = Hive.box<int>('globalInvoiceNumberBox');
  final Box<Invoice> invoiceBox = Hive.box<Invoice>('invoiceBox');
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  // Method to get the next invoice number
  Future<int> getNextInvoiceNumber() async {
    // Check if there is already an invoice number saved
    if (invoiceNumberBox.isEmpty) {
      // If not, set the starting invoice number (e.g., 1)
      await invoiceNumberBox.put(AppConstants.globalInvoiceNumber, 1);
      return 1;
    } else {
      // Fetch the current invoice number
      int currentInvoiceNumber =
          invoiceNumberBox.get(AppConstants.globalInvoiceNumber) ?? 0;
      return currentInvoiceNumber + 1;
    }
  }

  // Method to add a new invoice
  Future<void> addInvoice(Invoice invoice) async {
    // Get the next invoice number
    int nextInvoiceNumber = await getNextInvoiceNumber();
    // Update the invoice with the new number
    invoice.invoiceNumber = nextInvoiceNumber;
    // Save the new invoice
    await invoiceBox.put(invoice.docId, invoice);
    // Update the global invoice number
    await invoiceNumberBox.put(
      AppConstants.globalInvoiceNumber,
      nextInvoiceNumber,
    );
  }

  // Retrieve an invoice by ID
  Invoice? getInvoice(String id) {
    return invoiceBox.get(id);
  }

  // Retrieve all invoices
  List<Invoice> getAllInvoices() {
    return invoiceBox.values.toList();
  }

  // Delete an invoice by ID
  Future<void> deleteInvoice(String id) async {
    invoiceBox.delete(id);
  }

  // Update an invoice by id
  Future<void> updateInvoice(String id, Invoice updatedInvoice) async {
    await invoiceBox.put(id, updatedInvoice);
  }

  // Update all invoices with a custom update function
  Future<void> updateAllInvoices(List<Invoice> invoices) async {
    for (int i = 0; i < invoices.length; ++i) {
      await updateInvoice(
        invoices[i].docId!,
        invoices[i],
      );
    }
  }

  // Sync all invoices to Firestore
  Future<void> uploadLocalInvoicesToFirebase() async {
    try {
      List<Invoice> invoices = getAllInvoices();
      final currUserDoc =
          firestore.collection('users').doc(auth.currentUser!.uid);
      for (Invoice invoice in invoices) {
        Map<String, dynamic> invoiceData = invoice.toJson();
        String docId = invoice.docId!;
        // Set the invoice data in Firestore
        await currUserDoc.collection("invoices").doc(docId).set(invoiceData);
      }
      print('All invoices synced to Firebase successfully!');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchInvoicesFromFirebaseToLocal() async {
    try {
      final currUserDoc =
          firestore.collection('users').doc(auth.currentUser!.uid);
      QuerySnapshot snapshot = await currUserDoc.collection('invoices').get();

      for (var doc in snapshot.docs) {
        Map<String, dynamic> invoiceData = doc.data() as Map<String, dynamic>;
        // Convert Firebase data back into an Invoice object
        Invoice invoice = Invoice.fromJson(invoiceData);
        // Store/Update the invoice in local storage with the custom docId
        await invoiceBox.put(invoice.invoiceNumber, invoice);
      }

      print(
          'Firebase invoices fetched and updated in local storage successfully!');
    } catch (e) {
      rethrow;
    }
  }
}
