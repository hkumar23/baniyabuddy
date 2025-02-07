import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'dart:math';

import '../../utils/app_methods.dart';
import '../../constants/app_constants.dart';
import '../models/transaction.model.dart';

class TransactionRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Box<TransactionDetails> _transactionBox =
      Hive.box<TransactionDetails>(AppConstants.transactionBox);

  String generateTransactionId() {
    final timestamp =
        DateTime.now().millisecondsSinceEpoch; // Current timestamp
    final random = Random().nextInt(99999); // Random 5-digit number
    return 'TXN-$timestamp-$random';
  }

  Future<void> addTransaction(TransactionDetails transaction) async {
    try {
      transaction.docId = generateTransactionId();
      Map<String, dynamic> data = transaction.toJson();
      transaction.syncStatus = AppConstants.added;

      bool isConnected = await AppMethods.checkInternetConnection();
      if (isConnected) {
        transaction.isSynced = true;
        await _firestore
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .collection("transactions")
            .doc(transaction.docId)
            .set(data);
      } else {
        transaction.isSynced = false;
      }
      await _transactionBox.put(transaction.docId, transaction);
    } catch (err) {
      debugPrint(err.toString());
      rethrow;
    }
  }

  Future<void> updateTransaction(TransactionDetails updatedTransaction) async {
    try {
      bool isConnected = await AppMethods.checkInternetConnection();
      updatedTransaction.syncStatus = AppConstants.updated;
      if (isConnected) {
        updatedTransaction.isSynced = true;
        await _firestore
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .collection("invoices")
            .doc(updatedTransaction.docId)
            .update(updatedTransaction.toJson());
      } else {
        updatedTransaction.isSynced = false;
      }
      await _transactionBox.put(updatedTransaction.docId, updatedTransaction);
    } catch (err) {
      rethrow;
    }
  }

  List<TransactionDetails> getTransactionsList() {
    // AppMethods.modifyingAllUserData();
    return _transactionBox.values.toList();
  }

  TransactionDetails? getTransaction(String docId) {
    return _transactionBox.get(docId);
  }

  Future<void> deleteAllTransactionsFromLocal() async {
    await _transactionBox.clear();
  }

  Future<void> deleteTransaction(String transactionId) async {
    try {
      TransactionDetails? transaction = getTransaction(transactionId);
      if (transaction == null) throw "No transaction found";
      transaction.syncStatus = AppConstants.deleted;

      bool isConnected = await AppMethods.checkInternetConnection();
      if (isConnected) {
        await _firestore
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .collection("transactions")
            .doc(transactionId)
            .delete();
        await _transactionBox.delete(transactionId);
      } else {
        // throw AppLanguage.savedLocally;
        await _transactionBox.put(transactionId, transaction);
      }
    } catch (err) {
      debugPrint(err.toString());
      rethrow;
    }
  }

  // Sync all transactions to Firestore
  Future<void> uploadLocalTransactionsToFirebase() async {
    try {
      List<TransactionDetails> transactions = getTransactionsList();
      for (TransactionDetails transaction in transactions) {
        if (transaction.isSynced) continue;
        String docId = transaction.docId!;
        // print(transactionDetails);
        final docReference = _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .collection("transactions")
            .doc(docId);
        switch (transaction.syncStatus) {
          case AppConstants.added:
            transaction.isSynced = true;
            await docReference.set(transaction.toJson());
            _transactionBox.put(docId, transaction);
            break;
          case AppConstants.updated:
            transaction.isSynced = true;
            await docReference.update(transaction.toJson());
            _transactionBox.put(docId, transaction);
            break;
          case AppConstants.deleted:
            await docReference.delete();
            _transactionBox.delete(docId);
            break;
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchTransactionsFromFirebaseToLocal() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('transactions')
          .get();
      for (var doc in snapshot.docs) {
        Map<String, dynamic> transactionData =
            doc.data() as Map<String, dynamic>;
        // print(transactionData);
        TransactionDetails transaction =
            TransactionDetails.fromJson(transactionData);
        // transaction.isSynced = true;
        transaction.syncStatus = AppConstants.updated;
        transaction.docId = doc.id;

        await _transactionBox.put(doc.id, transaction);
      }
    } catch (e) {
      rethrow;
    }
  }
}
