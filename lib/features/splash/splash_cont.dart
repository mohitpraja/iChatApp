import 'dart:async';
import 'package:chatapp/core/routes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  bool isLogin = false;
  @override
  void onInit() {
    super.onInit();
    getdata();
    Timer(
      Duration(seconds: 2),
      () => isLogin == true
          ? Get.offAllNamed(Routes.home)
          : Get.offAllNamed(Routes.login),
    );
  }

  Future<void> getdata() async {
    print('get cld');
    var pref = await SharedPreferences.getInstance();
    isLogin = pref.getBool('islogin')!;
  }
}
