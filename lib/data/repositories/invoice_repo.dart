import 'package:baniyabuddy/data/repositories/user_repo.dart';
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

  // Future<int> getNextInvoiceNumber() async {
  //   // Check if there is already an invoice number saved
  //   if (_invoiceNumberBox.isEmpty) {
  //     // If not, set the starting invoice number (e.g., 1)
  //     await _invoiceNumberBox.put(AppConstants.globalInvoiceNumber, 1);
  //     return 1;
  //   } else {
  //     // Fetch the Global invoice number
  //     int? currentInvoiceNumber =
  //         _invoiceNumberBox.get(AppConstants.globalInvoiceNumber);
  //     if (currentInvoiceNumber == null) {
  //       throw Exception("Global invoice number null");
  //     }
  //     return currentInvoiceNumber + 1;
  //   }
  // }

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
      // Update the global invoice number
      // await _invoiceNumberBox.put(
      //   AppConstants.globalInvoiceNumber,
      //   invoice.invoiceNumber!,
      // );
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
    await _invoiceBox.delete(id);
  }

  Future<void> deleteAllInvoiceFromLocal() async {
    await _invoiceBox.clear();
  }

  // Update an invoice by id
  Future<void> updateInvoice(Invoice updatedInvoice) async {
    updatedInvoice.isSynced = false;
    await _invoiceBox.put(updatedInvoice.docId, updatedInvoice);
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
        Map<String, dynamic> invoiceData = invoice.toJson();
        String docId = invoice.docId!;
        // Set the invoice data in Firestore
        await _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .collection("invoices")
            .doc(docId)
            .set(invoiceData);
        invoice.isSynced = true;
        _invoiceBox.put(invoice.docId, invoice);
      }
      // await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      //   AppConstants.globalInvoiceNumber: globalInvoiceNumber,
      // });
      print('All invoices are updated on Firebase successfully!');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchInvoicesFromFirebaseToLocal() async {
    try {
      // print("Before Fetching: ${_invoiceBox.values.toList().length}");
      // if (!_invoiceBox.isOpen) {
      //   await Hive.openBox<Invoice>(AppConstants.invoiceBox);
      // }
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('invoices')
          .get();
      // print(snapshot.docs.length);
      for (var doc in snapshot.docs) {
        Map<String, dynamic> invoiceData = doc.data() as Map<String, dynamic>;
        // print(invoiceData);
        Invoice invoice = Invoice.fromJson(invoiceData);
        // print(invoice);
        // // Store/Update the invoice in local storage with the custom docId
        await _invoiceBox.put(invoice.docId, invoice);
      }
      // print("After Fetching: ${_invoiceBox.values.toList().length}");
      // final userDocSnap = await _firestore
      //     .collection('users')
      //     .doc(_auth.currentUser!.uid)
      //     .get();
      // final userData = userDocSnap.data();
      // int? globalInvoiceNum = userData?[AppConstants.globalInvoiceNumber];

      // await _invoiceNumberBox.put(
      //     AppConstants.globalInvoiceNumber, globalInvoiceNum ?? 0);
    } catch (e) {
      // print(e);
      rethrow;
    }
  }
}
