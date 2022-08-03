import 'package:blood_bank/constants.dart';
import 'package:blood_bank/screens/admin_screen.dart';
import 'package:blood_bank/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:blood_bank/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:blood_bank/constants.dart';

class LoginScreen extends StatefulWidget {
  static String loginsId='login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // late String email,password;

  TextEditingController passwordController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  void login()async{
    String email=emailController.text.trim();
    String password=passwordController.text.trim();

    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      if(userCredential.user!=null){
          Navigator.popUntil(context, (route) =>route.isFirst );
        if(email=="iib2020018@gmail.com"){

          Navigator.pushReplacement(context,CupertinoPageRoute(builder: (context)=>AdminScreen()));

        }
       else {
          Navigator.pushReplacement(context,CupertinoPageRoute(builder: (context)=>HomeScreen()));

        }

      }

    }
    on FirebaseAuthException catch(e){

      if(e.code=='user-not-found'){

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      }
      else if(e.code=='wrong-password'){

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      }
      else{
        log(e.code);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.redAccent,

      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
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
              decoration: kTextFileDecoration.copyWith(hintText: 'Login Using Email'),
              // onChanged: (value){
              //   email=value;
              // },
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              textAlign:TextAlign.center,
              decoration: kTextFileDecoration.copyWith(hintText: 'Enter Password'),


            ),
            RoundedButton(title: "Login",
                colour: Colors.blueAccent, onPressed :(){
              login();
                }),
          ],
        ),

      ),
    );
  }
}
