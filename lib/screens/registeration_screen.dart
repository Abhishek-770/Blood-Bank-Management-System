import 'package:blood_bank/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blood_bank/components/rounded_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';
import 'package:blood_bank/constants.dart';
class RegisterationScreen extends StatefulWidget {
  static String registerationsId='registeration_screen';

  @override
  _RegisterationScreenState createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
 late  String password,email;
 final _auth =FirebaseAuth.instance;
  TextEditingController passwordController=TextEditingController();
 TextEditingController emailController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.pinkAccent ,

      body: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Material(
           borderRadius: BorderRadius.circular(10.0),
            color: Colors.pinkAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
             const CircleAvatar(
               radius: 30.0,
               backgroundImage: AssetImage('images/user.png'),
             ),
                const SizedBox(
                  height: 30.0,
                ),
                TextField(
                  controller: emailController,
                  
                  textAlign:TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  decoration: kTextFileDecoration.copyWith(hintText: 'Register Using Email'),
                  onChanged: (value){
                    email=value;
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  textAlign:TextAlign.center,
                  decoration: kTextFileDecoration.copyWith(hintText: 'Set Password'),
                  onChanged: (value){
                    password=value;
                  },

                ),
                RoundedButton(title: "Register",
                    colour: Colors.blueAccent, onPressed : () async{
                      try {

                        await _auth.createUserWithEmailAndPassword(
                            email: email, password: password);
                      Navigator.pushNamed(context, Profilescreen.profileId);

                      }

                      on  FirebaseAuthException catch (ex){
                        log(ex.code.toString());
                      }
                    }),
              ],
            ),
          ),

      ),
    );
  }
}
