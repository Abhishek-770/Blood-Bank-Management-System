import 'package:blood_bank/screens/Donate_screen.dart';
import 'package:blood_bank/screens/admin_home.dart';
import 'package:blood_bank/screens/admin_manage_donor.dart';
import 'package:blood_bank/screens/admin_blood_screen.dart';
import 'package:blood_bank/screens/bloodRequest_screen.dart';
import 'package:blood_bank/screens/profile_screen.dart';
import 'package:blood_bank/screens/home_screen.dart';
import 'package:blood_bank/screens/user_screen.dart';
import 'package:blood_bank/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

import 'package:blood_bank/screens/login_screen.dart';
import 'package:blood_bank/screens/registeration_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BloodBank());
}
// Future<void> main() async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(BloodBank());
// }

class BloodBank extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.welcomes,
      routes: {
        WelcomeScreen.welcomes: (context) => WelcomeScreen(),
        LoginScreen.loginsId: (context) => LoginScreen(),
        RegisterationScreen.registerationsId: (context) =>
            RegisterationScreen(),
        Profilescreen.profileId: (context) => Profilescreen(),
        HomeScreen.homeId: (context) => HomeScreen(),
        UserScreen.userId: (context) => UserScreen(),
        DonateScreen.donateId: (context) => DonateScreen(),
        BloodRequest.bloodRequest: (context) => BloodRequest(),
        AdminBloodScreen.adminId: (context) => AdminBloodScreen(),
        AdminHome.adminHomeId: (context) => AdminHome(),
        ManageDonor.mangeDonor: (context) => ManageDonor(),
      },
    );
  }
}
