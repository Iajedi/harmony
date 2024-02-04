import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int userid = 91817161; // hardcoded

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
            BarcodeWidget(data: userid.toString(), barcode: Barcode.code128())
          ],
        )),
      ),
    );
  }
}
