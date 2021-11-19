import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../screens/authenticate.dart';
import '../screens/home_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //return either login screen or home

    if (user == null) {
      return Authenticate();
    } else {
      return HomeScreen();
    }
  }
}
