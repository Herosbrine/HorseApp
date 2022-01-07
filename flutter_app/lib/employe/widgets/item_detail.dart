import 'package:flutter/material.dart';
import 'package:jeveux_2020/model/item.dart';
import 'package:jeveux_2020/employe/model/article.dart';
import 'donnees_vides.dart';
import 'ajout_article.dart';
import 'package:jeveux_2020/employe/model/databaseClient.dart';
import 'dart:io';

class ItemDetail extends StatefulWidget {
  Item item;

  ItemDetail(Item item) {
    this.item = item;
  }

  @override
  _ItemDetailState createState() => new _ItemDetailState();

}

class _ItemDetailState extends State<ItemDetail> {
  List<Article> articles;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseClient().allArticles(widget.item.id).then((liste) {
      setState(() {
        articles = liste;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    var formate1 = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.item.nom),
          actions: <Widget>[
            new FlatButton(onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                return new Ajout(widget.item.id);
              })).then((value) {
                print('On est de retour');
                DatabaseClient().allArticles(widget.item.id).then((liste) {
                  setState(() {
                    articles = liste;
                  });
                });
              });
            },
                child: new Text('ajouter', style: new TextStyle(color: Colors.white),))
          ],
        ),
        body: (articles == null || articles.length == 0)
            ? new DonneesVides()
            : new GridView.builder(
            itemCount: articles.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, i) {
              Article article = articles[i];
              return new Card(
                  child: new Column(
                    children: <Widget>[
                      new Text((article.status == null)? 'Aucun status renseigné': "Status: ${article.status}", style: TextStyle(fontSize: 25),),
                      new Text((article.date == null)? 'Date $formate1': "Date: ${article.date}", style: TextStyle(fontSize: 25),)
                    ],
                  ),
              );
            })
    );
  }

}