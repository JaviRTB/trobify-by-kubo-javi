import 'package:flutter/material.dart';

class PropertyDescription extends StatefulWidget {
  final String description;

  PropertyDescription({@required this.description});

  @override
  _PropertyDescriptionState createState() => _PropertyDescriptionState();
}

class _PropertyDescriptionState extends State<PropertyDescription> {
  bool readMore = false;
  // String description;

  @override
  Widget build(BuildContext context) {
    if (!readMore) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Descripción',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
            ),
            Text(
              widget.description,
              maxLines: 2,
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  readMore = true;
                });
              },
              child: Text('Leer más ...'),
              style: TextButton.styleFrom(primary: Colors.grey[200]),
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Descripción',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
            ),
            Text(
              widget.description,
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  readMore = false;
                });
              },
              child: Text('Leer menos ...'),
              style: TextButton.styleFrom(primary: Colors.grey[200]),
            ),
          ],
        ),
      );
    }
  }
}
