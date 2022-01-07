import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:jeveux_2020/model/article.dart';
import 'package:jeveux_2020/model/databaseClient.dart';
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

  String image;
  String nom;
  String magasin;
  String prix;
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
                    textField(TypeTextField.nom, 'Performance'),
                    textField(TypeTextField.prix, 'Poid'),
                    textField(TypeTextField.magasin, 'Distance'),
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
          case TypeTextField.nom:
            nom = string;
            break;
          case TypeTextField.prix:
            prix = string;
            break;
          case TypeTextField.magasin:
            magasin = string;
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
    if (nom != null) {
      Map<String, dynamic> map = { 'nom': nom, 'item': widget.id};
      if (magasin != null) {
        map['magasin'] = magasin;
      }
      if (prix != null) {
        map['prix'] = prix;
      }
      if (image != null) {
        map['image'] = image;
      }
      if (date != null) {
        map['date'] = date;
      }
      Article article = new Article();
      article.fromMap(map);
      DatabaseClient().upsertArticle(article).then((value) {
        image = null;
        nom = null;
        magasin = null;
        prix = null;
        date = formate1;
        Navigator.pop(context);
      });
    }
  }

  Future getImage(ImageSource source) async {
    var nouvelleIMage = await ImagePicker.pickImage(source: source);
    setState(() {
      image = nouvelleIMage.path;
    });
  }

}

enum TypeTextField { nom, prix, magasin, date}