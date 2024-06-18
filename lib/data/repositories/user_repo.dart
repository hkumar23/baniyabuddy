import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
}
