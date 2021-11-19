import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../widgets/sell_or_rent_selection_widget.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filter-screen';

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  RangeValues _currentRangeValues = const RangeValues(600, 2600);
  Color selectedColor = Color.fromRGBO(238, 105, 110, 1);
  Color unselectedColor = Colors.white;
  List<bool> nRoomSelected = [true, false, false, false, false, false];
  List<bool> nBathSelected = [true, false, false, false];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filtros',
          style: TextStyle(
            color: Color.fromRGBO(52, 52, 52, 1),
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color.fromRGBO(52, 52, 52, 1)),
      ),
      body: StreamBuilder(
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
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SellOrRentSelection(
                            userFilters: userFilters,
                            useruid: user.uid,
                          ),
                          Divider(),
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Text(
                              'Precio',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          RangeSlider(
                            values: _currentRangeValues,
                            min: 0,
                            max: 4500,
                            divisions: 9,
                            labels: RangeLabels(
                              _currentRangeValues.start.round().toString() +
                                  '€',
                              _currentRangeValues.end.round().toString() + '€',
                            ),
                            onChanged: (RangeValues values) {
                              setState(() {
                                _currentRangeValues = values;
                              });
                            },
                            activeColor: Color.fromRGBO(238, 105, 110, 1),
                          ),
                          Divider(),
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Text(
                              'Habitaciones',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 40,
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.only(left: 15),
                            child: ListView.builder(
                              itemCount: nRoomSelected.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        for (var i = 0;
                                            i < nRoomSelected.length;
                                            i++) {
                                          if (nRoomSelected[i]) {
                                            nRoomSelected[i] = false;
                                          }
                                        }
                                        nRoomSelected[index] = true;
                                      });
                                    },
                                    child: Text(
                                      index == 0
                                          ? 'Todas'
                                          : index.toString() + '+',
                                      style: TextStyle(
                                        color: nRoomSelected[index]
                                            ? Colors.white
                                            : Color.fromRGBO(52, 52, 52, 1),
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: nRoomSelected[index]
                                          ? Color.fromRGBO(238, 105, 110, 1)
                                          : Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(),
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Text(
                              'Baños',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 40,
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.only(left: 15),
                            child: ListView.builder(
                              itemCount: nBathSelected.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        for (var i = 0;
                                            i < nBathSelected.length;
                                            i++) {
                                          if (nBathSelected[i]) {
                                            nBathSelected[i] = false;
                                          }
                                        }
                                        nBathSelected[index] = true;
                                      });
                                    },
                                    child: Text(
                                      index == 0
                                          ? 'Todas'
                                          : index.toString() + '+',
                                      style: TextStyle(
                                        color: nBathSelected[index]
                                            ? Colors.white
                                            : Color.fromRGBO(52, 52, 52, 1),
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: nBathSelected[index]
                                          ? Color.fromRGBO(238, 105, 110, 1)
                                          : Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Firestore.instance
                                      .collection('users')
                                      .document(user.uid)
                                      .collection('userFilters')
                                      .document(user.uid + 'F')
                                      .updateData({
                                    'lowerPrice': _currentRangeValues.start,
                                    'upperPrice': _currentRangeValues.end
                                  });
                                  for (int i = 0;
                                      i < nRoomSelected.length;
                                      i++) {
                                    if (nRoomSelected[i]) {
                                      Firestore.instance
                                          .collection('users')
                                          .document(user.uid)
                                          .collection('userFilters')
                                          .document(user.uid + 'F')
                                          .updateData({'nHab': i});
                                    }
                                  }
                                  for (int i = 0;
                                      i < nBathSelected.length;
                                      i++) {
                                    if (nBathSelected[i]) {
                                      Firestore.instance
                                          .collection('users')
                                          .document(user.uid)
                                          .collection('userFilters')
                                          .document(user.uid + 'F')
                                          .updateData({'nBath': i});
                                    }
                                  }
                                  Navigator.pop(context);
                                },
                                child: Text('Actualizar Filtros'),
                                style: ElevatedButton.styleFrom(
                                    primary: Color.fromRGBO(238, 105, 110, 1)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
