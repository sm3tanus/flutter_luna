import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:luna/dataBase/collections/dataCollection.dart';

import 'package:luna/pages/unitFurniture.dart';
import 'package:toast/toast.dart';

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
  late var recycle;
  int currentCount = 0;
  int thisCost = 0;
  int currentCostDelivery = 0;
  int cost = 0;
  bool delivery = true;
  int secondDel = 0;
  int sale = 0;
  DataCollection data = DataCollection();
  int countUser = 0;
  int totalCount = 0;
  double percent = 0.0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    thisCost = widget.selectedRecycle['cost'];
    
    _loadData();
  }

  Future<void> _loadData() async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .doc(getUser()?.uid)
        .collection('recycleBin')
        .get();

    final users = await FirebaseFirestore.instance.collection('users').get();

    setState(() {
      recycle = result.docs
          .firstWhere((doc) => doc['id'] == widget.selectedRecycle['id']);
      final userDoc =
          users.docs.firstWhere((doc) => doc['uid'] == getUser()?.uid);

      sale = userDoc.data()['sale'];
      currentCount = recycle['count'];
      cost = recycle['cost'];
      currentCostDelivery = recycle['costDelivery'];
    });
  }

  _checkRecycle() {
    recycle.reference.update({
      'count': currentCount,
      'costDelivery': currentCostDelivery,
      'cost': cost,
    });
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.04,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.popAndPushNamed(context, '/');
                        },
                        icon: Icon(
                          Icons.keyboard_backspace,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.popAndPushNamed(context, '/');
                        },
                        icon: Icon(
                          Icons.home,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InfoFurniture(
                        selectedFurniture: widget.selectedRecycle,
                        type: widget.selectedRecycle['typeRoom'],
                      ),
                    ),
                  );
                },
                child: Card(
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
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(105, 72, 83, 69),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(100),
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (currentCount > 1) {
                                        currentCount--;
                                        currentCostDelivery -= 500;
                                        cost -= thisCost + 500;
                                        _checkRecycle();
                                      }
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
                                  onPressed: () {
                                    setState(() {
                                      currentCount++;
                                      currentCostDelivery += 500;
                                      cost += thisCost + 500;
                                      _checkRecycle();
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
                                width: MediaQuery.of(context).size.width * 0.03,
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
                                width: MediaQuery.of(context).size.width * 0.03,
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          Text(
                            'Товары,  ${currentCount.toString()}шт.',
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
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Text(
                                'Ваша скидка:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Text(
                                  '${sale.toString()}%',
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          Text(
                            'Итого:  ',
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.08,
                child: ElevatedButton(
                  onPressed: () async {
                    final res = await FirebaseFirestore.instance
                        .collection('users')
                        .doc(getUser()?.uid)
                        .collection('recycleBin')
                        .get();
                    var f = res.docs.firstWhere(
                        (doc) => doc['id'] == widget.selectedRecycle['id']);
                    Toast.show('Оплачено. Ваш заказ теперь в профиле.');
                    _checkRecycle();
                    print(cost.toString());
                    await data.addPaidCollection(f);
                    await data.deleteDataCollection(f);
                    Navigator.popAndPushNamed(context, '/');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color(0xff707d60),
                    ),
                    elevation: MaterialStateProperty.all<double>(0),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  child: Text(
                    'ОПЛАТИТЬ',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
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
