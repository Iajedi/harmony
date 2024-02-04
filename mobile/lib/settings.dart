import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isEditing = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final db = FirebaseFirestore.instance;

  Widget _buildProfileField(String label, TextEditingController controller) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _isEditing
            ? [
                Expanded(child: _buildEditableTextField(label, controller)),
              ]
            : [
                Expanded(
                  child: Text(
                    '$label: ',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: _buildReadOnlyTextField(controller),
                )
              ]);
  }

  Widget _buildEditableTextField(
      String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText:
            controller.text.isEmpty ? 'Enter your $label' : controller.text,
        border: const OutlineInputBorder(),
      ),
      style: const TextStyle(fontSize: 15),
      textCapitalization: TextCapitalization.words,
    );
  }

  Widget _buildReadOnlyTextField(TextEditingController controller) {
    FontWeight weight =
        controller.text.isEmpty ? FontWeight.w100 : FontWeight.normal;
    return Text(
      controller.text.isEmpty ? 'Empty' : controller.text,
      style: TextStyle(fontSize: 20, fontWeight: weight),
    );
  }

  Future<void> _fetchUserData() async {
    final userRef = db.collection("users").doc("91817161");
    final doc = await userRef.get();
    final data = doc.data() as Map<String, dynamic>;

    setState(() {
      for (final entry in data.entries) {
        switch (entry.key) {
          case "name":
            _nameController.text = entry.value;
            break;
          case "age":
            _ageController.text = entry.value.toString();
            break;
          case "weight":
            _weightController.text = entry.value.toString();
            break;
        }
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
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileField("Name", _nameController),
          const SizedBox(height: 24),
          _buildProfileField("Age", _ageController),
          const SizedBox(height: 24),
          _buildProfileField("Weight", _weightController),
          const SizedBox(height: 24),
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
    );
  }
}
