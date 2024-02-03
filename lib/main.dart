import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Harmony'),
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
  static const IconData roastChicken = IconData(0xea84, fontFamily: 'Chicken', fontPackage: null);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            if(!(currentPageIndex == index && currentPageIndex == 3)) {
              _isEditing = false;
            }
            if(index == 3) {
              var user = getData();
              _ageController.text = "hello";
            }
            currentPageIndex = index;
            
          });
        },
        indicatorColor: Colors.amber,
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
            label: 'Settingss',
          ),
        ],
      ),

      body: <Widget>[
        const Card(
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
                    image: NetworkImage("https://www.cognex.com/BarcodeGenerator/Content/images/isbn.png"),
                  )
                ],
              )
            ),
          ),
        ),        

       const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 1'),
                  subtitle: Text('This is a notification'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 2'),
                  subtitle: Text('This is a notification'),
                ),
              ),
            ],
          ),
        ),

        /// farm page
        const Column(
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
        ),


        /// Nutrition page
      
        /// Settings page
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileField("Name", _nameController),
              SizedBox(height: 24),
              _buildProfileField("Age", _ageController),
              SizedBox(height: 24),
              _buildProfileField("Weight", _weightController),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isEditing = !_isEditing;
                  });
                },
                child: Text(_isEditing ? 'Save Profile' : 'Edit Profile'),
              ),
            ],
          ),
        )
        /// end settings page
      ][currentPageIndex],
    );
  }

  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  bool _isEditing = false;

  Widget _buildProfileField(String label, TextEditingController controller) {
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _isEditing ? [
        Expanded(
          child: _buildEditableTextField(label, controller)
        ),
      ] : [
        Expanded(
          child: Text(
          '$label: ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        ),
        Expanded(
          child: _buildReadOnlyTextField(controller),
        )
      ]
    );
  }

  Widget _buildEditableTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: controller.text.isEmpty ? 'Enter your $label' : controller.text,
        border: OutlineInputBorder(),
      ),
      style: TextStyle(fontSize: 15),
      textCapitalization: TextCapitalization.words,
    );
  }

  Widget _buildReadOnlyTextField(TextEditingController controller) {
    FontWeight weight = controller.text.isEmpty ? FontWeight.w100 : FontWeight.normal;
    return Text(
      controller.text.isEmpty ? 'Empty' : controller.text,
      style: TextStyle(fontSize: 20, fontWeight: weight),
    );
  }

  getData() async {
    var db = FirebaseFirestore.instance;  
    final docRef = db.collection("users").doc("SF");
    return docRef.get();
  }

  writeData() async {
    var db = FirebaseFirestore.instance;  
    final users = db.collection("users");
    final data1 = <String, dynamic>{
      "name": "San Francisco",
      "state": "CA",
      "country": "USA",
      "capital": false,
      "population": 860000,
      "regions": ["west_coast", "norcal"]
    };
    users.doc("SF").set(data1);
  }
}
