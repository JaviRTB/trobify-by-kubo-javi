import 'package:flutter/material.dart';

import './login_screen.dart';
import './register_screen.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showLogIn = true;
  void toggleView() {
    setState(() {
      showLogIn = !showLogIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogIn) {
      return LogIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}