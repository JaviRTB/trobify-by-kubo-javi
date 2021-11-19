import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../models/propertyOnLoan.dart';
import '../models/propertyOnSell.dart';
import '../widgets/propertyOnLoan_card.dart';
import '../widgets/propertyOnSell_card.dart';

// ignore: must_be_immutable
class PropertyList extends StatelessWidget {
  double _lowerPrice;
  double _upperPrice;
  int _nHab;
  int _nBath;
  bool _onSell;

  List<String> toStringList(List<dynamic> list) {
    var stringList = <String>[];
    for (int i = 0; i < list.length; i++) {
      stringList.add(list[i]);
    }
    return stringList;
  }

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
          _lowerPrice = userFilters['lowerPrice'];
          _upperPrice = userFilters['upperPrice'];
          _nHab = userFilters['nHab'];
          _nBath = userFilters['nBath'];
          _onSell = userFilters['onSell'];
          return Center(
            child: _onSell
                ? StreamBuilder(
                    stream:
                        Firestore.instance.collection('properties').snapshots(),
                    builder: (ctx, streamSnapshot) {
                      if (streamSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final documents = streamSnapshot.data.documents;
                      return ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (ctx, index) {
                          if (index == 0) {
                            return Column(children: [
                              Text('Mis filtros:'),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _onSell
                                        ? Text('0 - 1.000.000')
                                        : Text(_lowerPrice.toString() +
                                            ' - ' +
                                            _upperPrice.toString()),
                                    Icon(Icons.euro),
                                    Text(_nHab.toString()),
                                    FaIcon(FontAwesomeIcons.doorOpen),
                                    Text(_nBath.toString()),
                                    FaIcon(FontAwesomeIcons.bath),
                                  ],
                                ),
                              )
                            ]);
                          }
                          if (documents[index]['onSell'] &&
                              documents[index]['nRooms'] >= _nHab &&
                              documents[index]['nBaths'] >= _nBath &&
                              documents[index]['isVisible']) {
                            PropertyOnSell newPropertyOnSell =
                                new PropertyOnSell(
                              id: documents[index]['id'],
                              title: documents[index]['title'],
                              description: documents[index]['description'],
                              images: toStringList(documents[index]['photos']),
                              price: documents[index]['price'],
                              area: documents[index]['area'],
                              nRooms: documents[index]['nRooms'],
                              height: documents[index]['height'],
                              location: documents[index]['location'],
                              nBaths: documents[index]['nBaths'],
                              yearBuilt: documents[index]['yearBuilt'],
                              parking: documents[index]['parking'],
                              furnished: documents[index]['furnished'],
                              elevator: documents[index]['elevator'],
                            );
                            return PropertyOnSellCard(
                              propertyOnSell: newPropertyOnSell,
                            );
                          } else {
                            return Container(width: 0, height: 0);
                          }
                        },
                      );
                    })
                : StreamBuilder(
                    stream:
                        Firestore.instance.collection('properties').snapshots(),
                    builder: (ctx, streamSnapshot) {
                      if (streamSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final documents = streamSnapshot.data.documents;
                      return ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (ctx, index) {
                          if (index == 0) {
                            return Column(children: [
                              Text('Mis filtros:'),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(Icons.euro),
                                    Text(_lowerPrice.toString() +
                                        ' - ' +
                                        _upperPrice.toString()),
                                    FaIcon(FontAwesomeIcons.doorOpen),
                                    Text(_nHab.toString() + '+ '),
                                    FaIcon(FontAwesomeIcons.bath),
                                    Text(_nBath.toString() + '+ '),
                                  ],
                                ),
                              )
                            ]);
                          }
                          if (!documents[index]['onSell'] &&
                              documents[index]['nRooms'] >= _nHab &&
                              documents[index]['nBaths'] >= _nBath &&
                              documents[index]['price'] >= _lowerPrice &&
                              documents[index]['price'] <= _upperPrice &&
                              documents[index]['isVisible']) {
                            PropertyOnLoan newPropertyOnLoan =
                                new PropertyOnLoan(
                              id: documents[index]['id'],
                              title: documents[index]['title'],
                              description: documents[index]['description'],
                              images: toStringList(documents[index]['photos']),
                              pricePerMonth: documents[index]['price'],
                              area: documents[index]['area'],
                              nRooms: documents[index]['nRooms'],
                              height: documents[index]['height'],
                              location: documents[index]['location'],
                              nBaths: documents[index]['nBaths'],
                              yearBuilt: documents[index]['yearBuilt'],
                              parking: documents[index]['parking'],
                              furnished: documents[index]['furnished'],
                              elevator: documents[index]['elevator'],
                              wifi: documents[index]['wifi'],
                              communityCosts: documents[index]
                                  ['communityCosts'],
                              electricityCosts: documents[index]
                                  ['electricityCosts'],
                              waterCosts: documents[index]['waterCosts'],
                              pets: documents[index]['pets'],
                            );
                            return PropertyOnLoanCard(
                              propertyOnLoan: newPropertyOnLoan,
                            );
                          } else {
                            return Container(width: 0, height: 0);
                          }
                        },
                      );
                    }),
          );
        });
  }
}
