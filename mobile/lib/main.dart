import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:safina/pages/homePage.dart';
import 'package:safina/pages/loginPage.dart';
import 'package:safina/pages/registerPage.dart';
import 'package:safina/routes/mainRoute.dart';

import 'config/firebaseOptions.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);

  runApp(GetMaterialApp(
    initialRoute: '/login',
    getPages: Routes.routes,
    home: LoginPage(),
    debugShowCheckedModeBanner: false,
  ));
}
