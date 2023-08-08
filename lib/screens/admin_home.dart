import 'package:blood_bank/screens/Donate_screen.dart';
import 'package:blood_bank/screens/admin_blood_screen.dart';
import 'package:blood_bank/screens/admin_manage_donor.dart';
import 'package:blood_bank/screens/bloodRequest_screen.dart';
import 'package:blood_bank/screens/user_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blood_bank/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});
  static String adminHomeId = 'AdminHome_screen';
  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.redAccent,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Admin Home Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RoundedButton(
              title: "Update Blood",
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, AdminBloodScreen.adminId);
              }),
          const SizedBox(
            height: 10.0,
          ),
          RoundedButton(
              title: "View Donors",
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, ManageDonor.mangeDonor);
              }),
        ],
      ),
    );
  }
}
// import 'package:blood_bank/screens/Donate_screen.dart';
// import 'package:blood_bank/screens/bloodRequest_screen.dart';
// import 'package:blood_bank/screens/user_screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:blood_bank/components/rounded_button.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// class HomeScreen extends StatefulWidget {

//   static String homeId='home_screen';
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.redAccent,
//       appBar: AppBar(
//      centerTitle: true,
//         title: Text('Home'),

//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children:<Widget>[
//          RoundedButton(title: "View Users", colour:Colors.lightBlueAccent, onPressed: (){
//             Navigator.pushNamed(context, UserScreen.userId);
//          }),

//           const SizedBox(
//             height: 10.0,
//           ),
//           RoundedButton(title: "Donate Blood", colour:Colors.lightBlueAccent, onPressed: (){
//               Navigator.pushNamed(context, DonateScreen.donateId);
//             }),

//           const SizedBox(
//             height: 10.0,
//           ),
//           RoundedButton(title: "Request Blood", colour:Colors.lightBlueAccent, onPressed: (){
//         Navigator.pushNamed(context, BloodRequest.bloodRequest);
//           }),
//         ],
//       ),


//     );
//   }
// }
