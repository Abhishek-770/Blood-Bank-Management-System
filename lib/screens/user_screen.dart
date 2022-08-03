import 'package:blood_bank/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class UserScreen extends StatefulWidget {

  static String userId='user_screen';

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List colors = [Colors.red, Colors.yellow,Colors.blue, Colors.green];
  Future<void> launchPhoneURL(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    leading: null,
    automaticallyImplyLeading: false,
    centerTitle: true,
    title: const Text(
      'Contact Users Directly',
    ),
  ),
      body:SafeArea(

     child: Column(
       children:[
         StreamBuilder<QuerySnapshot>(
           stream: FirebaseFirestore.instance.collection("users").snapshots(),
           builder: (context,snapshot){
             if(snapshot.connectionState==ConnectionState.active){
               if(snapshot.hasData && snapshot.data!=null){
                 return Expanded(
                   child: ListView.builder(

                     itemCount: snapshot.data!.docs.length,

                     itemBuilder: (context,index){
                       Map<String,dynamic>userMap=snapshot.data!.docs[index].data() as Map<String,dynamic>;

                       return ListTile(
                   minVerticalPadding: 20.0,
                      // shape: CircleBor,
                    tileColor: colors[index % colors.length],
                         title: Column(
                           children:<Widget> [
                             Text(userMap["name"]),
                             Text(userMap["bloodGroup"]),
                             Text(userMap["location"])
                           ],

                         ),
                         trailing: IconButton(
                           icon: Icon(Icons.phone),
                           onPressed: (){
                             // String call="91${userMap["phoneNumber"]}";
                             FlutterPhoneDirectCaller.callNumber(userMap["phoneNumber"]);
                           },
                         ),
                         // subtitle:Text(userMap["location"]) ,
                       );
                     },

                   ),
                 );
               }

               else {
                 return
                   const Text(
                     'No Users Available',
                     style: TextStyle(
                       fontSize: 20.0,
                     ),
                   );
               }
             }
             else{
               return const Center(
                 child: CircularProgressIndicator(),
               );
             }
           },
         )
       ],

     ),
      ),
    );
  }
}
