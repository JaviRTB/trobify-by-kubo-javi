import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/propertyOnLoan.dart';
import '../models/user.dart';

class PropertyFavoriteWidget extends StatefulWidget {
  @override
  _PropertyFavoriteWidgetState createState() => _PropertyFavoriteWidgetState();
}

class _PropertyFavoriteWidgetState extends State<PropertyFavoriteWidget> {
  var firestore = Firestore.instance;
  var isFavorite = false;

  Future isFavoriteNow(uid, propertyid) async {
    return await Firestore.instance
        .collection('users')
        .document(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (mounted) {
        setState(() {
          isFavorite = documentSnapshot.data.containsValue(propertyid);
        });
      }
    });
  }

  Future addFavorite(uid, propertyid) async {
    var favoritesLength;
    await firestore
        .collection('users')
        .document(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      favoritesLength = documentSnapshot.data.keys
          .where((element) => element.startsWith('favorite'))
          .length;
      if (documentSnapshot.data.containsKey('favorite$favoritesLength')) {
        for (var i = 0; i <= favoritesLength + 1; i++) {
          if (!documentSnapshot.data.containsKey('favorite$i')) {
            favoritesLength = i;
          }
        }
      }
    });
    return await firestore
        .collection('users')
        .document(uid)
        .setData({'favorite$favoritesLength': propertyid}, merge: true);
  }

  Future deleteFavorite(uid, propertyid) async {
    Map<String, dynamic> res;
    await firestore
        .collection('users')
        .document(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.data.containsValue(propertyid)) {
        documentSnapshot.data.removeWhere((key, value) {
          return value == propertyid;
        });
        res = documentSnapshot.data;
      } else {
        res = documentSnapshot.data;
      }
    });
    return firestore.collection('users').document(uid).setData(res);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final property =
        ModalRoute.of(context).settings.arguments as PropertyOnLoan;
    isFavoriteNow(user.uid, property.id);
    if (!isFavorite) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('¿Te ha gustado este piso?'),
              Text('Guardalo en favoritos!'),
            ],
          ),
          IconButton(
            icon: Icon(Icons.favorite_outline),
            color: Colors.red,
            onPressed: () {
              setState(() {
                isFavorite = true;
                addFavorite(user.uid, property.id);
              });
            },
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('¿Te ha gustado este piso?'),
              Text('Guardalo en favoritos!'),
            ],
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            color: Colors.red,
            onPressed: () {
              setState(() {
                isFavorite = false;
                deleteFavorite(user.uid, property.id);
              });
            },
          ),
        ],
      );
    }
  }
}
