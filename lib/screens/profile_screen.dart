import 'package:blood_bank/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';
import 'package:blood_bank/components/rounded_button.dart';
import 'package:blood_bank/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profilescreen extends StatefulWidget {
  static String profileId = 'profile_screen.dart';

  @override
  _ProfilescreenState createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController bloodGroupController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  void save() {
    String name = nameController.text.trim();
    String age = ageController.text.trim();
    String location = locationController.text.trim();
    String bloodGroup = bloodGroupController.text.trim();
    String phoneNumber = phoneNumberController.text.trim();
    String email = "";
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      email = user?.email ?? '';
      log(email);
    }
    nameController.clear();
    ageController.clear();
    locationController.clear();
    bloodGroupController.clear();
    phoneNumberController.clear();

    if (name != "" &&
        age != "" &&
        location != "" &&
        bloodGroup != "" &&
        phoneNumber != "") {
      Map<String, dynamic> user = {
        "name": name,
        "age": age,
        "location": location,
        "bloodGroup": bloodGroup,
        "phoneNumber": phoneNumber,
        "email": email
      };
      FirebaseFirestore.instance.collection("users").add(user);
      log("user created");

      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (context) => LoginScreen()));
    } else {
      log("Please fill all the details");
    }
  }

  late String name, age, location, bloodGroup;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.redAccent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Create Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ProfileMaker(
              controller: nameController,
              detail: 'Enter Your Name Here',
            ),
            ProfileMaker(
              controller: ageController,
              detail: 'Enter Your Age Here',
            ),
            ProfileMaker(
              controller: locationController,
              detail: 'Enter Your District Here',
            ),
            ProfileMaker(
              controller: bloodGroupController,
              detail: 'Enter Your Blood_Group Here',
            ),
            ProfileMaker(
              controller: phoneNumberController,
              detail: 'Enter Your Phone_Number Here',
            ),
            Flexible(
              child: RoundedButton(
                  title: "SAVE",
                  colour: Colors.blueAccent,
                  onPressed: () {
                    save();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileMaker extends StatelessWidget {
  const ProfileMaker({
    Key? key,
    required this.controller,
    required this.detail,
  }) : super(key: key);

  final TextEditingController controller;
  final String detail;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.emailAddress,
      decoration: kTextFileDecoration.copyWith(hintText: detail),
    );
  }
}
