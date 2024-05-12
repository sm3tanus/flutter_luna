import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luna/dataBase/user_service/getUser.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SalePage extends StatefulWidget {
  const SalePage({Key? key}) : super(key: key);

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  int countUser = 0;
  int totalCount = 0;
  double percent = 0.0;
  bool isLoading = true;
  int sale = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      var users = await FirebaseFirestore.instance.collection('users').get();
      var currentUser =
          users.docs.firstWhere((doc) => doc['uid'] == getUser()!.uid);
      var recycleBinSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(getUser()!.uid)
          .collection('paid')
          .get();
      var furniture =
          await FirebaseFirestore.instance.collection('furniture').get();
      setState(() {
        totalCount = furniture.docs.length;
        countUser =
            recycleBinSnapshot.docs.where((doc) => doc['id'] != '').length;
        percent = totalCount != 0 ? countUser / totalCount : 0.0;
        int percentInt = (percent * 100).toInt();
        isLoading = false;
         if (percentInt  == 0) {
        sale = 0;
      } else if (percentInt <= 20 && percentInt > 0) {
        sale = 2;
        } else if (percentInt > 20 && percentInt <= 40) {
          sale = 5;
        } else if (percentInt > 40 && percentInt <= 60) {
          sale = 10;
        } else if (percentInt > 60 && percentInt <= 80) {
          sale = 20;
        } else if (percent > 80 && percent <= 100) {
          sale = 40;
        }

        currentUser.reference.update({
          'sale': sale,
        });
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
            Center(
              child: Column(
                children: [
                  Text(
                    'Ваш процент выкупа:',
                    style: TextStyle(fontSize: 22),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  isLoading
                      ? Text(
                          'Вы ничего не купили.',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        )
                      : CircularPercentIndicator(
                          radius: 150.0,
                          lineWidth: 13.0,
                          animation: true,
                          percent: percent,
                          center: Text(
                            "${(percent * 100)}%",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30.0),
                          ),
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: Color(0xff707d60),
                          backgroundColor: Color(0xffd8d9ce),
                        ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Ваша скидка: ',
                        style: TextStyle(fontSize: 22),
                      ),
                      Text(
                        '${sale.toString()}%',
                        style: TextStyle(fontSize: 22),
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
                  ExpansionTile(
                    shape: Border.all(color: Colors.transparent),
                    backgroundColor: Color(0xffd8d9ce),
                    title: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Как работает скидка?',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          'Скидка для пользователей работает следующим образом:\nчем больше процент выкупа, тем больше персональная скидка.',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    shape: Border.all(color: Colors.transparent),
                    backgroundColor: Color(0xffd8d9ce),
                    title: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Что такое процент выкупа?',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          'Процент работает следующим образом:\nчем больше куплено вещей, тем больше процент выкупа.',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
