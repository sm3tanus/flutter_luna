import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luna/dataBase/collections/dataCollection.dart';
import 'package:luna/pages/list_furnitures.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../dataBase/user_service/getUser.dart';

// ignore: must_be_immutable
class InfoFurniture extends StatefulWidget {
  dynamic selectedFurniture;
  String type;
  InfoFurniture({Key? key, required this.selectedFurniture, required this.type})
      : super(key: key);

  @override
  State<InfoFurniture> createState() => _InfoFurnitureState();
}

class _InfoFurnitureState extends State<InfoFurniture> {
  DataCollection data = DataCollection();
  late Future<List<DocumentSnapshot>> filter;
  bool recycle = false;

  @override
  void initState() {
    super.initState();
    filter = FirebaseFirestore.instance
        .collection('users')
        .doc(getUser()?.uid)
        .collection('recycleBin')
        .get()
        .then((querySnapshot) => querySnapshot.docs
            .where((element) => element['id'] != "")
            .toList());
    _checkRecycle();
  }

  Future<void> _checkRecycle() async {
    final result = await filter;
    setState(() {
      recycle =
          result.any((doc) => doc['id'] == widget.selectedFurniture['id']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListFurnituresPage(
                          type: widget.type,
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.keyboard_backspace,
                    color: Colors.black,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Image.network(
                    "https://firebasestorage.googleapis.com/v0/b/luna-a728b.appspot.com/o/vetka.png?alt=media&token=dfa43c33-7bad-4539-8c13-84c382b6d134",
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 100,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: ModelViewer(
                    backgroundColor: Colors.transparent,
                    // src: widget.selectedFurniture['modelUrl'],
                    src: 'models/KitchenTable1.glb',
                    ar: false,
                    arModes: ['scene-viewer', 'webxr', 'quick-look'],
                    autoRotate: true,
                    disableZoom: true,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.09,
                ),
                Text(
                  widget.selectedFurniture['name'],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.05,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                color: Color(0xffd8d9ce),
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.06,
                      ),
                      Text(
                        widget.selectedFurniture['typeFurniture'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.thumb_up,
                              size: 20,
                              color: Color(0xff707d60),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.thumb_down,
                              size: 20,
                              color: Color(0xffa67f5d),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.68,
                        height: 2,
                        decoration: BoxDecoration(
                          color: Color(0xffb8b5a2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.06,
                      ),
                      Text(
                        '- ',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          widget.selectedFurniture['color'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.005,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.06,
                      ),
                      Text(
                        '- ',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          widget.selectedFurniture['material'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.005,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.06,
                      ),
                      Text(
                        '- ',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          widget.selectedFurniture['manufacturer'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.68,
                        height: 2,
                        decoration: BoxDecoration(
                          color: Color(0xffb8b5a2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.06,
                      ),
                      Flexible(
                        child: Text(
                          widget.selectedFurniture['description'],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xff707d60),
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    try {
                      await data.addDataCollection(widget.selectedFurniture);
                      setState(() {
                        recycle = true;
                      });
                    } catch (e) {
                      print('no result');
                    }
                  },
                  icon: Icon(
                    Icons.local_grocery_store_outlined,
                    size: 30,
                    color: recycle
                        ? Color.fromARGB(255, 255, 166, 0)
                        : Colors.black,
                  ),
                ),
                Visibility(
                  visible: recycle,
                  child: IconButton(
                    onPressed: () async {
                      await data.deleteDataCollection(widget.selectedFurniture);
                      setState(() {
                        recycle = false;
                      });
                    },
                    icon: Icon(
                      Icons.remove,
                      color: Color.fromARGB(255, 255, 166, 0),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              widget.selectedFurniture['cost'].toString(),
              style: TextStyle(
                  color: Color(0xffb8b5a2),
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
            ),
            SizedBox(
              width: 80,
              height: 80,
              child: FloatingActionButton(
                onPressed: () {},
                child: Text(
                  'Купить',
                  style: TextStyle(color: Color(0xffb8b5a2)),
                ),
                backgroundColor: Colors.black,
                elevation: 10.0,
                shape: CircleBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
