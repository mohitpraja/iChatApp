import 'package:chatapp/core/model/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  static Future checkUser() async {
    return (await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .get())
        .exists;
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
}
