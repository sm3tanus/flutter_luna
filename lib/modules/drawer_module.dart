import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luna/dataBase/user_service/getUser.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  var users;
  @override
  void initState() {
    users = FirebaseFirestore.instance.collection('users').snapshots().map(
        (event) => event.docs
            .where((element) => element['uid'] == getUser()?.uid)
            .toList());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
          stream: users,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error');
            } else {
              var userDocs = snapshot.data ?? [];
              String name = '';

              var matchingDocument = userDocs
                  .firstWhere((element) => element['uid'] == getUser()?.uid);
              // ignore: unnecessary_null_comparison
              if (matchingDocument != null) {
                name = matchingDocument['name'] as String;
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.account_circle,
                      color: Colors.black,
                      size: 50,
                    ),
                  ),
                ],
              );
            }
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 2,
              decoration: BoxDecoration(
                color: Color(0xff707d60),
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
            )
          ],
        ),
        Stack(
          children: [
            Container(
              child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/luna-a728b.appspot.com/o/loza.png?alt=media&token=a58c2c48-c94e-4511-a7a2-6809624d834a',
                height: MediaQuery.of(context).size.width * 1.4,
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text('Профиль'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text('Корзина'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text('Вопросы'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text('Контакты'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text('О компании'),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
