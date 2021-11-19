import './property.dart';

class PropertyOnSell extends Property {
  final int price;

  const PropertyOnSell({
    id,
    title,
    location,
    description,
    area,
    nRooms,
    nBaths,
    height,
    yearBuilt,
    images,
    parking,
    furnished,
    elevator,
    type,
    this.price,
    position,
    publisherId,
  }) : super(
          id: id,
          title: title,
          location: location,
          description: description,
          area: area,
          nRooms: nRooms,
          nBaths: nBaths,
          height: height,
          yearBuilt: yearBuilt,
          images: images,
          parking: parking,
          furnished: furnished,
          elevator: elevator,
          type: type,
          position: position,
          publisherId: publisherId,
        );
}
