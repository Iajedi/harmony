import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ichack24/auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User user = Auth().currentUser!;
  final db = FirebaseFirestore.instance;
  int membershipNo = 0;

  Future<void> _fetchUserData() async {
    final userRef = db.collection("users").doc(user.uid);
    final doc = await userRef.get();
    final data = doc.data()!;

    setState(() {
      membershipNo = data["membership_no"];
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.all(30.0),
      child: SizedBox.expand(
        child: Center(
            child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Your Card',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            BarcodeWidget(
              data: membershipNo.toString(),
              barcode: Barcode.code128(),
            )
          ],
        )),
      ),
    );
  }
}
