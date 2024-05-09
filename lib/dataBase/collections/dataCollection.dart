import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luna/dataBase/user_service/getUser.dart';

class DataCollection {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addDataCollection(dynamic docs) async {
    try {
      await _firestore
          .collection('users')
          .doc(getUser()?.uid)
          .collection('recycleBin')
          .doc(docs['id'])
          .set({
        'id': docs['id'],
        'availible': docs['availible'],
        'color': docs['color'],
        'cost': docs['cost'],
        'description': docs['description'],
        'image': docs['image'],
        'manufacturer': docs['manufacturer'],
        'material': docs['material'],
        'modelUrl': docs['modelUrl'],
        'name': docs['name'],
        'typeFurniture': docs['typeFurniture'],
        'typeRoom': docs['typeRoom'],
        'paid': false,
        'inRecycle': true,
        'count': 1,
        'costDelivery': 0,
      });
    } catch (e) {
      print('Error adding data to nested collection: $e');
    }
  }

  Future<void> deleteDataCollection(dynamic docs) async {
    try {
      await _firestore
          .collection('users')
          .doc(getUser()?.uid)
          .collection('recycleBin')
          .doc(docs['id'])
          .delete();
    } catch (e) {
      print('Error delete data $e');
    }
  }
}
