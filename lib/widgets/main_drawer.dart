import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../screens/my_anouncements_screen.dart';
import '../screens/upload_property.dart';
import '../services/auth.dart';

class MainDrawer extends StatelessWidget {
  final AuthService _auth = AuthService();

  void openUploadPropertyScreen(BuildContext context) {
    Navigator.of(context).pushNamed(
      UploadPropertyScreen.routeName,
    );
  }

  Widget buildDrawerItem(String title, IconData icon, Function onTap) {
    return Container(
      child: ListTile(
        leading: Icon(
          icon,
          size: 28,
          color: Colors.black54,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder(
        stream: Firestore.instance
            .collection('users')
            .document(user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          }
          var userDocument = snapshot.data;
          return Container(
            height: MediaQuery.of(context).size.height,
            child: Drawer(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 120,
                    width: double.infinity,
                    color: Color.fromRGBO(238, 105, 110, 1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: ListTile(
                            leading: Icon(
                              Icons.person_pin,
                              size: 60,
                              color: Colors.white,
                            ),
                            title: Text(
                              userDocument["name"] +
                                  " " +
                                  userDocument["surnames"],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        buildDrawerItem(
                            'Mis anuncios', Icons.my_library_books_rounded, () {
                          Navigator.of(context).pushNamed(
                            MyAnnouncementsScreen.routeName,
                          );
                        }),
                        SizedBox(height: 10),
                        buildDrawerItem('Subir Anuncios', Icons.publish_rounded,
                            () => openUploadPropertyScreen(context)),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.37),
                        Divider(
                          color: Colors.grey,
                        ),
                        buildDrawerItem(
                          'Cerrar sesión',
                          Icons.exit_to_app_rounded,
                          () async {
                            await _auth.signOut();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
