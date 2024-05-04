import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:luna/dataBase/user_service/service.dart';
import 'package:luna/routes/routes.dart';
import 'package:luna/themes/dark.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAJmMihMJ5cOrlCIQJPS5wLLs5LGeETXgE",
      appId: "1:463184157208:android:e471660c4c00687a91816d",
      messagingSenderId: "463184157208",
      projectId: "luna-a728b",
      storageBucket: "luna-a728b.appspot.com",
    ),
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    
    ToastContext().init(context);
    
    return StreamProvider.value(
      initialData: null,
      value: AuthService().currentUser,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: routes,
        initialRoute: '/',
        theme: themeData,
      ),
    );
  }
}