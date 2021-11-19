import 'package:flutter/material.dart';

import '../widgets/app_bar_widget.dart';
import '../widgets/main_drawer.dart';

class MatchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      drawer: MainDrawer(),
      body: Center(
      ),
    );
  }
}
