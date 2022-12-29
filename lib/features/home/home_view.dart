import 'package:chatapp/core/global.dart';
import 'package:chatapp/core/model/chat_user.dart';
import 'package:chatapp/features/home/home_cont.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('iChatApp'),
        titleTextStyle: TextStyle(color: Colors.black,fontSize: 16.5),
        leading: Icon(CupertinoIcons.home,color: Colors.black,),
        backgroundColor: Colors.blueGrey[200],
        elevation: 0.2,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
            color: Colors.black
          ),
          IconButton(
            onPressed: () {
              controller.gotoProfile();
            },
            icon: Icon(Icons.more_vert),
            color: Colors.black
          ),
        ],
      ),
      //app ended
      body:StreamBuilder(
        stream: APIs.firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            final data=snapshot.data?.docs;
            controller.users=data!.map((e) => ChatUser.fromJson(e.data())).toList();
           
          }
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(
              backgroundColor:Colors.pink,
              color: Colors.amber,
            ));
          }
          if(controller.users.isEmpty){
            return Center(child: Text('No users found'));
          }else{
            return ListView.builder(
          itemCount:controller.users.length,
          padding: EdgeInsets.only(top: 4),
          physics:BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Card(
              elevation: 0.5,
              margin: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
              child: ListTile(
                title: Text(controller.users[index].name.toString(),style: TextStyle(fontSize: 17),),
                subtitle: Text(controller.users[index].about.toString(),maxLines: 1,style: TextStyle(fontSize: 14),),
                leading: CircleAvatar(
                  backgroundImage:NetworkImage(controller.users[index].image.toString()),),
                  trailing: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blueGrey[400]
                      
                    ),
                  ),
                // trailing: Text('12:00',style: TextStyle(color: Colors.grey),),
              ),
            );
          },
        );
          }
          
        },
      ),
      floatingActionButton: FloatingActionButton(
        
        onPressed: () async{
         
        },
        child: Icon(Icons.message),
      ),
    );
  }
}
