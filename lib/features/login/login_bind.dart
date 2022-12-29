import 'package:chatapp/features/login/login_cont.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(LoginController());
  }

}