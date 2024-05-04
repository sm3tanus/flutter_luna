import 'package:flutter/material.dart';
import 'package:luna/pages/cataloge_page.dart';
import 'package:luna/pages/profile.dart';
import 'package:luna/pages/shopping_cart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  final pages = [CatalogePage(), ShoppingCart(), Profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(index),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Корзина',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}
