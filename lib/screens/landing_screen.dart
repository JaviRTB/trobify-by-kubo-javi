import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../widgets/sell_or_rent_selection_widget.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/main_drawer.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder(
        stream: Firestore.instance
            .collection('users')
            .document(user.uid)
            .collection('userFilters')
            .document(user.uid + 'F')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          }
          var userFilters = snapshot.data;
          return Scaffold(
            appBar: AppBarWidget(),
            drawer: MainDrawer(),
            body: Container(
              margin: EdgeInsets.only(bottom: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 20,
                          bottom: 20,
                        ),
                        width: double.infinity,
                        child: Text(
                          'Encontrar piso,\n nunca ha sido tan fácil,\n lo primero:',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Column(
                        children: [
                          SellOrRentSelection(
                            userFilters: userFilters,
                            useruid: user.uid,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/images/landing_page_image.png',
                    height: 200,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
