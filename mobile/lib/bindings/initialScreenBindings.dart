import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialScreenBindings implements Bindings {

  InitialScreenBindings();

  @override
  void dependencies() {
    // Get.put(() => SharedPreferences());
  }
}