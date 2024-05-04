import 'package:flutter/material.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: <Widget>[
            SizedBox(height: 200),
            ElevatedButton(
              onPressed: () {
                _scrollToElement();
              },
              child: Text('Перейти к элементу'),
            ),
            SizedBox(height: 800),
            Container(
              height: 200,
              color: Colors.blue,
              child: Center(
                child: Text(
                  'Целевой элемент',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _scrollToElement() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
