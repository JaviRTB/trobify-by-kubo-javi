import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  //colection reference
  final CollectionReference propertyCollection = Firestore.instance.collection('properties');

}