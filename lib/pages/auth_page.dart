import 'package:flutter/material.dart';
import 'package:luna/dataBase/user_service/service.dart';
import 'package:toast/toast.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  AuthService authService = AuthService();
  bool visibility = false;

  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Text(
                  "L U N A",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 50),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xff171717),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextField(
                    cursorColor: Color(0xfff0f0f0),
                    style: TextStyle(
                        color: Color(0xfff0f0f0), fontWeight: FontWeight.w600),
                    controller: _emailController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      labelText: 'E-mail',
                      prefixIcon: Icon(Icons.email),
                      prefixIconColor: Color(0xfff0f0f0),
                      labelStyle: TextStyle(
                        fontSize: 14,
                        color: Color(0xfff0f0f0),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xff171717),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextField(
                    obscureText: !visibility,
                    style: TextStyle(
                        color: Color(0xfff0f0f0), fontWeight: FontWeight.w600),
                    cursorColor: Color(0xfff0f0f0),
                    controller: _passwordController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      labelText: 'Пароль',
                      suffixIcon: IconButton(
                          icon: !visibility
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              visibility = !visibility;
                            });
                          }),
                      suffixIconColor: Color(0xfff0f0f0),
                      prefixIcon: Icon(Icons.password),
                      prefixIconColor: Color(0xfff0f0f0),
                      labelStyle: TextStyle(
                        fontSize: 14,
                        color: Color(0xfff0f0f0),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_emailController.text.isEmpty ||
                          _passwordController.text.isEmpty) {
                        Toast.show("Заполните все поля!");
                      } else {
                        var user = await authService.signIn(
                            _emailController.text, _passwordController.text);
                        if (user == null) {
                          Toast.show('Такого пользователя не существует');
                        } else if (_emailController.text == 'admin@gmail.com' &&
                            _passwordController.text == 'adminadmin') {
                          Navigator.popAndPushNamed(context, '/cataloge');
                        } else {
                          Toast.show('Успешно');
                          Navigator.popAndPushNamed(context, '/');
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Color(0xffff5d00),
                      ),
                      elevation: WidgetStatePropertyAll(0),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    child: Text(
                      'ВОЙТИ',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(width: 36),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/registerPage');
                  },
                  child: Text(
                    'Создать аккаунт',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
