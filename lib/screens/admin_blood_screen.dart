import 'package:flutter/material.dart';
import 'package:blood_bank/components/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminBloodScreen extends StatefulWidget {
  static String adminId = 'admin_screen';
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminBloodScreen> {
  final TextEditingController oPosController = TextEditingController();
  final TextEditingController oNegController = TextEditingController();
  final TextEditingController bPosController = TextEditingController();
  final TextEditingController bNegController = TextEditingController();
  final TextEditingController abPosController = TextEditingController();
  final TextEditingController abNegController = TextEditingController();
  final TextEditingController aPosController = TextEditingController();
  final TextEditingController aNegController = TextEditingController();
  void update() {
    int oPos = int.parse(oPosController.text.trim());
    int oNeg = int.parse(oNegController.text.trim());
    int bPos = int.parse(bPosController.text.trim());
    int bNeg = int.parse(bNegController.text.trim());
    int abPos = int.parse(abPosController.text.trim());
    int abNeg = int.parse(abNegController.text.trim());
    int aPos = int.parse(aPosController.text.trim());
    int aNeg = int.parse(aNegController.text.trim());

    FirebaseFirestore.instance
        .collection('Blood_Collection')
        .doc('document_id')
        .update({
      'A+': aPos,
      'A-': aNeg,
      'AB+': abPos,
      'AB-': abNeg,
      'B+': bPos,
      'B-': bNeg,
      'O+': oPos,
      'O-': oNeg
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.redAccent,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Available Blood In Blood Bank',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            blood_updater(
                controller: aPosController, detail: "units of A+ blood"),
            blood_updater(
              controller: aNegController,
              detail: "units of A- blood",
            ),
            blood_updater(
              controller: abPosController,
              detail: "units of AB+ blood",
            ),
            blood_updater(
              controller: abNegController,
              detail: "units of AB- blood",
            ),
            blood_updater(
              controller: bPosController,
              detail: "units of B+ blood",
            ),
            blood_updater(
              controller: bNegController,
              detail: "units of B- blood",
            ),
            blood_updater(
              controller: oPosController,
              detail: "units of O+ blood",
            ),
            blood_updater(
              controller: oNegController,
              detail: "units of O- blood",
            ),
            RoundedButton(
                title: "SAVE",
                colour: Colors.blueAccent,
                onPressed: () {
                  update();
                }),
          ],
        ),
      ),
    );
  }
}

class blood_updater extends StatelessWidget {
  const blood_updater({
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
      decoration: InputDecoration(
        hintText: detail,
        hintStyle: const TextStyle(
          color: Colors.black26,
        ),
      ),
    );
  }
}
