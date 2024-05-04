

import 'package:luna/pages/3d_model.dart';
import 'package:luna/pages/auth_page.dart';
import 'package:luna/pages/cataloge_page.dart';
import 'package:luna/pages/landing.dart';
import 'package:luna/pages/reg_page.dart';

final routes = {
  '/':(context) => LandingPage(),
  '/authPage': (context) => AuthPage(),
  '/registerPage': (context) => RegPage(),
  '/3d_model': (context) => Model3D(),
  '/cataloge': (context) => CatalogePage(),
};