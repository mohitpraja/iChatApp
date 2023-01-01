import 'dart:io';
import 'package:chatapp/core/global.dart';
import 'package:chatapp/core/model/chat_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  
  ChatUser user = Get.arguments;
  RxString imagePath=''.obs;
  final ImagePicker picker=ImagePicker();
  showBottomSheet() {
    Get.bottomSheet(
      SizedBox(
        height: 150,
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Choose Profile Picture',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Column(
                    children: const [
                      Icon(
                        Icons.photo,
                        size: 30,
                        color: Colors.black54,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('Gallery'),
                    ],
                  ),
                  onTap: () {
                    choosePic(ImageSource.gallery);
                  },
                ),
                const SizedBox(
                  width: 60,
                ),
                InkWell(
                  child: Column(
                    children: const [
                      Icon(
                        Icons.camera,
                        size: 30,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('Camera')
                    ],
                  ),
                  onTap: () {
                    choosePic(ImageSource.camera);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

 final formkey=GlobalKey<FormState>();
 isValid(val,msg){
    if(val==null||val.isEmpty){
      return msg;
    }
    return null;

 }
  formValid(){
    if(formkey.currentState!.validate()){
      return true;
    }
  }
  choosePic(src) async {
   final XFile? img=await picker.pickImage(source:src,imageQuality: 80);
   if(img!=null){
    imagePath.value=img.path;
    APIs.uploadImage(File(imagePath.value));
    Get.back();
   }


  }
 
  
}
