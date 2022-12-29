import 'package:flutter/material.dart';

class Loader{
  static void showLoader(BuildContext context){
    showDialog(context: context, builder: (_) => Center(child: CircularProgressIndicator(
      color: Colors.amber,
      backgroundColor:Colors.pink,
    )),);
  }
}