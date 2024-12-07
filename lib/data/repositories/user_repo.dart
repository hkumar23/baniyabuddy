import 'package:baniyabuddy/constants/app_constants.dart';
import 'package:baniyabuddy/utils/app_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

class UserRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _upiIdBox = Hive.box<String>(AppConstants.upiIdBox);

  Future<User?> getUser(String id) async {
    return null;
  }

  Future<List<User>> getAllUsers() async {
    List<User> users = [];
    return users;
  }

  Future<void> createUser(User user) async {}

  Future<void> updateUser(User user) async {}

  Future<void> deleteUser(String id) async {}

  Future<void> saveUpiId(String upiId) async {
    try {
      await _upiIdBox.put(0, upiId);
      final isConnected = await AppMethods.checkInternetConnection();

      if (isConnected) {
        _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .update({AppConstants.upiId: upiId});
      } else {
        throw AppConstants.savedLocally;
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<void> uploadUserToFirebase() async {
    try {
      final upiId = _upiIdBox.get(0);
      if (upiId != null) {
        await _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .update({AppConstants.upiId: upiId});
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<void> fetchUserFromFirebase() async {
    try {
      final docSnap = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();
      final userDetails = docSnap.data();
      if (userDetails != null && userDetails.isNotEmpty) {
        final upiId = userDetails[AppConstants.upiId];
        if (upiId != null) {
          await _upiIdBox.put(0, upiId);
        }
      }
    } catch (err) {
      rethrow;
    }
  }

  String? getUpiId() {
    return _upiIdBox.get(0);
  }

  Future<void> deleteUpiIdFromLocal() async {
    await _upiIdBox.clear();
  }
}
