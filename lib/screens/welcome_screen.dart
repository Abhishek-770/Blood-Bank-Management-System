import 'package:flutter/material.dart';
import 'package:blood_bank/screens/login_screen.dart';
import 'package:blood_bank/screens/registeration_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:blood_bank/components/rounded_button.dart';
class WelcomeScreen extends StatefulWidget {
  static String welcomes='welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment:,
      decoration: BoxDecoration(

        image: DecorationImage(
          image: const AssetImage('images/BloodDonate2.jpg'),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(Colors.red.withOpacity(0.6),
              BlendMode.darken,),
        ),

      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
     body: Padding(
         padding: EdgeInsets.symmetric(horizontal: 24.0),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RoundedButton(title: 'Log In',colour: Colors.lightGreen,onPressed: (){
            Navigator.pushNamed(context, LoginScreen.loginsId);
          },),
          RoundedButton(title: 'Register',colour: Colors.blueAccent,onPressed: (){
            Navigator.pushNamed(context, RegisterationScreen.registerationsId);
          },),
        ],
      ),

     ),
      ),

    );
  }
}
