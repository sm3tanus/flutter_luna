import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luna/pages/unitFurniture.dart';

// ignore: must_be_immutable
class ListFurnituresPage extends StatefulWidget {
  String type;
  ListFurnituresPage({Key? key, required this.type}) : super(key: key);

  @override
  State<ListFurnituresPage> createState() => _ListFurnituresPageState();
}

class _ListFurnituresPageState extends State<ListFurnituresPage> {
  dynamic selectedFurniture;
  var filter = FirebaseFirestore.instance
      .collection('furniture')
      .snapshots()
      .map((event) =>
          event.docs.where((element) => element['typeRoom'] != "").toList());
  @override
  void initState() {
    print(widget.type);
    if (widget.type != "") {
      filter = FirebaseFirestore.instance
          .collection('furniture')
          .snapshots()
          .map((event) => event.docs
              .where((element) => element['typeRoom'] == widget.type)
              .toList());
    }
    super.initState();
  }

  Widget furnitureCard(BuildContext context, dynamic docs) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(125),
          ),
        ),
        margin: EdgeInsets.only(left: 20, top: 10, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 30,
            ),
            Image.network(
              docs['image'],
              width: 170,
              height: 170,
              fit: BoxFit.fill,
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
                    children: [
                      Text(
                        docs['cost'].toString(),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffff5d00),
                        ),
                      ),
                      Text(
                        " ₽",
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                        ),
                      )
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/');
                },
                icon: Icon(Icons.keyboard_backspace),
                color: Colors.black,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xff171717),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TextField(
                  onChanged: ((value) {
                    if (value.length != 0) {
                      filter = FirebaseFirestore.instance
                          .collection('furniture')
                          .snapshots()
                          .map((event) => event.docs
                              .where((element) =>
                                  element['typeRoom'] == widget.type &&
                                  element['name']
                                      .toString()
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                              .toList());
                    } else {
                      filter = FirebaseFirestore.instance
                          .collection('furniture')
                          .snapshots()
                          .map((event) => event.docs
                              .where((element) =>
                                  element['typeRoom'] == widget.type)
                              .toList());
                    }
                  }),
                  textAlignVertical: TextAlignVertical.center,
                  cursorColor: Colors.white,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    prefixIconColor: Color(0xffff5d00),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
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
                                builder: (context) => InfoFurniture(
                                  selectedFurniture: selectedFurniture,
                                  type: widget.type,
                                ),
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
