import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luna/dataBase/user_service/getUser.dart';
import 'package:luna/dataBase/user_service/service.dart';
import 'package:luna/modules/cataloge_module.dart';
import 'package:luna/modules/products_module.dart';
import 'package:luna/pages/list_furnitures.dart';

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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection('furniture')
                                .doc()
                                .set({
                              'id': '',
                              'availible': '',
                              'color': '',
                              'description': '',
                              'image': '',
                              'manufacturer': '',
                              'material': '',
                              'modelUrl': '',
                              'name': '',
                              'typeFurniture': '',
                              'typeRoom': '',
                              'cost': '',
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListFurnituresPage(
                                  type: '',
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Color(0xffff5d00),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Поиск',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
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
                              fontSize: 27,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Cataloge_Module(),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: Text(
                          "Товары",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 27,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      ProductsLv(),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
