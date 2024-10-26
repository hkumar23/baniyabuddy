import 'package:baniyabuddy/constants/app_constants.dart';
import 'package:baniyabuddy/constants/app_language.dart';
import 'package:baniyabuddy/data/models/transaction.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class TransactionRepo {
  Future<void> addTransaction(TransactionDetails transactionDetails) async {
    Map<String, dynamic> data = transactionDetails.toJson();
    if (data[AppConstants.customerName] == "") {
      data[AppConstants.customerName] = AppLanguage.unknown;
    }
    try {
      if (data['docId'] == "" && data.containsKey("docId")) {
        data.remove("docId");
      }
      await _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .collection("transactions")
          .add(data);
    } catch (err) {
      debugPrint(err.toString());
      rethrow;
    }
  }

  Future<List<TransactionDetails>> getTransactionsList() async {
    // AppMethods.modifyingAllUserData();
    try {
      final response = await _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .collection("transactions")
          .get();
      // print("Yes");
      return response.docs.map((val) {
        Map<String, dynamic> transaction = val.data();
        transaction["docId"] = val.id;
        return TransactionDetails.fromJson(transaction);
      }).toList();
    } catch (err) {
      debugPrint(err.toString());
      rethrow;
    }
  }

  Future<void> deleteTransaction(String transactionId) async {
    try {
      await _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .collection("transactions")
          .doc(transactionId)
          .delete();
    } catch (err) {
      debugPrint(err.toString());
      rethrow;
    }
  }
}
