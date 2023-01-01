import 'dart:developer';
import 'dart:io';
import 'package:chatapp/core/model/chat_user.dart';
import 'package:chatapp/core/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;

  static Future checkUser() async {
    return (await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .get())
        .exists;
  }

  static late ChatUser userInfo;

  //get user info
  static getUserInfo() async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get()
        .then((user) {
      if (user.exists){
        userInfo = ChatUser.fromJson(user.data()!);
        log('mydata:$userInfo');
      } else {
        createUser().then((value) => getUserInfo());
      }
    });
  }
  //create user
  static Future createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final user = ChatUser(
        id: auth.currentUser!.uid,
        name: auth.currentUser!.displayName,
        image: auth.currentUser!.photoURL,
        email: auth.currentUser!.email,
        about: "Hey!!! I'm using iChatApp",
        createdAt: time,
        isOnline: false,
        lastActive: time,
        pushToken: '');
    return await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set(user.toJson());
  }

  //update user
  static updateUser() async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({'name': userInfo.name, 'about': userInfo.about}).then(
            (_) => Get.snackbar('Success', 'Profile Updated'));
  }

  //upload image to server
  static uploadImage(File file) async {
    final ext = file.path.split('.').last;
    final ref = storage.ref().child('profiles/${auth.currentUser!.uid}.${ext}');
    ref.putFile(file).then((p0) {
      log('image status:${p0.bytesTransferred / 1000}');
    });
    log('${userInfo.image}');
    userInfo.image = await ref.getDownloadURL();
    log('${ref.getDownloadURL()}');
    log('${userInfo.image}');
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({'image': userInfo.image}).then(
            (_) => Get.snackbar('Success', 'Pic Uploaded Successfully'));
  }
  //for messages  
  //get conversation id  
  static getconversationId(id) => userInfo.id.hashCode <= id.hashCode
      ? '${userInfo.id}_$id'
      : '${id}_${userInfo.id}';
  //creating a stream
  static Stream<QuerySnapshot<Map<String, dynamic>>> getallMessage(
      ChatUser user) {
    return firestore
        .collection('chats/${getconversationId(user.id)}/messages/')
        .snapshots();
  }

  //sending a message
  static sendMessage(ChatUser user, String msg) async {
    print(user.name);
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final MessageModel message = MessageModel(
      fromId: userInfo.id,
      toId: user.id,
      msg: msg,
      type: 'text',
      read: '',
      sent: time,
    );
    await firestore
        .collection('chats/${getconversationId(user.id)}/messages/')
        .doc(time)
        .set(message.toJson());
  }
}
