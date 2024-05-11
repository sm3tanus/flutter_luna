import 'package:luna/pages/auth_page.dart';
import 'package:luna/pages/cataloge_page.dart';
import 'package:luna/pages/landing.dart';
import 'package:luna/pages/recycle_bin.dart';
import 'package:luna/pages/reg_page.dart';
import 'package:luna/pages/sale_page.dart';

final routes = {
  '/': (context) => LandingPage(),
  '/authPage': (context) => AuthPage(),
  '/registerPage': (context) => RegPage(),
  '/cataloge': (context) => CatalogePage(),
  '/recycle': (context) => RecycleBinPage(),
  '/sale': (context) => SalePage(),
};
