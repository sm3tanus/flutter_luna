import 'package:luna/dataBase/user_service/model.dart';
import 'package:flutter/material.dart';
import 'package:luna/pages/auth_page.dart';
import 'package:luna/pages/home.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel? userModel = Provider.of<UserModel?>(context);
    final bool check = userModel != null;
    return check? const HomePage(): const AuthPage();
  }
}