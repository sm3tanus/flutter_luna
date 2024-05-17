import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luna/dataBase/user_service/getUser.dart';

class DataCollection {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addDataCollection(dynamic docs) async {
    try {
      int countUser = 0;
      int totalCount = 0;
      double percent = 0.0;

      int sale = 0;

      var users = await FirebaseFirestore.instance.collection('users').get();
      var currentUser =
          users.docs.firstWhere((doc) => doc['uid'] == getUser()!.uid);
      var recycleBinSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(getUser()!.uid)
          .collection('paid')
          .get();
      var furniture =
          await FirebaseFirestore.instance.collection('furniture').get();

      totalCount = furniture.docs.length;
      countUser =
          recycleBinSnapshot.docs.where((doc) => doc['id'] != '').length;
      percent = totalCount != 0 ? countUser / totalCount : 0.0;
      int percentInt = (percent * 100).toInt();

      if (percentInt  == 0) {
        sale = 0;
      } else if (percentInt <= 20 && percentInt > 0) {
        sale = 2;
      } else if (percentInt > 20 && percentInt <= 40) {
        sale = 5;
      } else if (percentInt > 40 && percentInt <= 60) {
        sale = 10;
      } else if (percentInt > 60 && percentInt <= 80) {
        sale = 20;
      } else if (percent > 80 && percent <= 100) {
        sale = 40;
      }

      currentUser.reference.update({
        'sale': sale,
      });

      _firestore
          .collection('users')
          .doc(getUser()?.uid)
          .collection('recycleBin')
          .doc()
          .set({
        'id': docs['id'],
        'availible': docs['availible'],
        'color': docs['color'],
        'description': docs['description'],
        'image': docs['image'],
        'manufacturer': docs['manufacturer'],
        'material': docs['material'],
        'modelUrl': docs['modelUrl'],
        'name': docs['name'],
        'typeFurniture': docs['typeFurniture'],
        'typeRoom': docs['typeRoom'],
        'inRecycle': true,
        'count': 1,
        'costDelivery': docs['cost'] >= 5000 ? 500 : 0,
        'cost': docs['cost'] >= 5000
            ? (docs['cost'] - docs['cost'] * sale / 100).toInt() + 500
            : docs['cost'],
      });
    } catch (e) {
      print('Error adding data to nested collection: $e');
    }
  }
  
  Future<void> addPaidCollection(dynamic docs) async {
  
      await _firestore
          .collection('users')
          .doc(getUser()?.uid)
          .collection('paid')
          .doc()
          .set({
        'id': docs['id'],
        'availible': docs['availible'],
        'color': docs['color'],
        'description': docs['description'],
        'image': docs['image'],
        'manufacturer': docs['manufacturer'],
        'material': docs['material'],
        'modelUrl': docs['modelUrl'],
        'name': docs['name'],
        'typeFurniture': docs['typeFurniture'],
        'typeRoom': docs['typeRoom'],
        'count': docs['count'],
        'costDelivery': docs['costDelivery'],
        'cost': docs['cost'],
      });
 
  }

  Future<void> deleteDataCollection(dynamic docs) async {
    try {
      await _firestore
          .collection('users')
          .doc(getUser()?.uid)
          .collection('recycleBin')
          .where('id', isEqualTo: docs['id'])
          .get()
          .then(
        (querySnapshot) {
          querySnapshot.docs.forEach(
            (doc) {
              doc.reference.delete();
            },
          );
        },
      );
    } catch (e) {
      print('Error delete data $e');
    }
  }
}
