import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/core/global.dart';
import 'package:chatapp/features/profile/profile_cont.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/loader.dart';
import '../../core/routes.dart';

class ProfilePage extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.focusScope!.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black54,
            onPressed: () => Get.back(),
          ),
          leadingWidth: 28,
          backgroundColor: Colors.blueGrey[200],
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.w400),
          elevation: 0.2,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: EdgeInsets.all(15),
              child: Column(
                children: [
                  SizedBox(
                    height: 110,
                  ),
                  Obx(() => Stack(
                        children: [
                          controller.imagePath.value != ''
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(75),
                                  child: Image.file(
                                    File(controller.imagePath.value),
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ))
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(75),
                                  child: CachedNetworkImage(
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                    imageUrl: controller.user.image.toString(),
                                    errorWidget: (context, url, error) =>
                                        CircleAvatar(
                                            backgroundColor: Colors.blueGrey,
                                            child: Icon(
                                              Icons.person,
                                              size: 80,
                                              color: Colors.white,
                                            )),
                                  ),
                                ),
                          Positioned(
                            bottom: 5,
                            right: -25,
                            child: MaterialButton(
                              onPressed: () {
                                controller.showBottomSheet();
                              },
                              shape: CircleBorder(),
                              color: Colors.blueGrey,
                              child: Icon(
                                CupertinoIcons.camera,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    controller.user.email.toString(),
                    style: TextStyle(
                        // color: Colors.black54,
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  Form(
                    key: controller.formkey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          initialValue: controller.user.name,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              prefixIcon: Icon(Icons.person)),
                          onSaved: (newValue) => APIs.userInfo.name = newValue,
                          validator: (value) =>
                              controller.isValid(value, 'Name Required'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          initialValue: controller.user.about,
                          style: TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              prefixIcon: Icon(CupertinoIcons.infinite)),
                          onSaved: (newValue) => APIs.userInfo.about = newValue,
                          validator: (value) =>
                              controller.isValid(value, 'About Required'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.edit),
                    label: Text('Update'),
                    onPressed: () {
                      controller.formkey.currentState!.save();
                      APIs.updateUser();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor:Colors.blueGrey),
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            Loader.showLoader(context);
            await FirebaseAuth.instance.signOut();
            await GoogleSignIn().signOut().then((_) {
              Navigator.pop(context);
              Get.offAllNamed(Routes.login);
            });
            var pref = await SharedPreferences.getInstance();
            await pref.setBool('islogin', false);
          },
          backgroundColor: Colors.blueGrey,
          label: Text('Logout'),
          icon: Icon(Icons.logout),
        ),
      ),
    );
  }
}
