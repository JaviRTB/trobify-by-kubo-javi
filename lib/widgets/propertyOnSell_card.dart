import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

import '../models/propertyOnSell.dart';
import '../screens/propertyOnSell_detail_screen.dart';

class PropertyOnSellCard extends StatelessWidget {
  final PropertyOnSell propertyOnSell;

  PropertyOnSellCard({
    @required this.propertyOnSell,
  });

  void selectProperty(BuildContext context) {
    Navigator.of(context).pushNamed(
      PropertyOnSellDetailScreen.routeName,
      arguments: propertyOnSell,
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

  Widget getImageWidget(String value) {
    return Image.network(
      value,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectProperty(context),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              height: 200,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Carousel(
                      boxFit: BoxFit.cover,
                      images: [
                        for (var i = 0; i < propertyOnSell.images.length; i++)
                          getImageWidget(propertyOnSell.images[i]),
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
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 15,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    propertyOnSell.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    insertDecimal(propertyOnSell.price.toString()) + '€',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    propertyOnSell.area.toString() +
                        'm\u00B2. ' +
                        propertyOnSell.nRooms.toString() +
                        ' hab. ' +
                        propertyOnSell.height.toString() +
                        '\u00AA planta.',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
