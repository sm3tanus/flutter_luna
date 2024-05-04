import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luna/dataBase/user_service/getUser.dart';
import 'package:luna/dataBase/user_service/service.dart';
import 'package:luna/modules/cataloge_module.dart';
import 'package:luna/modules/drawer_module.dart';
import 'package:luna/modules/products_module.dart';

class CatalogePage extends StatefulWidget {
  const CatalogePage({Key? key}) : super(key: key);

  @override
  State<CatalogePage> createState() => _CatalogePageState();
}

class _CatalogePageState extends State<CatalogePage> {
  AuthService authService = AuthService();

  final ScrollController _scrollController = ScrollController();

  void _scrollToElement() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

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
          controller: _scrollController,
          child: Center(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('furniture')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error'),
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              Image.network(
                                "https://firebasestorage.googleapis.com/v0/b/luna-a728b.appspot.com/o/bunner.png?alt=media&token=7ed89568-f611-4f77-a619-ab2f23b4d204",
                                fit: BoxFit.cover,
                                width: 100,
                                height: 200,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                                margin: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * 0.05,
                                  left: MediaQuery.of(context).size.width * 0.2,
                                ),
                                width: MediaQuery.of(context).size.width / 1.3,
                                child: Text(
                                  "Начни свой поиск \nпрямо здесь и сейчас",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xff859177),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          cursorColor: Colors.black,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            prefixIconColor: Colors.black,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: Text(
                          "Каталог",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                     Cataloge_Module(),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: Text(
                          "Товары",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      ProductsLv(),
                      IconButton(
                        onPressed: () {
                          authService.logOut();
                        },
                        icon: Icon(Icons.logout),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
      endDrawer: Drawer(
        backgroundColor: Color(0xffd8d9ce),
        child: DrawerWidget(),
      ),
    );
  }
}
