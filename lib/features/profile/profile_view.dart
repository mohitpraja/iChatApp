import 'package:cached_network_image/cached_network_image.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          color: Colors.black54,
          onPressed: () => Get.back(),
        ),
        leadingWidth: 28,
        backgroundColor: Colors.blueGrey[200],
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 17, fontWeight: FontWeight.w400),
        elevation: 0.2,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(75),
                    child: CachedNetworkImage(
                      width: 115,
                      height: 115,
                      fit: BoxFit.contain,
                      imageUrl: controller.user[1].image,
                      errorWidget: (context, url, error) => CircleAvatar(
                          backgroundColor: Colors.blueGrey,
                          child: Icon(
                            Icons.person,
                            size: 80,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  Positioned(
                    bottom:5,
                    right:-25,
                    child: MaterialButton(
                      onPressed: () {
                        controller.showBottomSheet();
                      },
                      shape:CircleBorder(),
                      color: Colors.blueGrey,
                      child:Icon(CupertinoIcons.camera,size: 20,color: Colors.white,),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                controller.user[0].email,
                style: TextStyle(
                    color: Colors.black54,
                    fontStyle: FontStyle.italic,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 30,),
              TextFormField(
                initialValue: controller.user[0].name,
                style: TextStyle(fontSize:15),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  prefixIcon:Icon(Icons.person)
                ),
              ),
              SizedBox(height: 15,),
              TextFormField(
                initialValue: controller.user[0].about,
                style: TextStyle(fontSize:16),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)

                  ),
                  prefixIcon:Icon(CupertinoIcons.infinite)
                ),
              ),
              SizedBox(height: 18,),
              ElevatedButton.icon(
                icon: Icon(Icons.edit),
                label: Text('Update'),
                onPressed: () {
                  
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
           Loader.showLoader(context);
          await FirebaseAuth.instance.signOut();
          await GoogleSignIn().signOut().then((_) {
            Navigator.pop(context);
            Get.offAllNamed(Routes.login);});
          var pref = await SharedPreferences.getInstance();
            await pref.setBool('islogin', false);
          
        },
        backgroundColor: Colors.blue,
        label: Text('Logout'),
        icon: Icon(Icons.logout),
      ),
    );
  }
}
