import 'package:flutter/material.dart';

class Nutrition extends StatefulWidget {
  const Nutrition({super.key});

  @override
  State<Nutrition> createState() => _NutritionState();
}

class _NutritionState extends State<Nutrition> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.person),
          title: TextField(
            decoration: InputDecoration(
              hintText: "Name",
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: TextField(
            decoration: InputDecoration(
              hintText: "Phone",
            ),
          ),
        ),
      ],
    );
  }
}
