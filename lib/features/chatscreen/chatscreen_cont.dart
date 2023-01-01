import 'package:chatapp/core/global.dart';
import 'package:chatapp/core/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreenController extends GetxController {
  var chat_user = Get.arguments;
  List<MessageModel> messages = [];
  TextEditingController msg=TextEditingController();

  messageBox(MessageModel msg) {
    return msg.fromId == APIs.userInfo.id ? greyMsg(msg) : whiteMsg(msg);
  }

   greyMsg(MessageModel msg) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Card(
            elevation:3,
            color: Colors.blueGrey[200],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              margin: EdgeInsets.symmetric(vertical:6, horizontal: 8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Row(
                  children: [
                    Text(
                      msg.msg.toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(2,15,0,0),
                      child: Row(
                        children: [
                          Text(
                            '12:00',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 11,
                            ),
                          ),
                          SizedBox(width: 4,),
                          Icon(Icons.done_all,size: 18,)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

 whiteMsg(MessageModel msg) {
    return Container(
      margin: EdgeInsets.symmetric(vertical:5,horizontal: 5),
      child: Row(
        children: [
          Card(
            elevation:2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical:6, horizontal: 8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Row(
                  children: [
                    Text(
                      msg.msg.toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(2,15,0,0),
                      child: Row(
                        children: [
                          Text(
                            '12:00',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 11,
                            ),
                          ),
                          SizedBox(width: 4,),
                          Icon(Icons.done_all,size: 18,)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
