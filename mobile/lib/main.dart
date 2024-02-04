import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ichack24/auth.dart';
import 'package:ichack24/farm.dart';
import 'package:ichack24/home.dart';
import 'package:ichack24/login.dart';
import 'package:ichack24/nutrition.dart';
import 'package:ichack24/settings.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(66, 187, 147, 100)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Shopping'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int userid = 91817161; // hardcoded
  int currentPageIndex = 0;
  static const IconData roastChicken =
      IconData(0xea84, fontFamily: 'Chicken', fontPackage: null);

  Widget _navBar() {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
        });
      },
      indicatorColor: Theme.of(context).colorScheme.inversePrimary,
      selectedIndex: currentPageIndex,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(roastChicken),
          label: 'Farm',
        ),
        NavigationDestination(
          icon: Icon(Icons.food_bank),
          label: 'Nutrition',
        ),
        NavigationDestination(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }

  Widget _mainContent() {
    return <Widget>[
      const Home(),
      const Farm(),
      const Nutrition(),
      const SettingsPage()
    ][currentPageIndex];
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: Text(widget.title),
            ),
            bottomNavigationBar: (snapshot.hasData) ? _navBar() : null,
            body: (snapshot.hasData) ? _mainContent() : const Login(),
          );
        });
  }
}
