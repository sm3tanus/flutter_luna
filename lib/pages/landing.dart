
import 'package:flutter/material.dart';
import 'package:luna/dataBase/user_service/getUser.dart';
import 'package:luna/pages/auth_page.dart';
import 'package:luna/pages/home.dart';



class LandingPage extends StatelessWidget {
  const LandingPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    bool check = false;
    getUser() != null ? check = true : check = false;
    return check? const HomePage(): const AuthPage();
  }
}