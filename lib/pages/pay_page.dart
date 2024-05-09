import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../dataBase/user_service/getUser.dart';

// ignore: must_be_immutable
class PayPage extends StatefulWidget {
  dynamic selectedRecycle;
  PayPage({super.key, this.selectedRecycle});

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  late Future<List<DocumentSnapshot>> filter;
  var recycle;
  int currentCount = 0;
  int currentCostDelivery = 0;
  int cost = 0;
  bool delivery = true;
  @override
  void initState() {
    super.initState();
    _checkRecycle();
  }

  Future<void> _checkRecycle() async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .doc(getUser()?.uid)
        .collection('recycleBin')
        .get();

    setState(() {
      recycle =
          result.docs.where((doc) => doc['id'] == widget.selectedRecycle['id']);
      currentCount = recycle.first['count'];
      cost = recycle.first['cost'];
      currentCostDelivery = recycle.first['costDelivery'];
      if (cost >= 5000 && delivery) {
        currentCostDelivery = (cost * 0.1).toInt();
        cost = cost + currentCostDelivery;
      } else if (cost >= 5000 && !delivery){
        currentCostDelivery = 0;
        cost = cost - currentCostDelivery;
      }
      if (currentCount <= 0) {
        currentCount = 1;
      }
      recycle.forEach((docSnapshot) {
        docSnapshot.reference.update({
          'costDelivery': currentCostDelivery,
          'count': currentCount,
          'cost': cost
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            child: Image.network(
                              widget.selectedRecycle['image'],
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
                                  widget.selectedRecycle['name'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          widget.selectedRecycle['cost']
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff707d60),
                                          ),
                                        ),
                                        Text(
                                          " ₽",
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
                                  widget.selectedRecycle['color'],
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
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Card(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffd8d9ce),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: EdgeInsets.only(left: 20, top: 10, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        "Информация о товаре",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                'Количество:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(105, 72, 83, 69),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(100),
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: () async {
                                    setState(() {
                                      recycle.forEach((docSnapshot) {
                                        int currentCount = docSnapshot['count'];
                                        currentCount--;
                                        docSnapshot.reference
                                            .update({'count': currentCount});
                                        _checkRecycle();
                                      });
                                    });
                                  },
                                  icon: Icon(
                                    Icons.exposure_minus_1,
                                    size: 30,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                currentCount.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(105, 72, 83, 69),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(100),
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: () async {
                                    setState(() {
                                      recycle.forEach((docSnapshot) {
                                        int currentCount = docSnapshot['count'];
                                        currentCount++;
                                        docSnapshot.reference
                                            .update({'count': currentCount});
                                        _checkRecycle();
                                      });
                                    });
                                  },
                                  icon: Icon(
                                    Icons.plus_one,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Card(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffd8d9ce),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  margin: EdgeInsets.only(left: 20, top: 10, right: 20),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        "О доставке",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                'Пункт выдачи:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Text(
                                  'ул.Лукина, д.81',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                  softWrap: true,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                'Стоимость:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Text(
                                  currentCostDelivery.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          Text(
                            'Доставка:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          Checkbox(
                              checkColor: Colors.black,
                              fillColor:
                                  MaterialStatePropertyAll(Color(0xffb8b5a2)),
                              value: delivery,
                              onChanged: (value) {
                                setState(() {
                                  delivery = value!;
                                  _checkRecycle();
                                });
                              }),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Card(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffd8d9ce),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  margin: EdgeInsets.only(left: 20, top: 10, right: 20),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          Text(
                            'Товары, ${currentCount.toString()}шт.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          Text(
                            'Итого: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          Text(
                            '${cost.toString()} ₽',
                            style: TextStyle(
                              color: Color(0xff859177),
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
