import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../models/propertyOnLoan.dart';
import '../widgets/propertyOnLoan_card.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/main_drawer.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  static Iterable<dynamic> favoritesIds = {};
  List<String> toStringList(List<dynamic> list) {
    var stringList = <String>[];
    for (int i = 0; i < list.length; i++) {
      stringList.add(list[i]);
    }
    return stringList;
  }

  Future getFavorites(uid) async {
    return await Firestore.instance
        .collection('users')
        .document(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      documentSnapshot.data.removeWhere((key, value) {
        return !key.startsWith('favorite');
      });
      if (mounted) {
        setState(() {
          favoritesIds = documentSnapshot.data.values;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = Provider.of<User>(context);
    getFavorites(user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      drawer: MainDrawer(),
      body: Center(
        child: StreamBuilder(
            stream: Firestore.instance.collection('properties').snapshots(),
            builder: (ctx, streamSnapshot) {
              if (streamSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final documents = streamSnapshot.data.documents;
              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (ctx, index) {
                  if (favoritesIds.contains(documents[index]['id']) && documents[index]['isVisible']) {
                    PropertyOnLoan newPropertyOnLoan = new PropertyOnLoan(
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
                      communityCosts: documents[index]['communityCosts'],
                      electricityCosts: documents[index]['electricityCosts'],
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
      ),
    );
  }
}
