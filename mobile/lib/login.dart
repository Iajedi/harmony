import 'package:flutter/material.dart';
import 'package:ichack24/auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Widget _entryField(
    String title,
    TextEditingController controller,
    bool obscured,
  ) {
    return TextField(
      controller: controller,
      obscureText: obscured,
      decoration: InputDecoration(
        labelText: title,
        border: const OutlineInputBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _entryField("Email", _controllerEmail, false),
          const Padding(padding: EdgeInsets.all(5.0)),
          _entryField("Password", _controllerPassword, true),
          const Padding(padding: EdgeInsets.all(5.0)),
          ElevatedButton(
              onPressed: () async {
                await Auth().signIn(
                    email: _controllerEmail.text,
                    password: _controllerPassword.text);
              },
              child: const Text(
                "Sign In",
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
    );
  }
}
