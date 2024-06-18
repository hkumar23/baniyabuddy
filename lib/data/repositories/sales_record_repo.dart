import 'package:baniyabuddy/data/models/sales_record_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class SalesRecordRepo {
  Future<void> addSalesRecord(SalesRecordDetails salesRecord) async {
    try {
      await _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .collection("sales_record")
          .add(salesRecord.toJson());
    } catch (err) {
      debugPrint(err.toString());
      rethrow;
    }
  }

  Future<List<SalesRecordDetails>> getSalesRecord() async {
    try {
      final response = await _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .collection("sales_record")
          .get();
      return response.docs
          .map((val) => SalesRecordDetails.fromJson(val.data()))
          .toList();
    } catch (err) {
      debugPrint(err.toString());
      rethrow;
    }
  }
}
