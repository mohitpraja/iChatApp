import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/core/global.dart';
import 'package:chatapp/core/model/message_model.dart';
import 'package:chatapp/features/chatscreen/chatscreen_cont.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreenPage extends GetView<ChatScreenController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.focusScope!.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[200],
          elevation: 0.2,
          titleSpacing: sqrt1_2,
          toolbarHeight: 62,
          leading: InkWell(
              onTap: () => Get.back(),
              child: Icon(
                Icons.arrow_back,
                color: Colors.black54,
              )),
          title: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(75),
                child: CachedNetworkImage(
                  width: 42,
                  height: 42,
                  fit: BoxFit.cover,
                  imageUrl: controller.chat_user.image,
                  errorWidget: (context, url, error) => CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      child: Icon(
                        Icons.person,
                        size: 35,
                        color: Colors.white,
                      )),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.chat_user.name,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16.5,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Last seen not available',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  )
                ],
              )
            ],
          ),
        ),
        body: Container(
          color: Colors.grey[200],
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: APIs.getallMessage(controller.chat_user),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!.docs;
                      controller.messages = data
                          .map((e) => MessageModel.fromJson(e.data()))
                          .toList();
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: Colors.amber,
                        backgroundColor: Colors.pink,
                      ));
                    }
                    if (controller.messages.isEmpty) {
                      return Center(
                          child: Text(
                        'Say Hii!!! 👋',
                        style: TextStyle(fontSize: 22, color: Colors.black54),
                      ));
                    }
                    return ListView.builder(
                      itemCount: controller.messages.length,
                      itemBuilder: (context, index) {
                        return controller
                            .messageBox(controller.messages[index]);
                      },
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 6, vertical: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 2,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            children: [
                              Icon(
                                Icons.emoji_emotions_outlined,
                                color: Colors.blueGrey,
                                size: 30,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintText: 'Type Something ....',
                                      border: InputBorder.none),
                                  controller: controller.msg,
                                  style: TextStyle(color: Colors.black54),
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.attach_file,
                                color: Colors.blueGrey,
                                size: 25,
                              ),
                              Icon(
                                Icons.photo,
                                color: Colors.blueGrey,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    MaterialButton(
                      minWidth: 45,
                      padding: EdgeInsets.all(8),
                      onPressed: () {
                        if (!(controller.msg.text == '')) {
                          APIs.sendMessage(
                              controller.chat_user, controller.msg.text);
                          controller.msg.text = '';
                        }
                      },
                      color: Colors.blueGrey,
                      shape: CircleBorder(),
                      child: Icon(
                        Icons.send,
                        size: 23,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
