import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:safina/pages/homePage.dart';
import 'package:safina/pages/loginPage.dart';
import 'package:safina/pages/registerPage.dart';

import '../screens/homeScreen.dart';

class Routes {
  static final List<GetPage> routes = [
    GetPage(name: '/login', page: () => LoginPage()),
    GetPage(name: '/register', page: () => RegisterPage()),
    GetPage(name: '/home', page: () => HomePage()),
  ];
}