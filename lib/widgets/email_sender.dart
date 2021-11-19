import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter/material.dart';

class EmailSender extends StatefulWidget {
  Locale loc;
  static EmailSender _instance;
  factory EmailSender() => _instance ??= new EmailSender._();

  void init(Locale loc) {
    this.loc = loc;
  }

  EmailSender._();
  @override
  _EmailSenderState createState() => _EmailSenderState();
}

class _EmailSenderState extends State<EmailSender> {
  List<String> toStringList(List<dynamic> list) {
    var stringList = <String>[];
    for (int i = 0; i < list.length; i++) {
      stringList.add(list[i]);
    }
    return stringList;
  }

  void sendEmails() async {
    QuerySnapshot documentList =
        await Firestore.instance.collection('users').getDocuments();
    List<DocumentSnapshot> docSnapshots = documentList.documents;
    var length = docSnapshots.length;
    var emails = [];
    for (var i = 0; i < length; i++) {
      emails.add(docSnapshots[i].data['email']);
      print(emails);
    }
    emails = toStringList(emails);
    // ignore: deprecated_member_use
    final smtpServer = gmail('trobifybyKubo@gmail.com', 'KuboFC2021');
    final message = Message()
      ..from = Address('trobifybyKubo@gmail.com', 'Trobify')
      ..recipients.addAll(emails)
      ..subject = 'Nuevo anuncio publicado en Trobify!'
      ..text =
          'Se ha publicado un nuevo anuncio en Trobify que hemos pensado que podria interesarte\nVe y echale un vistazo!\nUn saludo\nEl equipo de Trobify!';
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    sendEmails(); //ONACTION
    return Text('Se han enviado los emails!');
  }
}
