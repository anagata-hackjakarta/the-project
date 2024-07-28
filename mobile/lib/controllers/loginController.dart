import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:safina/config/them.dart';
import 'package:safina/model/loginRequestModel.dart';
import 'package:safina/model/registerResponseModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

import '../model/registerRequestModel.dart';
import '../services/Service.dart';

class LoginController extends GetxController {
  final box = GetStorage();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  UserCredential? user;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController vehicleTypeController = TextEditingController();
  TextEditingController vehicleCapacityController = TextEditingController();
  TextEditingController vehicleYearProductionController = TextEditingController();

  List<String> vehicleTypeList = [
    "Honda Beat",
    "Yamaha Mio",
    "Honda Vario",
    "Toyota Avanza",
    "Daihatsu Xenia",
    "Honda Jazz",
    "Yamaha NMAX"
  ];

  List<int> vehicleYears = [
    2020,
    2018,
    2021,
    2017,
    2016,
    2015,
  ];

  List<int> vehicleCapacities = [
    110,
    125,
    1500,
    1300,
    155
  ];



  @override
  void onReady() {
    // TODO: implement onReady
    // check login
    checkLogin();
    super.onReady();
  }

  checkLogin() async {
    print("check login");
    String uuid = box.read("uid");
    print(uuid);
    if (uuid != null) {
      Get.offAllNamed("/home");
    }
  }

  loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final login =
          await FirebaseAuth.instance.signInWithCredential(credential);



      // check login api
      LoginRequestModel dataLogin = new LoginRequestModel(uuid: login.user?.uid);
      RegisterResponseModel reqLogin = await Services.doLogin(dataLogin);

      if(reqLogin.user == null) {
        user = login;
        Get.offAllNamed("/register");
      } else {
        box.write("uid", login.user?.uid);
        box.write("email", login.user?.email);
        box.write("display_name", login.user?.displayName);
        Get.toNamed("/home");
      }

    } catch (e) {
      throw (e);
    }
  }

  Future<void> logoutGoogle() async {
    await googleSignIn.signOut();
    box.remove("uid");
    box.remove("email");
    box.remove("display_name");
    Get.offAllNamed("/login");
  }

  Future<RegisterResponseModel> register() async {
    RegisterRequestModel requestRegisterModel = RegisterRequestModel();
    String? displayName = user?.user?.displayName;

    if (displayName != null && displayName.contains(" ")) {
      requestRegisterModel.firstName = displayName.split(" ")[0];
      requestRegisterModel.lastName = displayName.split(" ")[1];
    } else {
      // Handle the case where displayName is null or does not contain a space
      requestRegisterModel.firstName = displayName ?? "FirstName";
      requestRegisterModel.lastName = displayName ?? "Lastname";
    }

    requestRegisterModel.vehicleCapacity = int.tryParse(vehicleCapacityController.text) ?? 0;    requestRegisterModel.vehicleType = vehicleTypeController.text;
    requestRegisterModel.vehicleYearProduction = int.tryParse(vehicleYearProductionController.text) ?? 0;
    requestRegisterModel.vehicleType = vehicleTypeController.text;
    requestRegisterModel.uuid = user?.user?.uid;

    print(requestRegisterModel.toJson());

    RegisterResponseModel reqResgitser = await Services.doRegister(requestRegisterModel);

    if(reqResgitser.user == null){
      Get.snackbar(
        "Upps!",
        reqResgitser.message ?? "Error",
        colorText: Colors.white,
        backgroundColor: Colors.red.shade300,
        icon: const Icon(Icons.add_alert),
      );
    } else {
      box.write("uid", user?.user?.uid);
      box.write("email", user?.user?.email);
      box.write("display_name", user?.user?.displayName);
      Get.snackbar(
        "Success",
        "Register Success",
        colorText: Colors.white,
        backgroundColor: ThemeConfig.primaryColor,
        icon: const Icon(Icons.check_circle_outline),
      );
      Get.offAllNamed("/home");
    }

    return reqResgitser;
  }
}
