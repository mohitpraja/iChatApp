import 'package:chatapp/features/home/home_cont.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(HomeController());
  }

}