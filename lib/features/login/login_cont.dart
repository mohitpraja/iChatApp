import 'dart:developer';
import 'package:chatapp/components/loader.dart';
import 'package:chatapp/core/global.dart';
import 'package:chatapp/core/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
 
  bool isInternet = true;
  googleSignIn(context) async {
    if (await InternetConnectionChecker().hasConnection) {
      Loader.showLoader(context);
      _signInWithGoogle().then((user) async {
        Navigator.pop(context);
        if ((await APIs.checkUser())) {
          log('user:${user.user}');
          var pref = await SharedPreferences.getInstance();
          await pref.setBool('islogin', true);
          log('add info:${user.additionalUserInfo}');
          Get.offAllNamed(Routes.home);
        } else {
          await APIs.createUser()
              .then((value) => Get.offAllNamed(Routes.home));
          var pref = await SharedPreferences.getInstance();
          await pref.setBool('islogin', true);
        }
      });
    } else {
      Get.defaultDialog(
          title: 'Alert', content: Text('Check Internet Connection'));
    }
  }

  Future<UserCredential> _signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> logout() async {
    await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
  }
 
}
