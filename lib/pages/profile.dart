import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luna/dataBase/user_service/getUser.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                      Row(
                        children: [
                          StreamBuilder<
                              List<
                                  QueryDocumentSnapshot<Map<String, dynamic>>>>(
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
                                    (element) =>
                                        element['uid'] == getUser()?.uid);
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
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            getUser()!.email.toString(),
                          ),
                          IconButton(onPressed: () {}, icon: Icon(Icons.edit))
                        ],
                      )
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
                    width: MediaQuery.of(context).size.width * 0.85,
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Text(
                  "История заказов",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
