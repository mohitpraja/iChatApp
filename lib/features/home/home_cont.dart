import 'package:chatapp/core/model/chat_user.dart';
import 'package:chatapp/core/routes.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  List<ChatUser> users=[];
  gotoProfile(){
    Get.toNamed(Routes.profile,arguments: users);
  }
  
}