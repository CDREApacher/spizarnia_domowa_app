import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinbox/material.dart';

import 'package:uuid/uuid.dart';

import 'package:spizarnia_domowa_app/widget/custom_button.dart';
import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/model/miara.dart';
import 'package:spizarnia_domowa_app/model/kategoria_zakupy.dart';
import 'package:spizarnia_domowa_app/model/kategoria.dart';
import 'package:spizarnia_domowa_app/model/atrybuty.dart';
import 'package:spizarnia_domowa_app/screens/lista_zakupow.dart';
import 'package:spizarnia_domowa_app/screens/lista_miar.dart';
import 'package:spizarnia_domowa_app/screens/lista_kategorii.dart';
import 'package:spizarnia_domowa_app/screens/group_detail.dart';


import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';

import 'package:spizarnia_domowa_app/screens/home.dart';
import 'package:spizarnia_domowa_app/screens/home_main.dart';

class ListaGrup extends StatefulWidget {

  @override
  _ListaGrupState createState() => _ListaGrupState();
}



class _ListaGrupState extends State<ListaGrup> {


  final ProduktController produktController = ProduktController.to;


  @override
  void initState(){


    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 42.5,
        title: Text('Lista Grup'),

      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator
              .push(context, MaterialPageRoute(builder: (context) => GroupDetail()))
              .then((value) => null);// Navigator
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: Container(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /*TextField(
          controller: nameController,
          decoration: InputDecoration(hintText: "Nazwa"),
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed:() {
          },
        ),*/

            Expanded(
              child: GetBuilder<ProduktController> (
                  builder: (produktController) =>

                      ListView.builder(
                          itemCount: produktController.produkty.length,
                          itemBuilder: (context, index) =>
                              Container(
                                height: 55,
                                child: Card(
                                  elevation: 5,
                                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),

                                  child: InkWell(
                                    onTap: () {

                                    },
                                    child:Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10 ,vertical: 6),
                                          child: Text(
                                              produktController.produkty[index].nazwaProduktu
                                          ),
                                        ),
                                        Icon(Icons.add_rounded),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                      )
              ),
            ),

          ],

        ),
      ),


      drawer: Drawer(

        child: ListView(
          padding: EdgeInsets.zero,

          children: <Widget>[

            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),

              child: Text('Menu'),
            ),

            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
                // Go to the new screen lista_zakupow.dart
                Navigator
                    .push(context, MaterialPageRoute(builder: (context) => HomeMain()))
                    .then((value) => {});
                // Go to the new screen lista_zakupow.dart
                /*
                Navigator
                    .push(context, MaterialPageRoute(builder: (context) => HomeMain()))
                    .then((value) => onRefreshPressed());
                */
                /*
                SchedulerBinding.instance.addPostFrameCallback((_) {

                    // add your code here.

                    Navigator.push(context, new MaterialPageRoute(builder: (context) => Home()));
                });
                */

              },
            ),

            /*ListTile(
              title: Text('Lista Produktów'),
              onTap: () {
                Navigator.pop(context);
                // Go to the new screen lista_zakupow.dart
                Navigator
                    .push(context, MaterialPageRoute(builder: (context) => Home()))
                    .then((value) => {});
              },
            ),*/
            ListTile(
              title: Text('Lista Zakupów'),
              onTap: () {
                Navigator.pop(context);
                // Go to the new screen lista_zakupow.dart
                Navigator
                    .push(context, MaterialPageRoute(builder: (context) => ListaZakupow()))
                    .then((value) => {});
              },
            ),

            ListTile(
              title: Text('Miary'),
              onTap: () {
                Navigator.pop(context);
                // Go to the new screen containing Miary

                Navigator
                    .push(context, MaterialPageRoute(builder: (context) => ListaMiar()))
                    .then((value) => null);

              },
            ),

            ListTile(
              title: Text('Kategorie'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                // Go to the new screen lista_kategorii.dart
                Navigator
                    .push(context, MaterialPageRoute(builder: (context) => ListaKategorii()))
                    .then((value) => null);
              },
            ),

          ], // children
        ),
      ),
    );

  }}//class AddProdukt