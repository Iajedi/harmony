import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Card(
      shadowColor: Colors.transparent,
      margin: EdgeInsets.all(30.0),
      child: SizedBox.expand(
        child: Center(
            child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Your Card',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Image(
              image: NetworkImage(
                  "https://www.cognex.com/BarcodeGenerator/Content/images/isbn.png"),
            )
          ],
        )),
      ),
    );
  }
}
