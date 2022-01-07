import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:jeveux_2020/employe/model/article.dart';
import 'package:jeveux_2020/employe/model/databaseClient.dart';
import 'package:image_picker/image_picker.dart';


DateTime dateTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
var formate1 = "${dateTime.day}-${dateTime.month}-${dateTime.year}";

class Ajout extends StatefulWidget {

  int id;

  Ajout(int id) {
    this.id = id;
  }

  @override
  _AjoutState createState() => new _AjoutState();

}

class _AjoutState extends State<Ajout> {

  String status;
  String date;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Ajouter'),
        actions: <Widget>[
          new FlatButton(onPressed: ajouter, child: new Text('Valider', style: new TextStyle(color: Colors.white),))
        ],
      ),
      body: new SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: new Column(
            children: <Widget>[
              new Text('Article à ajouter', textScaleFactor: 1.4, style: new TextStyle(color: Colors.red, fontStyle: FontStyle.italic),),
              new Card(
                elevation: 10.0,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    textField(TypeTextField.status, 'Status'),
                    textField(TypeTextField.date, 'Date (31-01-2022)'),
                    //textField(TypeTextField.date, 'Date')
                  ],
                ),
              )
            ]

        ),
      ),
    );
  }

  TextField textField(TypeTextField type, String label) {
    DateTime dateTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    var formate1 = "${dateTime.day}-${dateTime.month}-${dateTime.year}";

    return new TextField(
      decoration: new InputDecoration(labelText: label),
      onChanged: (String string) {
        switch (type) {
          case TypeTextField.status:
            status = string;
            break;
          case TypeTextField.date:
            date = string;
            break;
        }
      },
    );
  }

  void ajouter() {
    
    DateTime dateTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    var formate1 = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    print('Ajouter');
    if (status != null) {
      Map<String, dynamic> map = { 'status': status, 'item': widget.id};
      if (date != null) {
        map['date'] = date;
      }
      Article article = new Article();
      article.fromMap(map);
      DatabaseClient().upsertArticle(article).then((value) {
        status = null;
        date = formate1;
        Navigator.pop(context);
      });
    }
  }

}

enum TypeTextField {status, date}