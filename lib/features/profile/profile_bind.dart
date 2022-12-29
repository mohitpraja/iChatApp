import 'package:chatapp/features/profile/profile_cont.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ProfileController());
  }

}