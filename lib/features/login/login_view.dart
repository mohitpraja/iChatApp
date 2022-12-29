import 'package:chatapp/features/login/login_cont.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/icon.png',width: 150,),
            SizedBox(height: 35,),
            SizedBox(
              width: Get.width*.7,
              height: 40,
              child: ElevatedButton(
                style:ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: StadiumBorder(),
                  backgroundColor: Colors.blueGrey.shade100
                ),
                child: Text('Login',style: TextStyle(color: Colors.black),),
                onPressed: () {
                  
                },
              ),
            ),
            SizedBox(height:15,),
            SizedBox(
              width: Get.width*.7,
              height: 40,
              child: ElevatedButton.icon(
                icon: Image.asset('assets/images/google.png',width:30,),
                style:ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: StadiumBorder(),
                  backgroundColor: Colors.blueGrey.shade100
                ),
                label: Text('Signin with Google',style: TextStyle(color: Colors.black),),
                onPressed: () {
                  controller.googleSignIn(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
