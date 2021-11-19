import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/property_description.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/speed_dial_widget.dart';
import '../widgets/property_favorite_widget.dart';
import '../models/propertyOnSell.dart';

class PropertyOnSellDetailScreen extends StatelessWidget {
  static const routeName = '/property-onSell-detail';

  Widget getImageWidget(String value) {
    return Image.network(
      value,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }

  String insertDecimal(String price) {
    String res = '';
    String left;
    String right;
    if (price.length > 3) {
      right = price.substring(price.length - 3, price.length);
      left = price.substring(0, price.length - 3);
      res = left + '.' + right;
      return res;
    } else {
      return price;
    }
  }

  @override
  Widget build(BuildContext context) {
    final property =
        ModalRoute.of(context).settings.arguments as PropertyOnSell;
    return Scaffold(
      appBar: AppBarWidget(),
      floatingActionButton: SpeedDialWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Carousel(
                boxFit: BoxFit.cover,
                images: [
                  for (var i = 0; i < property.images.length; i++)
                    getImageWidget(property.images[i]),
                ],
                autoplay: false,
                dotSize: 4.0,
                dotSpacing: 10.0,
                dotColor: Colors.white.withOpacity(0.75),
                dotIncreasedColor: Colors.white.withOpacity(0.75),
                dotBgColor: Colors.transparent,
                dotPosition: DotPosition.bottomCenter,
                indicatorBgPadding: 10.0,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, top: 10),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    insertDecimal(property.price.toString()) + '€',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 25, right: 25, bottom: 10),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.doorOpen,
                        size: 42,
                      ),
                      Text(
                        property.nRooms.toString() + ' habs',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.bath,
                        size: 42,
                      ),
                      Text(
                        property.nBaths.toString() + ' baños',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.aspect_ratio_rounded,
                        size: 42,
                      ),
                      Text(
                        property.area.toString() + ' m\u00B2',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.stairs_outlined,
                        size: 42,
                      ),
                      Text(
                        property.height.toString() + ' \u00AA planta',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Divider(),
            ),
            PropertyDescription(description: property.description),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Servicios',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (property.parking)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Parking'),
                        FaIcon(
                          FontAwesomeIcons.parking,
                          size: 30,
                        ),
                      ],
                    ),
                  if (property.furnished)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Amueblado'),
                        FaIcon(
                          FontAwesomeIcons.couch,
                          size: 30,
                        ),
                      ],
                    ),
                  if (property.elevator)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Ascensor'),
                        Icon(
                          Icons.elevator_outlined,
                          size: 30,
                        ),
                      ],
                    ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 20),
              child: Divider(),
            ),
            PropertyFavoriteWidget(),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
