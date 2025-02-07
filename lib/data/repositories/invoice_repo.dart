import 'package:baniyabuddy/data/repositories/user_repo.dart';
import 'package:baniyabuddy/utils/app_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

import '../../constants/app_constants.dart';
import '../models/invoice.model.dart';

class InvoiceRepo {
  // final Box<int> _invoiceNumberBox =
  //     Hive.box<int>(AppConstants.globalInvoiceNumberBox);
  final Box<Invoice> _invoiceBox = Hive.box<Invoice>(AppConstants.invoiceBox);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserRepo _userRepo = UserRepo();

  // Method to  Generate docId for invoice
  String generateInvoiceDocId(int invNum) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'INV-$timestamp-$invNum';
  }

  // Method to add a new invoice
  Future<void> addInvoice(Invoice invoice) async {
    try {
      invoice.invoiceNumber = await _userRepo.getNextInvoiceNumber();
      invoice.docId = generateInvoiceDocId(invoice.invoiceNumber!);
      // Save the new invoice
      await _invoiceBox.put(invoice.docId, invoice);
      bool isConnected = await AppMethods.checkInternetConnection();
      if (isConnected) {
        await _firestore
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .collection("invoices")
            .doc(invoice.docId)
            .set(invoice.toJson());
      }
    } catch (err) {
      rethrow;
    }
  }

  // Retrieve an invoice by ID
  Invoice? getInvoice(String id) {
    return _invoiceBox.get(id);
  }

  // Retrieve all invoices
  List<Invoice> getAllInvoices() {
    return _invoiceBox.values.toList();
  }

  // Delete an invoice by ID
  Future<void> deleteInvoice(String id) async {
    // include a syncStatus field in invoice model, similar to transaction model
    try {
      bool isConnected = await AppMethods.checkInternetConnection();
      if (isConnected) {
        await _firestore
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .collection("invoices")
            .doc(id)
            .delete();
      }
      await _invoiceBox.delete(id);
    } catch (err) {
      rethrow;
    }
  }

  Future<void> deleteAllInvoiceFromLocal() async {
    await _invoiceBox.clear();
  }

  // Update an invoice by id
  Future<void> updateInvoice(Invoice updatedInvoice) async {
    try {
      bool isConnected = await AppMethods.checkInternetConnection();
      if (isConnected) {
        updatedInvoice.isSynced = true;
        await _firestore
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .collection("invoices")
            .doc(updatedInvoice.docId)
            .update(updatedInvoice.toJson());
      } else {
        updatedInvoice.isSynced = false;
      }
      await _invoiceBox.put(updatedInvoice.docId, updatedInvoice);
    } catch (err) {
      rethrow;
    }
  }

  // Update all invoices with a custom update function
  Future<void> updateAllInvoices(List<Invoice> invoices) async {
    for (int i = 0; i < invoices.length; ++i) {
      await updateInvoice(invoices[i]);
    }
  }

  // Sync all invoices to Firestore
  Future<void> uploadLocalInvoicesToFirebase() async {
    try {
      List<Invoice> invoices = getAllInvoices();
      // print(invoices);
      // int? globalInvoiceNumber = _userRepo.getGlobalInvoiceNumber();
      for (Invoice invoice in invoices) {
        if (invoice.isSynced) continue;
        print("Not Synced");
        invoice.isSynced = true;
        Map<String, dynamic> invoiceData = invoice.toJson();
        String docId = invoice.docId!;
        // Set the invoice data in Firestore
        await _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .collection("invoices")
            .doc(docId)
            .set(invoiceData);
        _invoiceBox.put(invoice.docId, invoice);
      }
      print('All invoices are updated on Firebase successfully!');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchInvoicesFromFirebaseToLocal() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('invoices')
          .get();

      for (var doc in snapshot.docs) {
        Map<String, dynamic> invoiceData = doc.data() as Map<String, dynamic>;
        Invoice invoice = Invoice.fromJson(invoiceData);

        // Store/Update the invoice in local storage with the custom docId
        await _invoiceBox.put(invoice.docId, invoice);
      }
    } catch (e) {
      rethrow;
    }
  }
}
