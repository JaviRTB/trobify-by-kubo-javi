import './property.dart';

class PropertyOnLoan extends Property {
  final int pricePerMonth;
  final bool wifi;
  final bool communityCosts;
  final bool electricityCosts;
  final bool waterCosts;
  final bool pets;

  const PropertyOnLoan({
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
    position,
    publisherId,
    this.pricePerMonth,
    this.wifi,
    this.communityCosts,
    this.electricityCosts,
    this.waterCosts,
    this.pets,
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
