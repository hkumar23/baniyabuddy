import 'package:baniyabuddy/constants/app_constants.dart';
import 'package:baniyabuddy/utils/app_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

import '../models/business.model.dart';

class BusinessRepo {
  final Box<Business> _businessBox =
      Hive.box<Business>(AppConstants.businessBox);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveBusinessInfo(Business business) async {
    try {
      bool isConnected = await AppMethods.checkInternetConnection();
      await _businessBox.put(0, business);
      if (isConnected) {
        _firestore.collection('users').doc(_auth.currentUser!.uid).update({
          "business": business.toJson(),
        });
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<void> uploadBusinessInfoToFirebase() async {
    try {
      final business = _businessBox.get(0);
      if (business != null) {
        await _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .update({AppConstants.business: business.toJson()});
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<void> fetchBusinessInfoFromFirebase() async {
    try {
      final docSnap = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();
      final businessInfo = docSnap.data();
      if (businessInfo != null && businessInfo.isNotEmpty) {
        final json = businessInfo[AppConstants.business];
        if (json != null) {
          final business = Business.fromJson(json);
          await _businessBox.put(0, business);
        }
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<void> deleteBusinessInfoFromLocal() async {
    await _businessBox.clear();
  }
}