import 'package:firebase_app/controllers/profile_controller.dart';
import 'package:firebase_app/controllers/login_controller.dart';
import 'package:get/get.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());

    Get.lazyPut<LoginController>(() => LoginController()); 
  }
}
