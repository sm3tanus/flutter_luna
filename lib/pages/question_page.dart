import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  TextEditingController _messageController = TextEditingController();
  List<String> _messages = [];

  void _sendMessageToBot() async {
    String botToken = '7006358747:AAHhdCi_MM9iNCXhWSAJMlskcHBGFOwiPqg';
    String chatId = '682549448';

    String message = _messageController.text;

    String sendMessageUrl =
        'https://api.telegram.org/bot$botToken/sendMessage?chat_id=$chatId&text=$message';

    try {
      final sendMessageResponse = await http.get(Uri.parse(sendMessageUrl));

      if (sendMessageResponse.statusCode == 200) {
        setState(() {
          _messages.add('Вы: $message');
          _messageController.clear();
        });
      } else {
        setState(() {
          _messages.add(
              'Ошибка отправки сообщения: ${sendMessageResponse.reasonPhrase}');
        });
      }
    } catch (e) {
      setState(() {
        _messages.add('Произошла ошибка отправки: $e');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/');
                  },
                  icon: Icon(Icons.home, color: Colors.black,),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_messages[index]),
                  );
                },
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Введите сообщение',
                hintStyle: TextStyle(color: Colors.black),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Color(0xffff5d00),
                ),
                elevation:WidgetStatePropertyAll(0),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                ),
              ),
              onPressed: _sendMessageToBot,
              child: Text(
                'Отправить отзыв или пожелание',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                   ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
