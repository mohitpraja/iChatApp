import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends GetView{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        color: Colors.blue.shade100,
        child: Center(
          child: Image.asset('assets/images/icon.png',width: 130,)),
      ),
    );
  }

}