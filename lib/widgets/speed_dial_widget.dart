import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SpeedDialWidget extends StatefulWidget {
  @override
  _SpeedDialWidgetState createState() => _SpeedDialWidgetState();
}

class _SpeedDialWidgetState extends State<SpeedDialWidget> {
  static void llamarNumero(int telefono) async {
    await canLaunch('tel: +34 $telefono')
        ? await launch('tel: +34 $telefono')
        : throw 'Could not launch tel: +34 $telefono';
  }

  static void enviarSMS(int telefono) async {
    await canLaunch('sms:$telefono')
        ? await launch('sms:$telefono')
        : throw 'Could not launch sms:$telefono';
  }

  static void enviarCorreo(String correo) async {
    await canLaunch('mailto:$correo?subject=Me interesa su piso')
        ? await launch('mailto:$correo?subject=Me interesa su piso')
        : throw 'Could not launch mailto:$correo?subject=Me interesa su piso';
  }

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      backgroundColor: Color.fromRGBO(255, 105, 110, 1),
      icon: Icons.contact_page,
      iconTheme: IconThemeData(
        size: 40,
        color: Colors.white,
      ),
      activeIcon: Icons.close_rounded,
      childMarginBottom: 10,
      tooltip: 'Contacto',
      overlayColor: Colors.grey,
      overlayOpacity: 0.3,
      children: [
        SpeedDialChild(
          child: Icon(Icons.phone),
          backgroundColor: Color.fromRGBO(238, 105, 110, 1),
          foregroundColor: Colors.white,
          label: 'Telefóno',
          labelBackgroundColor: Color.fromRGBO(238, 105, 110, 1),
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          onTap: () => llamarNumero(601048715),
        ),
        SpeedDialChild(
          child: Center(child: FaIcon(FontAwesomeIcons.sms)),
          backgroundColor: Color.fromRGBO(238, 105, 110, 1),
          foregroundColor: Colors.white,
          label: 'SMS',
          labelBackgroundColor: Color.fromRGBO(238, 105, 110, 1),
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          onTap: () => enviarSMS(601048715),
        ),
        SpeedDialChild(
          child: Icon(Icons.mail_outlined),
          backgroundColor: Color.fromRGBO(238, 105, 110, 1),
          foregroundColor: Colors.white,
          label: 'Correo',
          labelBackgroundColor: Color.fromRGBO(238, 105, 110, 1),
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          onTap: () => enviarCorreo('javierrdelatorre@gmail.com'),
        ),
      ],
    );
  }
}
