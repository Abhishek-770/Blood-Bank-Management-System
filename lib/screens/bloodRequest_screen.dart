import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';
import 'package:blood_bank/components/rounded_button.dart';

class BloodRequest extends StatefulWidget {
  const BloodRequest({Key? key}) : super(key: key);
  static String bloodRequest = 'bloodRequest_screen';
  @override
  _BloodRequestState createState() => _BloodRequestState();
}

class _BloodRequestState extends State<BloodRequest> {
  bool res = false;
  String ans = "";
  final bloodGroup = [
    'A+',
    'A-',
    'AB+',
    'AB-',
    'B+',
    'B-',
    'O+',
    'O-',
  ];
  String? value;
  DropdownMenuItem<String> buildMenuItem(String blood) => DropdownMenuItem(
      value: blood,
      child: Text(
        blood,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ));
  Future<bool> f() async {
    print(value);
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Blood_Collection').get();
    Map<dynamic, dynamic> m = {};
// int length=snapshot.docs.length;

    for (var doc in snapshot.docs) {
      m = doc.data() as Map;
      print(doc.data());
    }

    if (m[value] > 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.redAccent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Request Blood"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black),
              ),
              child: DropdownButton<String>(
                value: value,
                iconSize: 36,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                items: bloodGroup.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() {
                  this.value = value;
                }),
                hint: const Text(
                  'select',
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            RoundedButton(
                title: "Request",
                colour: Colors.blueAccent,
                onPressed: () async {
                  res = await f();

                  if (res == true) {
                    ans =
                        "available,you can collect it from our nearest center";
                  } else {
                    ans = "Please try later";
                  }
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Showing result of your request"),
                        content: Text(ans.toString()),
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
