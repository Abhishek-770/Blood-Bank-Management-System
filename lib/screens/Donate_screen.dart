import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blood_bank/components/rounded_button.dart';
import 'dart:developer';
import 'home_screen.dart';

class DonateScreen extends StatefulWidget {

  static String donateId='Donate_screen';
  @override
  _DonateScreenState createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  final TextEditingController locationController=TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2021),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
  void register(){
    String location=locationController.text.trim();
    String date =selectedDate.toString();
  if(date!=null && location!=null){
    Map<String,dynamic>donor={
      "date":date,
      "donor_location":location,

    };
    FirebaseFirestore.instance.collection("donor").add(donor);
    log("user created");
    // Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushNamed(context, HomeScreen.homeId);
  }
  else{
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.orangeAccent,
        content: Text(
          "Fill All The Details",
          style: TextStyle(fontSize: 18.0, color: Colors.black),
        ),
      ),
    );
  }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
         automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Donate Blood',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    body: Center(
      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        TextField(
        controller:locationController,
          textAlign:TextAlign.center,

        keyboardType: TextInputType.emailAddress,
        decoration:  const InputDecoration(
        hintText: 'Select District For Blood Donation',
          hintStyle: TextStyle(
            color: Colors.black54,
          ),
        ),



      ),
          const SizedBox(height: 20.0,),
          Text("${selectedDate.toLocal()}".split(' ')[0],
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w100,
              color: Colors.limeAccent,
            ),

          ),
          SizedBox(height: 70.0,
          width: 300,
            child:  ElevatedButton(
              style: ElevatedButton.styleFrom(

                  primary: Colors.blueAccent, //background color of button
                  side: const BorderSide(width:4, color:Colors.blueAccent), //border width and color
                  elevation: 3, //elevation of button
                  shape: RoundedRectangleBorder( //to set border radius to button
                      borderRadius: BorderRadius.circular(30)
                  ),
                  padding: EdgeInsets.all(20) //content padding inside button
              ),
              onPressed: () => _selectDate(context),
              child: const Text('Select Date',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),

              ),
            ) ,
          ),
         const SizedBox(
           height: 10.0,
         ),
          RoundedButton(title: "Register For Donation",
              colour: Colors.blueAccent, onPressed : () {
                register();

              }),
        ],

      ),
    ),

    );
  }
}
