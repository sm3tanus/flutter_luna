import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luna/dataBase/user_service/getUser.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SalePage extends StatefulWidget {
  const SalePage({super.key});

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  int countUser = 0;
  int totalCount = 0;
  int percent = 0;
  @override
  Future<void> initState() async {
    var users = await FirebaseFirestore.instance
        .collection('users')
        .doc(getUser()!.uid)
        .collection('recycleBin')
        .snapshots();
    users.listen((snapshot) {
      if (snapshot != null && snapshot.docs != null) {
        var filteredDocs =
            snapshot.docs.where((doc) => doc['id'] != '').toList();
        countUser = filteredDocs.length;
      }
    });
    // List furniture = (await FirebaseFirestore.instance
    //     .collection('furniture')
    //     .snapshots()
    //     .map(
    //       (event) =>
    //           event.docs.where((element) => element['id'] != '').toList(),
    //     )) as List;
    // totalCount = furniture.length;
    // percent = ((countUser / totalCount) * 100) as int;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            new CircularPercentIndicator(
              radius: 120.0,
              lineWidth: 13.0,
              animation: true,
              percent: percent.toDouble(),
              center: new Text(
                "${percent.toString()}",
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              footer: new Text(
                "Sales this week",
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}
