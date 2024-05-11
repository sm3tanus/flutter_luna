import 'package:cloud_firestore/cloud_firestore.dart';

class UsersCollection {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addUserCollection(
      String id, String email, String name, String image, String password) async {
       
    try {
      await _firebaseFirestore.collection('users').doc(id).set({
        'uid': id,
        'email': email,
        'name': name,
        'image': image,
        'password': password,
        'sale': 0,
      });
    } catch (e) {
      return;
    }
  }

  Future<void> editUserCollection(String id, String name, String image) async {
    
    try {
      await _firebaseFirestore.collection('users').doc(id).update({
        'name': name,
        'image': image,
      });
    } catch (e) {
      return;
    }
  }

  Future<void> deleteUserCollection(dynamic docs) async {
    try {
      await _firebaseFirestore.collection('users').doc(docs.id).delete();
    } catch (e) {
      return;
    }
  }
}