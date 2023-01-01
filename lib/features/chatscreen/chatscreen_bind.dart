import 'package:chatapp/features/chatscreen/chatscreen_cont.dart';
import 'package:get/get.dart';

class ChatScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ChatScreenController());
  }

}