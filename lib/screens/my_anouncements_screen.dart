import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/propertyOnLoan.dart';
import '../models/user.dart';
import '../widgets/propertyOnLoan_card.dart';

class MyAnnouncementsScreen extends StatefulWidget {
  static const routeName = '/my-announcement';
  @override
  _MyAnnouncementsScreenState createState() => _MyAnnouncementsScreenState();
}

class _MyAnnouncementsScreenState extends State<MyAnnouncementsScreen> {
  String publisherId;
  bool switchButton = false;
  List<String> toStringList(List<dynamic> list) {
    var stringList = <String>[];
    for (int i = 0; i < list.length; i++) {
      stringList.add(list[i]);
    }
    return stringList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mis Anuncios',
          style: TextStyle(
            color: Color.fromRGBO(52, 52, 52, 1),
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color.fromRGBO(52, 52, 52, 1)),
      ),
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
              final user = Provider.of<User>(context);
              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (ctx, index) {
                  if (user.uid == documents[index]['publisherId']) {
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
                      publisherId: documents[index]['publisherId'],
                    );
                    print(documents[index].documentID);
                    switchButton = documents[index]['isVisible'];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        PropertyOnLoanCard(
                          propertyOnLoan: newPropertyOnLoan,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Quiere publicar el piso?'),
                              Container(
                                child: Switch(
                                    activeTrackColor:
                                        Color.fromRGBO(238, 105, 110, 0.8),
                                    activeColor:
                                        Color.fromRGBO(238, 105, 110, 1),
                                    value: switchButton,
                                    onChanged: (value) {
                                      setState(() {
                                        switchButton = value;
                                        Firestore.instance
                                            .collection('properties')
                                            .document(
                                                documents[index].documentID)
                                            .setData({'isVisible': value},
                                                merge: true);
                                      });
                                    }),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                      ],
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
