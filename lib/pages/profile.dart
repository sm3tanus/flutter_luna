import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luna/dataBase/user_service/getUser.dart';
import 'package:luna/dataBase/user_service/service.dart';
import 'package:luna/pages/unitFurniture.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var users;
  dynamic selectedFurniture;
  @override
  void initState() {
    users = FirebaseFirestore.instance.collection('users').snapshots().map(
          (event) => event.docs
              .where((element) => element['uid'] == getUser()?.uid)
              .toList(),
        );

    super.initState();
  }

  var filter = FirebaseFirestore.instance
      .collection('users')
      .doc(getUser()?.uid)
      .collection('paid')
      .snapshots()
      .map(
        (event) => event.docs.where((element) => element['id'] != "").toList(),
      );

  Widget furnitureCard(BuildContext context, dynamic docs) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(125),
        ),
        margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    docs['image'],
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.width * 0.4,
                  ),
                ),
                const SizedBox(
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
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffff5d00),
                                ),
                              ),
                              const Text(
                                " ₽",
                                style: TextStyle(
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
                      Text(
                        '${docs['count'].toString()}шт.',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.keyboard_arrow_right, size: 35),
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
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Icon(Icons.account_circle, size: 100),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder<
                        List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
                      stream: users,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error');
                        } else {
                          var userDocs = snapshot.data ?? [];
                          String name = '';

                          var matchingDocument = userDocs.firstWhere(
                              (element) => element['uid'] == getUser()?.uid);
                          // ignore: unnecessary_null_comparison
                          if (matchingDocument != null) {
                            name = matchingDocument['name'] as String;
                          }
                          return Text(
                            name,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 26),
                          );
                        }
                      },
                    ),
                    Row(
                      children: [
                        Text(
                          getUser()!.email.toString(),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.27,
                ),
                IconButton(
                  onPressed: () {
                    AuthService authService = AuthService();
                    authService.logOut();
                  },
                  icon: Icon(
                    Icons.exit_to_app,
                    size: 35,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 2,
                  decoration: BoxDecoration(
                    color: Color(0xffff5d00),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(context, '/question');
                      },
                      child: Text(
                        'Обратная связь',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(context, '/sale');
                      },
                      child: Text(
                        'Статистика',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Expanded(
              child: StreamBuilder(
                stream: filter,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text('');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2),
                        Text(
                          'Вы еще ничего не заказывали.',
                          style: TextStyle(
                              fontSize: 22,
                              color: const Color.fromARGB(255, 90, 90, 90),
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    );
                  } else {
                    var filteredDocs = snapshot.data;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredDocs?.length,
                      itemBuilder: (context, index) {
                        final furniture = filteredDocs?[index].data();
                        return GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                selectedFurniture = furniture;

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => InfoFurniture(
                                      selectedFurniture: selectedFurniture,
                                      type: selectedFurniture['typeRoom'],
                                    ),
                                  ),
                                );
                              },
                            );
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
      ),
    );
  }
}
