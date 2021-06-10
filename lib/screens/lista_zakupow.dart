import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';

import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/model/produkt_zakupy.dart';

import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';

import 'package:spizarnia_domowa_app/screens/produkt_detail.dart';
import 'package:spizarnia_domowa_app/screens/zakup_detail.dart';
import 'package:spizarnia_domowa_app/screens/tryb_zakupow.dart';
import 'package:spizarnia_domowa_app/screens/lista_kategorii.dart';
import 'package:spizarnia_domowa_app/screens/add_existing_zakupy.dart';
import 'package:spizarnia_domowa_app/screens/add_produkt.dart';
import 'package:spizarnia_domowa_app/screens/produkt_detail.dart';
import 'package:spizarnia_domowa_app/screens/lista_zakupow.dart';
import 'package:spizarnia_domowa_app/screens/lista_miar.dart';

import 'package:spizarnia_domowa_app/screens/home.dart';

// Debug
import 'package:logger/logger.dart';

class ListaZakupow extends StatefulWidget{
  @override
  _ListaZakupow createState() => _ListaZakupow();

}

class _ListaZakupow extends State<ListaZakupow>{

  Logger logger = Logger(); // TODO remove debug

  final ProduktController produktController = ProduktController.to;

  onRefreshPressed() {
    produktController.fetchZakupy();
  }

  onDeleteZakup(String objectId){
    produktController.deleteZakup(objectId);
  }

  @override
  void initState() {
    produktController.fetchZakupy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 42.5,
        title: Text("Lista Zakupów"),

        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.shopping_cart_rounded),
              tooltip: "Tryb zakupów",
              onPressed: () {
                if(produktController.zakupyWyswietlaj.isEmpty){
                  produktController.zakupyWyswietlaj = produktController.zakupy.map((v) => v).toList();
                }

                Navigator
                  .push(context, MaterialPageRoute(builder: (context) => TrybZakupow()))
                  .then((value) => onRefreshPressed());// Navigator
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {

          Navigator
              .push(context, MaterialPageRoute(builder: (context) => AddExistingZakup()))
              .then((value) => null);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

      body: GetBuilder<ProduktController>(
        builder: (produktController) =>
            GroupedListView<ProduktZakupy, String>(

              elements: produktController.zakupy,
              groupBy: (zakup) {
                return zakup.kategoriaZakupy;
              },
              useStickyGroupSeparators: true,


              groupHeaderBuilder: (ProduktZakupy zakup) => Padding(
                padding: const EdgeInsets.all(8.0),

                child: Text(
                  zakup.kategoriaZakupy,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              itemBuilder: (context, ProduktZakupy zakup) {
                return Container(
                    height: 60,
                    child: Card(

                      elevation: 5.0,
                      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Expanded(
                            child: InkWell(
                              onTap: () {

                                Navigator
                                  .push(context, MaterialPageRoute(builder: (context) => ZakupDetail(chosen_produkt: zakup)))
                                  .then((value) => onRefreshPressed());

                              },

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.delete),

                                    onPressed: () {
                                      // TODO add confirmation on delete
                                      onDeleteZakup(zakup.objectId);
                                    },
                                  ),

                                  Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                            child: Text(zakup.nazwaProduktu + ' : ' + zakup.ilosc.toString() + ' ' + zakup.miara),
                                          ),

                                          Icon(Icons.arrow_forward_ios_rounded),
                                        ],
                                      ),
                                  ),

                                ],
                              ),

                            ),
                          ),

                        ],
                      ),

                    ),

                );

              }, // itemBuilder
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
              title: Text('Lista Produktów'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator
                    .push(context, MaterialPageRoute(builder: (context) => Home()))
                    .then((value) => null);


              },
            ),

            ListTile(
              title: Text('Lista Zakupów'),
              onTap: () {
                Navigator.pop(context);
                // Go to the new screen lista_zakupow.dart
                Navigator
                    .push(context, MaterialPageRoute(builder: (context) => ListaZakupow()))
                    .then((value) => null);
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
  }
}