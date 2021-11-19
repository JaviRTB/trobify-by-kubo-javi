import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SellOrRentSelection extends StatefulWidget {
  final dynamic userFilters;
  final String useruid;
  const SellOrRentSelection({this.userFilters, this.useruid});
  @override
  _SellOrRentSelectionState createState() => _SellOrRentSelectionState();
}

class _SellOrRentSelectionState extends State<SellOrRentSelection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 15),
          child: Text(
            '¿Qué estás buscando?',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 17,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Firestore.instance
                      .collection('users')
                      .document(widget.useruid)
                      .collection('userFilters')
                      .document(widget.useruid + 'F')
                      .updateData({'onSell': false});
                },
                child: Text(
                  'Alquileres',
                  style: TextStyle(
                    color: widget.userFilters['onSell']
                        ? Color.fromRGBO(52, 52, 52, 1)
                        : Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: widget.userFilters['onSell']
                      ? Colors.white
                      : Color.fromRGBO(238, 105, 110, 1),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Firestore.instance
                      .collection('users')
                      .document(widget.useruid)
                      .collection('userFilters')
                      .document(widget.useruid + 'F')
                      .updateData({'onSell': true});
                },
                child: Text(
                  'Ventas',
                  style: TextStyle(
                    color: widget.userFilters['onSell']
                        ? Colors.white
                        : Color.fromRGBO(52, 52, 52, 1),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: widget.userFilters['onSell']
                      ? Color.fromRGBO(238, 105, 110, 1)
                      : Colors.white,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
