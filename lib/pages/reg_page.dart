import 'package:flutter/material.dart';
import 'package:luna/dataBase/collections/users_collection.dart';
import 'package:luna/dataBase/user_service/service.dart';
import 'package:toast/toast.dart';

class RegPage extends StatefulWidget {
  const RegPage({super.key});

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordAcceptController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  UsersCollection usersCollection = UsersCollection();
  AuthService authService = AuthService();
  bool visibility = false;
  bool visibility2 = false;

  @override
  Widget build(BuildContext context) {
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
                  style: TextStyle(color: Colors.black, fontSize: 50),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xff859177),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextField(
                    cursorColor: Colors.black,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                    controller: emailController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      labelText: 'E-mail',
                      prefixIcon: Icon(Icons.email),
                      prefixIconColor: Colors.black,
                      labelStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xff859177),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextField(
                    cursorColor: Colors.black,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                    controller: nameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      labelText: 'Name',
                      prefixIcon: Icon(Icons.account_circle),
                      prefixIconColor: Colors.black,
                      labelStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xff859177),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextField(
                    cursorColor: Colors.black,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                    controller: passwordController,
                    obscureText: !visibility,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: IconButton(
                          icon: !visibility
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              visibility = !visibility;
                            });
                          }),
                      suffixIconColor: Colors.black,
                      prefixIconColor: Colors.black,
                      labelText: 'Пароль',
                      labelStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xff859177),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextField(
                    cursorColor: Colors.black,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                    controller: passwordAcceptController,
                    obscureText: !visibility,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      labelText: 'Повторите пароль',
                      suffixIcon: IconButton(
                          icon: !visibility2
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              visibility2 = !visibility2;
                            });
                          }),
                      suffixIconColor: Colors.black,
                      prefixIcon: Icon(Icons.password),
                      prefixIconColor: Colors.black,
                      labelStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (nameController.text.isEmpty ||
                          emailController.text.isEmpty ||
                          passwordAcceptController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        Toast.show('Заполните все поля');
                      } else {
                        if (passwordAcceptController.text ==
                            passwordController.text) {
                          var user = await authService.signUp(
                              emailController.text, passwordController.text);
                          if (user != null) {
                            await usersCollection.addUserCollection(
                                user.id!,
                                emailController.text,
                                nameController.text,
                                "",
                                passwordController.text);
                            Navigator.popAndPushNamed(context, '/');
                          } else {
                            Toast.show('Проверьте данные');
                          }
                        } else {
                          Toast.show('Пароли не совпадают');
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xff656e3d),
                      ),
                      elevation: MaterialStateProperty.all<double>(0),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all<Size>(
                        Size(250,
                            50),
                      ),
                    ),
                    child: Text(
                      'СОЗДАТЬ АККАУНТ',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                  child: Text(
                    'Есть аккаунт?',
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
