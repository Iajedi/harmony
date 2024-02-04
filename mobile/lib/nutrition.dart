import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:ichack24/auth.dart';
import 'dart:core';

class Nutrition extends StatefulWidget {
  const Nutrition({super.key});

  @override
  State<Nutrition> createState() => _NutritionState();
}

class _NutritionState extends State<Nutrition> with SingleTickerProviderStateMixin {
  List<TweenAnimationBuilder<double>> _animationBuilders = [];
  User user = Auth().currentUser!;
  final db = FirebaseFirestore.instance;

  late Map<String, dynamic> macros;
  final goals = calculateGoals();

  Future<void> _fetchUserData() async {
    final userRef = db.collection("users").doc(user.uid);
    final doc = await userRef.get();
    final data = doc.data()!;

    setState(() {
      macros = data['nutritionData'];
      for(final entry in macros.entries) {
        print(entry.key);
        final ratio = entry.value / goals[entry.key];
        var animationBuilder = TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 2500),
          curve: Curves.easeInOutQuart,
          tween: Tween<double>(
              begin: 0,
              end: ratio,
          ),
          builder: (context, value, _) =>
              _buildProgressBar(entry.key, value),
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
  Widget _buildProgressBar(String macro, value) {
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
              percent: value > 1.0 ? 1.0 : value,
              backgroundColor: Colors.grey[300],
              center: Text(
                (value*100).toStringAsFixed(1) + "%",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              progressColor: getColor(value),
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

  Color getColor(double value) {
    if (value > 2.0) {
      return Color.fromRGBO(0, 0, 0, 100);
    } else if (value > 1.0) {
      return Color.fromRGBO((-1000*(value-1)*(value-2)).round(), 
                            (255*(1-(1-value).abs())).round(), 0, 100);
    } else {
      return Color.fromRGBO((255*(1-value)).round(), (255*value).round(), 
                                  0, 100);
    }
    
  }

}

calculateGoals() {
  return <String, double> {
    "protein": 147*7,
    "carbohydrates": 321*7,
    "fat": 68*7,
    "calories": 2408*7
  };
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}