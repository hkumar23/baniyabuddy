import 'package:baniyabuddy/data/models/transaction_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class TransactionRepo {
  Future<void> addTransaction(TransactionDetails transactionDetails) async {
    try {
      await _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .collection("transactions")
          .add(transactionDetails.toJson());
    } catch (err) {
      debugPrint(err.toString());
      rethrow;
    }
  }

  Future<List<TransactionDetails>> getTransactionsList() async {
    try {
      final response = await _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .collection("sales_record")
          .get();
      return response.docs
          .map((val) => TransactionDetails.fromJson(val.data()))
          .toList();
    } catch (err) {
      debugPrint(err.toString());
      rethrow;
    }
  }
}
