import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:luna/pages/list_furnitures.dart';

class ProductsLv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.05,
      height: MediaQuery.of(context).size.height * 0.35,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('furniture').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final documents = snapshot.data!.docs;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = documents.elementAt(index);
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListFurnituresPage(
                            type: "",
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.05,
                              ),
                              Image.network(
                                document['image'],
                                width: 200,
                                height: 170,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.03,
                              ),
                              Text(
                                document['name'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xff171717),
                                ),
                                softWrap: true,
                              ),
                              Row(
                                children: [
                                  Text(
                                    document['cost'].toString(),
                                    style: TextStyle(
                                        color: Color(0xffff5d00),
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    ' ₽',
                                    style: TextStyle(
                                      color: Color(0xff171717),
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
