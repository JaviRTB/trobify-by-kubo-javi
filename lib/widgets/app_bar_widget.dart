import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Image.asset(
        'assets/images/trobify_logo.png',
        fit: BoxFit.contain,
        height: 42,
      ),
      iconTheme: IconThemeData(color: Color.fromRGBO(52, 52, 52, 1)),
      backgroundColor: Colors.white,
    );
  }
}
