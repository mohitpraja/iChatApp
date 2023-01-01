import 'dart:developer';

import 'package:chatapp/core/global.dart';
import 'package:chatapp/core/model/chat_user.dart';
import 'package:chatapp/core/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    APIs.getUserInfo();
    super.onInit();
  }
  static const menuItems = <String>[
    'Theme',
    'Profile',
  ];
 
  final List<PopupMenuItem<String>> popUpMenuItems = menuItems
      .map(
        (String value) => PopupMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  List<ChatUser> users = [];
  RxList searchList =[].obs;
  RxBool isSearch = true.obs;

  search() {
    if (isSearch.value == true) {
      isSearch.value = false;
    } else {
      isSearch.value = true;
    }
  }

  createSearchList(value) {
    searchList.clear();
    for (var i in users) {
      if (
        i.name!.toLowerCase().contains(value.toLowerCase()) ||
          i.email!.toLowerCase().contains(value.toLowerCase())
          ) {
            log('$i');
            searchList.add(i);
          }
          
          
      
    }
    print(searchList);
  }
  forcheck(){
    log('${searchList[0]}');
  }

  gotoProfile() {
    Get.toNamed(Routes.profile, arguments: APIs.userInfo);
  }
  changeTheme(){
    Get.bottomSheet(
      SizedBox(
        height: 140,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.sunny),
              title: Text('Light Mode'),
              onTap:() {
                print('light mode');
               Get.changeTheme(ThemeData.light());
               Get.back();
              },
            ),
            ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text('Dark Mode'),
               onTap:() {
                print('dark mode');
               Get.changeTheme(ThemeData.dark());
               Get.back();
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
      
    );
  }
}
