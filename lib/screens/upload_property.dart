import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:math';

import '../models/user.dart';

class UploadPropertyScreen extends StatefulWidget {
  static const routeName = '/upload-property';

  @override
  UploadPropertyScreenState createState() => UploadPropertyScreenState();
}

class UploadPropertyScreenState extends State<UploadPropertyScreen> {
  var storage = FirebaseStorage.instance;
  //Variables de control de interfaz
  int i, j;
  Future<File> file;
  String status;
  String base64Image;
  File tmpFile;
  String errMessage = 'Error uploading image';
  List<bool> typePropertyList = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  Color selectedColor = Color.fromRGBO(238, 105, 110, 1);
  Color unselectedColor = Colors.white;
  bool typeOfLoan = false; //true es alquiler y false venta
  List<bool> nRoomSelected = [true, false, false, false, false, false];
  List<bool> nBathSelected = [true, false, false, false];
  bool elevatorController = false;
  bool furnishedController = false;
  bool parkingController = false;
  bool petsController = false;
  bool wifiController = false;
  bool communityController = false;
  bool electricityController = false;
  bool waterController = false;

  //Variables del piso final que se va a subir
  int area;
  bool communityCosts = false;
  String description = '';
  bool electricityCosts = false;
  bool elevator = false;
  bool furnished = false;
  int height = 1;
  String id = 'x86xdjkksauwedmfcosi98';
  String location;
  int nBaths;
  int nRooms;
  bool onSell = false;
  bool parking = false;
  bool pets = false;
  List<String> photos = [];
  int price;
  String title;
  String type;
  bool waterCosts = false;
  bool wifi = false;
  int yearBuilt;

  File _image;
  String _uploadedFileURL;

  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  String getUploadedFileUrl() {
    return _uploadedFileURL;
  }

