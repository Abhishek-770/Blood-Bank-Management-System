import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ManageDonor extends StatefulWidget {
  const ManageDonor({super.key});
  static String mangeDonor = 'admin_donor_screen';
  @override
  State<ManageDonor> createState() => _ManageDonorState();
}

class _ManageDonorState extends State<ManageDonor> {
  List colors = [Colors.red, Colors.yellow, Colors.blue, Colors.green];
  Future<void> launchPhoneURL(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  final CollectionReference _items =
      FirebaseFirestore.instance.collection('donor');
  // for delete operation
  Future<void> _delete(String productID) async {
    await _items.doc(productID).delete();

    // for snackBar
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Donor has Donated Blood")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Donors",
          style: TextStyle(),
        ),
      ),
      body: StreamBuilder(
        stream: _items.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                    color: const Color.fromARGB(255, 88, 136, 190),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 17,
                        backgroundColor: const Color.fromARGB(255, 26, 226, 76),
                        child: Text(
                          (index + 1).toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                      title: Text(
                        documentSnapshot['Name'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      subtitle: Text(documentSnapshot['date'].toString()),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                color: Colors.black,
                                onPressed: () => _delete(documentSnapshot.id),
                                icon: const Icon(Icons.delete)),
                            IconButton(
                              icon: Icon(Icons.phone),
                              onPressed: () {
                                // String call="91${userMap["phoneNumber"]}";
                                String phoneNumber =
                                    "+91" + documentSnapshot["phoneNumber"];
                                FlutterPhoneDirectCaller.callNumber(
                                    phoneNumber);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
