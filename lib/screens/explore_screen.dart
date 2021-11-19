import 'package:flutter/material.dart';

import './map_view_screen.dart';
import './property_list_screen.dart';
import './filter_screen.dart';

class ExploreScreen extends StatelessWidget {

  void openFilterScreen(BuildContext context) {
    Navigator.of(context).pushNamed(
      FilterScreen.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Explorar',
            style: TextStyle(
              color: Color.fromRGBO(52, 52, 52, 1),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.filter_alt_rounded,
                color: Color.fromRGBO(52, 52, 52, 1),
              ),
              onPressed: () => openFilterScreen(context),
            )
          ],
          backgroundColor: Colors.white,
          bottom: TabBar(
            unselectedLabelColor: Color.fromRGBO(52, 52, 52, 1),
            labelColor: Color.fromRGBO(238, 105, 110, 1),
            indicatorColor: Color.fromRGBO(238, 105, 110, 1),
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.list),
                    Text(' Listado'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_pin),
                    Text(' Ver mapa'),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PropertyList(),
            MapView(),
          ],
        ),
      ),
    );
  }
}
