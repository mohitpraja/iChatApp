import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/core/global.dart';
import 'package:chatapp/core/model/chat_user.dart';
import 'package:chatapp/core/routes.dart';
import 'package:chatapp/features/home/home_cont.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.focusScope!.unfocus(),
      child: Obx(() => Scaffold(
            appBar: AppBar(
              title: controller.isSearch.value
                  ? Text('iChatApp')
                  : TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search by name or email...',
                      ),
                      autofocus: true,
                      onChanged: (value) => controller.createSearchList(value),
                    ),
              titleTextStyle: TextStyle(color: Colors.black, fontSize: 16.5),
              leading: Icon(
                CupertinoIcons.home,
                color: Colors.black,
              ),
              backgroundColor: Colors.blueGrey[200],
              elevation: 0.2,
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      controller.search();
                    },
                    icon: controller.isSearch.value
                        ? Icon(Icons.search)
                        : Icon(Icons.close),
                    color: Colors.black),
                  PopupMenuButton(
                    icon: Icon(Icons.more_vert,color: Colors.black,),
                    itemBuilder: (context) => controller.popUpMenuItems,
                    onSelected: (value) {
                      if(value=='Profile'){
                        controller.gotoProfile();
                      }else{
                        controller.changeTheme();
                        log('theme clicked');
                      }
                    },
                  )

              ],
            ),
            //app ended
            body: StreamBuilder(
              stream: APIs.firestore
                  .collection('users')
                  .where('id', isNotEqualTo: APIs.auth.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data?.docs;
                  controller.users =
                      data!.map((e) => ChatUser.fromJson(e.data())).toList();
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.pink,
                    color: Colors.amber,
                  ));
                }
                if (controller.users.isEmpty) {
                  return Center(child: Text('No users found'));
                } else {
                  return ListView.builder(
                    itemCount: controller.isSearch.value
                        ? controller.users.length
                        : controller.searchList.length,
                    padding: EdgeInsets.only(top: 4),
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 0.5,
                        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(Routes.chatscreen,arguments: controller.users[index]);
                          },
                          child: ListTile(
                            title: Text(
                              controller.isSearch.value
                                  ? controller.users[index].name.toString()
                                  : controller.searchList[index].name.toString(),
                              style: TextStyle(fontSize: 17),
                            ),
                            subtitle: Text(
                              controller.isSearch.value
                                  ? controller.users[index].about.toString()
                                  : controller.searchList[index].about.toString(),
                              maxLines: 1,
                              style: TextStyle(fontSize: 14),
                            ),
                            leading:  ClipRRect(
                                  borderRadius: BorderRadius.circular(75),
                                  child: CachedNetworkImage(
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    imageUrl:  controller.isSearch.value
                                    ? controller.users[index].image.toString()
                                    : controller.searchList[index].image.toString(),
                                    errorWidget: (context, url, error) =>
                                        CircleAvatar(
                                            backgroundColor: Colors.blueGrey,
                                            child: Icon(
                                              Icons.person,
                                              size:35,
                                              color: Colors.white,
                                            )),
                                  ),
                                ),

                            // leading: CircleAvatar(
                            //   radius: 25,
                            //   backgroundImage: NetworkImage(
                            //     // controller.users[index].image.toString()
                            //     controller.isSearch.value
                            //         ? controller.users[index].image.toString()
                            //         : controller.searchList[index].image.toString(),
                            //   ),
                            // ),
                            trailing: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blueGrey[400]),
                            ),
                            // trailing: Text('12:00',style: TextStyle(color: Colors.grey),),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                controller.forcheck();
              },
              child: Icon(Icons.message),
            ),
          )),
    );
  }
}
