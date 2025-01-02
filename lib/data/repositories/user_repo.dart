import 'package:baniyabuddy/data/models/business.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

import '../../constants/app_constants.dart';
import '../models/user_model.dart';
import '../../../utils/app_methods.dart';

class UserRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final _upiIdBox = Hive.box<String>(AppConstants.upiIdBox);
  final _userBox = Hive.box<UserModel>(AppConstants.userBox);

  UserModel? getUser() {
    return _userBox.get(_auth.currentUser!.uid);
  }

  Future<List<User>> getAllUsers() async {
    List<User> users = [];
    return users;
  }

  Future<void> createUser(String uid) async {
    try {
      UserModel user = UserModel(
        uid: uid,
        email: _auth.currentUser!.email!,
        fullName: _auth.currentUser!.displayName,
        imageUrl: _auth.currentUser!.photoURL,
        globalInvoiceNumber: 0,
      );
      await _userBox.put(uid, user);
      await _firestore.collection('users').doc(uid).set(user.toJson());
    } catch (err) {
      rethrow;
    }
  }

  Future<void> deleteUserFromLocal() async {
    await _userBox.clear();
  }

  String? getProfileImage() {
    final UserModel? user = _userBox.get(_auth.currentUser!.uid);
    if (user == null) return null;
    return user.imageUrl;
  }

  Future<void> uploadUserToFirebase() async {
    try {
      bool isConnected = await AppMethods.checkInternetConnection();
      if (!isConnected) throw "You are not connected to the Internet";

      final UserModel? user = _userBox.get(_auth.currentUser!.uid);
      if (user != null) {
        await _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .update(user.toJson());
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<void> fetchUserFromFirebase() async {
    try {
      bool isConnected = await AppMethods.checkInternetConnection();
      if (!isConnected) throw "You are not connected to the Internet";

      final docSnap = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();
      final userDetails = docSnap.data();

      UserModel user = UserModel.fromJson(userDetails!);
      await _userBox.put(_auth.currentUser!.uid, user);
    } catch (err) {
      rethrow;
    }
  }

  Future<void> updateBusinessInfo(Business business) async {
    try {
      UserModel user = getUser()!;
      user.business = business;
      _userBox.put(_auth.currentUser!.uid, user);

      final bool isConnected = await AppMethods.checkInternetConnection();

      if (isConnected) {
        _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .update({AppConstants.business: business.toJson()});
      } else {
        throw AppConstants.savedLocally;
      }
    } catch (err) {
      rethrow;
    }
  }

  Business? getBusinessInfo() {
    final UserModel? user = _userBox.get(_auth.currentUser!.uid);
    return user?.business;
  }

  Future<void> saveUpiId(String upiId) async {
    try {
      UserModel user = getUser()!;
      user.upiId = upiId;
      await _userBox.put(_auth.currentUser!.uid, user);

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

  String? getUpiId() {
    final UserModel user = _userBox.get(_auth.currentUser!.uid)!;
    return user.uid;
  }

  Future<int> getNextInvoiceNumber() async {
    try {
      final user = getUser()!;
      user.globalInvoiceNumber++;
      await _userBox.put(_auth.currentUser!.uid, user);
      return user.globalInvoiceNumber;
    } catch (err) {
      rethrow;
    }
  }

  int getGlobalInvoiceNumber() {
    try {
      final UserModel user = _userBox.get(_auth.currentUser!.uid)!;
      return user.globalInvoiceNumber;
    } catch (err) {
      rethrow;
    }
  }
}
