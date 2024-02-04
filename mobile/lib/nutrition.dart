import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Nutrition extends StatefulWidget {
  const Nutrition({super.key});

  @override
  State<Nutrition> createState() => _NutritionState();
}

class _NutritionState extends State<Nutrition> with SingleTickerProviderStateMixin {
  List<TweenAnimationBuilder<double>> _animationBuilders = [];
  final db = FirebaseFirestore.instance;

  late Map<String, dynamic> macros;
  late double goal = 500.0;

  Future<void> _fetchUserData() async {
    final userRef = db.collection("users").doc("91817161");
    final doc = await userRef.get();
    final data = doc.data() as Map<String, dynamic>;

    setState(() {
      macros = data['nutritionData'];
      for(final entry in macros.entries) {
        var animationBuilder = TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 1500),
          curve: Curves.easeInOutExpo,
          tween: Tween<double>(
              begin: 0,
              end: entry.value / goal,
          ),
          builder: (context, value, _) =>
              _buildProgressBar(entry.key, Colors.green, value),
        );
        _animationBuilders.add(animationBuilder);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tmp = [_buildHeader("Weekly stats")];
    if(!_animationBuilders.isEmpty) {
      tmp.add(_animationBuilders.first);
    }
    for (final ab in _animationBuilders.skip(1)) {
      tmp.add(SizedBox(height: 10));
      tmp.add(ab);  
    }
    return Card(
      margin: EdgeInsets.all(15.0),
      child: Column(
        children: tmp
      ),
     );
  }
  Widget _buildProgressBar(String macro, Color color, value) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(child: Text(macro.capitalize(), 
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.w700,
              ))
            ),
            Expanded(child: LinearPercentIndicator(
              percent: value,
              backgroundColor: Colors.grey[300],
              center: Text(
                (value*100).toStringAsFixed(1) + "%",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              progressColor: Colors.greenAccent,
              barRadius: const Radius.circular(16),
              //valueColor: AlwaysStoppedAnimation<Color>(color),
              lineHeight: 60, 
              
            )),
          ]
        )
      )
     
    );
  }

  Widget _buildHeader(String header) {
    return Text(header, style: TextStyle(fontSize:40, fontWeight: FontWeight.bold));
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}