  Future chooseFile() async {
    // ignore: deprecated_member_use
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('property_images/' + getRandomString(20) + '.png');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
        photos.add(_uploadedFileURL);
      });
    });
  }

  Future clearSelection() async {
    setState(() {
      _image = null;
      _uploadedFileURL = null;
    });
  }

  void uploadProperty(
      int area,
      bool communityCosts,
      String description,
      bool electricityCosts,
      bool elevator,
      bool furnished,
      int height,
      String id,
      String location,
      int nBaths,
      int nRooms,
      bool onSell,
      bool parking,
      bool pets,
      List<String> photos,
      int price,
      String title,
      String type,
      bool waterCosts,
      bool wifi,
      int yearBuilt,
      String useruid) async {
    await Firestore.instance.collection('properties').document().setData({
      'area': area,
      'communityCosts': communityCosts,
      'description': description,
      'electricityCosts': electricityCosts,
      'elevator': elevator,
      'furnished': furnished,
      'height': height,
      'id': id,
      'location': location,
      'nBaths': nBaths,
      'nRooms': nRooms,
      'onSell': onSell,
      'parking': parking,
      'pets': pets,
      'photos': photos,
      'price': price,
      'title': title,
      'type': type,
      'waterCosts': waterCosts,
      'wifi': wifi,
      'yearBuilt': yearBuilt,
      'publisherId': useruid,
      'isVisible': false,
    });
    await Firestore.instance
        .collection('users')
        .document(id)
        .collection('userProperties')
        .document(id + 'P')
        .setData({
      'area': area,
      'communityCosts': communityCosts,
      'description': description,
      'electricityCosts': electricityCosts,
      'elevator': elevator,
      'furnished': furnished,
      'height': height,
      'id': id,
      'location': location,
      'nBaths': nBaths,
      'nRooms': nRooms,
      'onSell': onSell,
      'parking': parking,
      'pets': pets,
      'photos': photos,
      'price': price,
      'title': title,
      'type': type,
      'waterCosts': waterCosts,
      'wifi': wifi,
      'yearBuilt': yearBuilt,
      'publisherId': useruid,
      'isVisible': false,
    });
    Navigator.pop(context);
  }

  Widget seleccionAlquilerVenta() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 120,
          height: 60,
          margin: EdgeInsets.only(right: 15, top: 20, bottom: 20),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: typeOfLoan ? selectedColor : unselectedColor),
              child: Text(
                'ALQUILER',
                style:
                    TextStyle(color: typeOfLoan ? Colors.black : selectedColor),
              ),
              onPressed: () {
                setState(() {
                  typeOfLoan = true;
                  onSell = false;
                });
              }),
        ),
        Container(
          width: 120,
          height: 60,
          margin: EdgeInsets.only(left: 15),
          child: ElevatedButton(
              child: Text(
                'VENTA',
                style: TextStyle(
                  color: !typeOfLoan ? Colors.black : selectedColor,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: !typeOfLoan ? selectedColor : unselectedColor,
                padding: EdgeInsets.all(8),
              ),
              onPressed: () {
                setState(() {
                  typeOfLoan = false;
                  onSell = true;
                });
              }),
        )
      ],
    );
  }

  Widget seleccionTipoInmueble() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: typePropertyList[0] ? selectedColor : unselectedColor,
                padding: EdgeInsets.all(8),
              ),
              onPressed: () {
                setState(() {
                  type = 'Piso';
                  for (i = 0; i < 8; i++) {
                    if (i == 0) {
                      typePropertyList[i] = true;
                    } else {
                      typePropertyList[i] = false;
                    }
                  }
                });
              },
              child: Column(
                children: [
                  Container(
                    child: FaIcon(
                      FontAwesomeIcons.building,
                      size: 35,
                      color:
                          typePropertyList[0] ? unselectedColor : selectedColor,
                    ),
                    margin: EdgeInsets.only(top: 7),
                  ),
                  Container(
                    child: Text(
                      'Piso',
                      style: TextStyle(fontSize: 12),
                    ),
                    margin: EdgeInsets.only(top: 8),
                  )
                ],
              ),
            ),
            height: 100,
            width: 100,
            margin: EdgeInsets.all(10),
          ),
          Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: typePropertyList[1] ? selectedColor : unselectedColor,
                padding: EdgeInsets.all(8),
              ),
              onPressed: () {
                setState(() {
                  type = 'Casa';
                  for (i = 0; i < 8; i++) {
                    if (i == 1) {
                      typePropertyList[i] = true;
                    } else {
                      typePropertyList[i] = false;
                    }
                  }
                });
              },
              child: Column(
                children: [
                  Container(
                    child: FaIcon(
                      FontAwesomeIcons.home,
                      size: 35,
                      color:
                          typePropertyList[1] ? unselectedColor : selectedColor,
                    ),
                    margin: EdgeInsets.only(top: 7),
                  ),
                  Container(
                    child: Text(
                      'Casa',
                      style: TextStyle(fontSize: 12),
                    ),
                    margin: EdgeInsets.only(top: 8),
                  )
                ],
              ),
            ),
            height: 100,
            width: 100,
            margin: EdgeInsets.all(10),
          ),
          Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: typePropertyList[2] ? selectedColor : unselectedColor,
                padding: EdgeInsets.all(8),
              ),
              onPressed: () {
                setState(() {
                  type = 'Garaje';
                  for (i = 0; i < 8; i++) {
                    if (i == 2) {
                      typePropertyList[i] = true;
                    } else {
                      typePropertyList[i] = false;
                    }
                  }
                });
              },
              child: Column(
                children: [
                  Container(
                    child: FaIcon(
                      FontAwesomeIcons.car,
                      size: 35,
                      color:
                          typePropertyList[2] ? unselectedColor : selectedColor,
                    ),
                    margin: EdgeInsets.only(top: 7),
                  ),
                  Container(
                    child: Text(
                      'Garaje',
                      style: TextStyle(fontSize: 12),
                    ),
                    margin: EdgeInsets.only(top: 8),
                  )
                ],
              ),
            ),
            height: 100,
            width: 100,
            margin: EdgeInsets.all(10),
          ),
          Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: typePropertyList[3] ? selectedColor : unselectedColor,
                padding: EdgeInsets.all(8),
              ),
              onPressed: () {
                setState(() {
                  type = 'Ático';
                  for (i = 0; i < 8; i++) {
                    if (i == 3) {
                      typePropertyList[i] = true;
                    } else {
                      typePropertyList[i] = false;
                    }
                  }
                });
              },
              child: Column(
                children: [
                  Container(
                    child: FaIcon(
                      FontAwesomeIcons.building,
                      size: 35,
                      color:
                          typePropertyList[3] ? unselectedColor : selectedColor,
                    ),
                    margin: EdgeInsets.only(top: 7),
                  ),
                  Container(
                    child: Text(
                      'Ático',
                      style: TextStyle(fontSize: 12),
                    ),
                    margin: EdgeInsets.only(top: 8),
                  )
                ],
              ),
            ),
            height: 100,
            width: 100,
            margin: EdgeInsets.all(10),
          ),
          Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: typePropertyList[4] ? selectedColor : unselectedColor,
                padding: EdgeInsets.all(8),
              ),
              onPressed: () {
                setState(() {
                  type = 'Chalet';
                  for (i = 0; i < 8; i++) {
                    if (i == 4) {
                      typePropertyList[i] = true;
                    } else {
                      typePropertyList[i] = false;
                    }
                  }
                });
              },
              child: Column(
                children: [
                  Container(
                    child: FaIcon(
                      FontAwesomeIcons.home,
                      size: 35,
                      color:
                          typePropertyList[4] ? unselectedColor : selectedColor,
                    ),
                    margin: EdgeInsets.only(top: 7),
                  ),
                  Container(
                    child: Text(
                      'Chalet',
                      style: TextStyle(fontSize: 12),
                    ),
                    margin: EdgeInsets.only(top: 8),
                  )
                ],
              ),
            ),
            height: 100,
            width: 100,
            margin: EdgeInsets.all(10),
          ),
          Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: typePropertyList[5] ? selectedColor : unselectedColor,
                padding: EdgeInsets.all(8),
              ),
              onPressed: () {
                setState(() {
                  type = 'Dúplex';
                  for (i = 0; i < 8; i++) {
                    if (i == 5) {
                      typePropertyList[i] = true;
                    } else {
                      typePropertyList[i] = false;
                    }
                  }
                });
              },
              child: Column(
                children: [
                  Container(
                    child: FaIcon(
                      FontAwesomeIcons.building,
                      size: 35,
                      color:
                          typePropertyList[5] ? unselectedColor : selectedColor,
                    ),
                    margin: EdgeInsets.only(top: 7),
                  ),
                  Container(
                    child: Text(
                      'Dúplex',
                      style: TextStyle(fontSize: 12),
                    ),
                    margin: EdgeInsets.only(top: 8),
                  )
                ],
              ),
            ),
            height: 100,
            width: 100,
            margin: EdgeInsets.all(10),
          ),
          Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: typePropertyList[6] ? selectedColor : unselectedColor,
                padding: EdgeInsets.all(8),
              ),
              onPressed: () {
                setState(() {
                  type = 'Oficina';
                  for (i = 0; i < 8; i++) {
                    if (i == 6) {
                      typePropertyList[i] = true;
                    } else {
                      typePropertyList[i] = false;
                    }
                  }
                });
              },
              child: Column(
                children: [
                  Container(
                    child: FaIcon(
                      FontAwesomeIcons.pencilRuler,
                      size: 35,
                      color:
                          typePropertyList[6] ? unselectedColor : selectedColor,
                    ),
                    margin: EdgeInsets.only(top: 7),
                  ),
                  Container(
                    child: Text(
                      'Oficina',
                      style: TextStyle(fontSize: 12),
                    ),
                    margin: EdgeInsets.only(top: 8),
                  )
                ],
              ),
            ),
            height: 100,
            width: 100,
            margin: EdgeInsets.all(10),
          ),
          Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(8),
                  primary:
                      typePropertyList[7] ? selectedColor : unselectedColor),
              onPressed: () {
                setState(() {
                  type = 'Otros';
                  for (i = 0; i < 8; i++) {
                    if (i == 7) {
                      typePropertyList[i] = true;
                    } else {
                      typePropertyList[i] = false;
                    }
                  }
                });
              },
              child: Column(
                children: [
                  Container(
                    child: FaIcon(
                      FontAwesomeIcons.store,
                      size: 35,
                      color:
                          typePropertyList[7] ? unselectedColor : selectedColor,
                    ),
                    margin: EdgeInsets.only(top: 7),
                  ),
                  Container(
                    child: Text(
                      'Otros',
                      style: TextStyle(fontSize: 12),
                    ),
                    margin: EdgeInsets.only(top: 8),
                  )
                ],
              ),
            ),
            height: 100,
            width: 100,
            margin: EdgeInsets.all(10),
          ),
        ],
      ),
    );
  }

  Widget seleccionarNumeroHabs() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 15),
          height: 60,
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 10,
              );
            },
            scrollDirection: Axis.horizontal,
            itemCount: nRoomSelected.length,
            itemBuilder: (context, index) {
              return Container(
                width: 65,
                margin: EdgeInsets.only(bottom: 5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: nRoomSelected[index]
                          ? selectedColor
                          : unselectedColor),
                  onPressed: () {
                    setState(() {
                      for (i = 0; i < nRoomSelected.length; i++) {
                        if (i == index) {
                          nRoomSelected[i] = true;
                          nRooms = i + 1;
                        } else {
                          nRoomSelected[i] = false;
                        }
                      }
                    });
                  },
                  child: Text(
                    (index + 1).toString(),
                    style: TextStyle(
                        color: nRoomSelected[index]
                            ? unselectedColor
                            : selectedColor),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget seleccionarNumeroBanos() {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: 20, left: 10),
            height: 65,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return SizedBox(width: 10);
              },
              itemCount: nBathSelected.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      for (i = 0; i < nBathSelected.length; i++) {
                        if (i == index) {
                          nBathSelected[i] = true;
                          nBaths = i + 1;
                        } else {
                          nBathSelected[i] = false;
                        }
                      }
                    });
                  },
                  child: Text(
                    (index + 1).toString(),
                    style: TextStyle(
                        color: nBathSelected[index]
                            ? unselectedColor
                            : selectedColor),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: nBathSelected[index]
                          ? selectedColor
                          : unselectedColor),
                );
              },
            )),
      ],
    );
  }

  Widget seleccionarTieneAscensor() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 20, left: 10),
          child: Text(
            'Ascensor',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 50,
                margin: EdgeInsets.only(right: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary:
                          elevatorController ? unselectedColor : selectedColor),
                  child: Text(
                    'SÍ',
                    style: TextStyle(
                        color:
                            elevatorController ? Colors.black : selectedColor),
                  ),
                  onPressed: () {
                    setState(() {
                      elevatorController = true;
                      elevator = true;
                    });
                  },
                ),
              ),
              Container(
                width: 100,
                height: 50,
                margin: EdgeInsets.only(left: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary:
                          elevatorController ? unselectedColor : selectedColor),
                  child: Text(
                    'NO',
                    style: TextStyle(
                        color:
                            elevatorController ? selectedColor : Colors.black),
                  ),
                  onPressed: () {
                    setState(() {
                      elevatorController = false;
                      elevator = false;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget seleccionarAmueblado() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 20, left: 10),
          child: Text(
            '¿Está amueblado?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                height: 50,
                width: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: furnishedController
                          ? unselectedColor
                          : selectedColor),
                  child: Text(
                    'SÍ',
                    style: TextStyle(
                        color:
                            furnishedController ? Colors.black : selectedColor),
                  ),
                  onPressed: () {
                    setState(() {
                      furnishedController = true;
                      furnished = true;
                    });
                  },
                ),
              ),
              Container(
                height: 50,
                width: 100,
                margin: EdgeInsets.only(left: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: furnishedController
                          ? unselectedColor
                          : selectedColor),
                  child: Text(
                    'NO',
                    style: TextStyle(
                        color:
                            furnishedController ? selectedColor : Colors.black),
                  ),
                  onPressed: () {
                    setState(() {
                      furnishedController = false;
                      furnished = false;
                    });
                  },
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget seleccionarSuperficie() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20, left: 10),
          alignment: Alignment.centerLeft,
          child: Text(
            'Superficie del inmueble',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 10, left: 10),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    area = int.parse(value);
                  },
                ),
              ),
              Container(
                child: Text('m2'),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget seleccionarParking() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 20, left: 10),
          child: Text(
            '¿Dispone de Parking?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                height: 50,
                width: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary:
                          parkingController ? selectedColor : unselectedColor),
                  child: Text(
                    'SÍ',
                    style: TextStyle(
                        color:
                            parkingController ? Colors.black : selectedColor),
                  ),
                  onPressed: () {
                    setState(() {
                      parkingController = true;
                      parking = true;
                    });
                  },
                ),
              ),
              Container(
                height: 50,
                width: 100,
                margin: EdgeInsets.only(left: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary:
                          parkingController ? unselectedColor : selectedColor),
                  child: Text(
                    'NO',
                    style: TextStyle(
                        color:
                            parkingController ? selectedColor : Colors.black),
                  ),
                  onPressed: () {
                    setState(() {
                      parkingController = false;
                      parking = false;
                    });
                  },
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget seleccionarTitulo() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20, left: 10),
          alignment: Alignment.centerLeft,
          child: Text(
            'Título del inmueble',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: 300,
          child: TextField(
            keyboardType: TextInputType.text,
            onChanged: (value) {
              title = value;
            },
          ),
        )
      ],
    );
  }

  Widget seleccionarDescripcion() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20, left: 10),
          alignment: Alignment.centerLeft,
          child: Text(
            'Descripción del inmueble',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(border: Border.all(color: selectedColor)),
          width: 300,
          child: TextField(
            maxLines: 6,
            keyboardType: TextInputType.text,
            onChanged: (value) {
              description = value;
            },
          ),
        )
      ],
    );
  }

  Widget seleccionarUbicacion() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20, left: 10),
          alignment: Alignment.centerLeft,
          child: Text(
            '¿Dónde está ubicado el inmueble?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          width: 300,
          child: TextField(
            keyboardType: TextInputType.text,
            onChanged: (value) {
              location = value;
            },
          ),
        )
      ],
    );
  }

  Widget seleccionarAnoConstruccion() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20, left: 10),
          alignment: Alignment.centerLeft,
          child: Text(
            'Año de construcción',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 10, left: 10),
          width: 320,
          child: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              yearBuilt = int.parse(value);
            },
          ),
        ),
      ],
    );
  }

  Widget seleccionarAltura() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20, left: 10),
          alignment: Alignment.centerLeft,
          child: Text(
            '¿En qué piso/planta está?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              height = int.parse(value);
            },
          ),
        )
      ],
    );
  }

  Widget seleccionarPrecioOnRent() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 10, top: 20),
          child: Text(
            'Precio del inmueble',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: 320,
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              price = int.parse(value);
            },
          ),
        )
      ],
    );
  }

  Widget seleccionarPrecioOnLoan() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 10, top: 20),
          child: Text(
            'Precio mensual',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: 320,
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              price = int.parse(value);
            },
          ),
        )
      ],
    );
  }

  Widget seleccionarMascotas() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 10, top: 20),
          child: Text(
            '¿Se admiten mascotas?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                height: 50,
                width: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary:
                          petsController ? unselectedColor : selectedColor),
                  child: Text(
                    'SÍ',
                    style: TextStyle(
                        color: petsController ? Colors.black : selectedColor),
                  ),
                  onPressed: () {
                    setState(() {
                      petsController = true;
                      pets = true;
                    });
                  },
                ),
              ),
              Container(
                height: 50,
                width: 100,
                margin: EdgeInsets.only(left: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary:
                          petsController ? unselectedColor : selectedColor),
                  child: Text(
                    'NO',
                    style: TextStyle(
                        color: petsController ? selectedColor : Colors.black),
                  ),
                  onPressed: () {
                    setState(() {
                      petsController = false;
                      pets = false;
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget seleccionarWifi() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 10, top: 20),
          child: Text(
            '¿Está el Wifi incluido?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                height: 50,
                width: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary:
                          wifiController ? selectedColor : unselectedColor),
                  child: Text(
                    'SÍ',
                    style: TextStyle(
                        color: wifiController ? Colors.black : selectedColor),
                  ),
                  onPressed: () {
                    setState(() {
                      wifiController = true;
                      wifi = true;
                    });
                  },
                ),
              ),
              Container(
                height: 50,
                width: 100,
                margin: EdgeInsets.only(left: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary:
                          wifiController ? unselectedColor : selectedColor),
                  child: Text(
                    'NO',
                    style: TextStyle(
                        color: wifiController ? selectedColor : Colors.black),
                  ),
                  onPressed: () {
                    setState(() {
                      wifiController = false;
                      wifi = false;
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget seleccionarCostesComunidad() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 10, top: 20),
          child: Text(
            '¿Están incluidos los costes de comunidad?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                height: 50,
                width: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: communityController
                          ? unselectedColor
                          : selectedColor),
                  child: Text(
                    'SÍ',
                    style: TextStyle(
                        color:
                            communityController ? Colors.black : selectedColor),
                  ),
                  onPressed: () {
                    setState(() {
                      communityController = true;
                      communityCosts = true;
                    });
                  },
                ),
              ),
              Container(
                height: 50,
                width: 100,
                margin: EdgeInsets.only(left: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: communityController
                          ? unselectedColor
                          : selectedColor),
                  child: Text(
                    'NO',
                    style: TextStyle(
                        color:
                            communityController ? selectedColor : Colors.black),
                  ),
                  onPressed: () {
                    setState(() {
                      communityController = false;
                      communityCosts = false;
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget seleccionarCostesElectricidad() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 10, top: 20),
          child: Text(
            '¿Están incluidos los costes de electricidad?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                height: 50,
                width: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: electricityController
                          ? selectedColor
                          : unselectedColor),
                  child: Text(
                    'SÍ',
                    style: TextStyle(
                        color: electricityController
                            ? Colors.black
                            : selectedColor),
                  ),
                  onPressed: () {
                    setState(() {
                      electricityController = true;
                      electricityCosts = true;
                    });
                  },
                ),
              ),
              Container(
                height: 50,
                width: 100,
                margin: EdgeInsets.only(left: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: electricityController
                          ? unselectedColor
                          : selectedColor),
                  child: Text(
                    'NO',
                    style: TextStyle(
                        color: electricityController
                            ? selectedColor
                            : Colors.black),
                  ),
                  onPressed: () {
                    setState(() {
                      electricityController = false;
                      electricityCosts = false;
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget seleccionarCostesAgua() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 10, top: 20),
          child: Text(
            '¿Están incluidos los costes de agua?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                height: 50,
                width: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary:
                          waterController ? selectedColor : unselectedColor),
                  child: Text(
                    'SÍ',
                    style: TextStyle(
                        color: waterController ? Colors.black : selectedColor),
                  ),
                  onPressed: () {
                    setState(() {
                      waterController = true;
                      waterCosts = true;
                    });
                  },
                ),
              ),
              Container(
                height: 50,
                width: 100,
                margin: EdgeInsets.only(left: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary:
                          waterController ? unselectedColor : selectedColor),
                  child: Text(
                    'NO',
                    style: TextStyle(
                        color: waterController ? selectedColor : Colors.black),
                  ),
                  onPressed: () {
                    setState(() {
                      waterController = false;
                      waterCosts = false;
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget seleccionarImagenes() {
    return Column(
      children: <Widget>[
        Text('Imagen Seleccionada'),
        _image != null ? Image.file(_image) : Container(height: 150),
        _image == null
            ? ElevatedButton(
                child: Text('Elegir Imagen'),
                onPressed: chooseFile,
                style: ElevatedButton.styleFrom(primary: selectedColor),
              )
            : Container(),
        _image != null
            ? ElevatedButton(
                child: Text('Subir Imagen'),
                onPressed: uploadFile,
                style: ElevatedButton.styleFrom(primary: selectedColor),
              )
            : Container(),
        _image != null
            ? ElevatedButton(
                child: Text('Desseleccionar'),
                onPressed: clearSelection,
              )
            : Container(),
        Text('Imagenes subidas:'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Subir anuncio',
          style: TextStyle(
            color: Color.fromRGBO(52, 52, 52, 1),
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color.fromRGBO(52, 52, 52, 1)),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          uploadProperty(
              area,
              communityCosts,
              description,
              electricityCosts,
              elevator,
              furnished,
              height,
              user.uid,
              location,
              nBaths,
              nRooms,
              onSell,
              parking,
              pets,
              photos,
              price,
              title,
              type,
              waterCosts,
              wifi,
              yearBuilt,
              user.uid);
        },
        label: Text('Subir anuncio'),
        backgroundColor: Color.fromRGBO(238, 105, 110, 1),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          children: [
            seleccionAlquilerVenta(),
            Container(
              child: Text(
                '¿Qué tipo de inmueble quiere anunciar?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 20, left: 10, bottom: 20),
            ),
            seleccionTipoInmueble(),
            Container(
              child: Text(
                'Número de habitaciones',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 10, top: 20),
            ),
            seleccionarNumeroHabs(),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 10),
              child: Text(
                'Número de baños',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            seleccionarNumeroBanos(),
            seleccionarTieneAscensor(),
            seleccionarSuperficie(),
            seleccionarParking(),
            seleccionarTitulo(),
            seleccionarDescripcion(),
            seleccionarUbicacion(),
            seleccionarAnoConstruccion(),
            Visibility(
              visible: typePropertyList[0],
              child: seleccionarAltura(),
            ),
            Visibility(
              visible: typeOfLoan,
              child: seleccionarPrecioOnLoan(),
            ),
            Visibility(
              visible: !typeOfLoan,
              child: seleccionarPrecioOnRent(),
            ),
            Visibility(
              visible: typeOfLoan,
              child: seleccionarMascotas(),
            ),
            Visibility(
              visible: typeOfLoan,
              child: seleccionarWifi(),
            ),
            Visibility(
              visible: typeOfLoan,
              child: seleccionarCostesComunidad(),
            ),
            Visibility(
              visible: typeOfLoan,
              child: seleccionarCostesElectricidad(),
            ),
            Visibility(
              visible: typeOfLoan,
              child: seleccionarCostesAgua(),
            ),
            Container(
              child: Center(
                child: seleccionarImagenes(),
              ),
              margin: EdgeInsets.only(top: 30),
            ),
            SizedBox(
              height: 200.0,
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: photos.length,
                itemBuilder: (BuildContext context, int index) => Card(
                  child: Center(
                    child: Image.network(photos[index]),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
