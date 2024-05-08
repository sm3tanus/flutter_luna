import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luna/dataBase/user_service/getUser.dart';
import 'package:luna/pages/pay_page.dart';

// ignore: must_be_immutable
class RecycleBinPage extends StatefulWidget {
  RecycleBinPage({Key? key}) : super(key: key);

  @override
  State<RecycleBinPage> createState() => _RecycleBinPageState();
}

class _RecycleBinPageState extends State<RecycleBinPage> {
  dynamic selectedFurniture;
  var filter = FirebaseFirestore.instance
      .collection('users')
      .doc(getUser()?.uid)
      .collection('recycleBin')
      .snapshots()
      .map((event) =>
          event.docs.where((element) => element['id'] != "").toList());

  Widget furnitureCard(BuildContext context, dynamic docs) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffd8d9ce),
          borderRadius: BorderRadius.all(
            Radius.circular(125),
          ),
        ),
        margin: EdgeInsets.only(left: 20, top: 10, right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  child: Image.network(
                    docs['image'],
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.width * 0.4,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 160,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        docs['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                docs['cost'].toString(),
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff707d60),
                                ),
                              ),
                              Text(
                                "р",
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        docs['color'],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.keyboard_arrow_right, size: 35),
              ],
            ),
            
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: filter,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  var filteredDocs = snapshot.data;
                  return ListView.builder(
                    itemCount: filteredDocs?.length,
                    itemBuilder: (context, index) {
                      final furniture = filteredDocs?[index].data();
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFurniture = furniture;

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PayPage(selectedRecycle: selectedFurniture,)
                              ),
                            );
                          });
                        },
                        child: furnitureCard(context, furniture),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
