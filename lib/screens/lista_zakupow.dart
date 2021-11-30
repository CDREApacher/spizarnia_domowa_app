import 'dart:io';

import 'package:flutter/material.dart';

//import 'package:flutter/scheduler.dart';

import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';

import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/model/produkt_zakupy.dart';
import 'package:spizarnia_domowa_app/model/shopping_list.dart';

import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';
import 'package:spizarnia_domowa_app/screens/add_existing_zakupy.dart';
import 'package:spizarnia_domowa_app/screens/home_main.dart';

import 'package:spizarnia_domowa_app/screens/produkt_detail.dart';
import 'package:spizarnia_domowa_app/screens/zakup_detail.dart';
import 'package:spizarnia_domowa_app/screens/tryb_zakupow.dart';
import 'package:spizarnia_domowa_app/screens/home.dart';

// Debug
import 'package:logger/logger.dart';

import 'lista_kategorii.dart';
import 'lista_miar.dart';

class ListaZakupow extends StatefulWidget{

  @override
  _ListaZakupow createState() => _ListaZakupow();

}

class _ListaZakupow extends State<ListaZakupow>{

  Logger logger = Logger();

  final ProduktController produktController = ProduktController.to;

  onRefreshPressed() {
    produktController.fetchZakupy();
  }


  onDeleteZakup(String objectId){

    showDialog(context: context, builder: (_) =>
        AlertDialog(
          title: Text("Usunąć zakup?"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);// close popup
                },
                child: Text('Anuluj')
            ),
            TextButton(
                onPressed: () {
                  produktController.deleteZakup(objectId);
                  Navigator.pop(context);// close popup
                },
                child: Text('Usuń')
            ),
          ],
        ),
    );
  }




  @override
  void initState() {
    produktController.fetchZakupy();
    logger.d(produktController.listaZakupow);
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

                produktController.doKupienia.clear();
                produktController.zakupyWyswietlaj.clear();
                if(produktController.zakupyWyswietlaj.isEmpty){
                  produktController.zakupyWyswietlaj = RxList.from(produktController.listaZakupow);
                }


                Navigator
                  .push(context, MaterialPageRoute(builder: (context) => TrybZakupow()))
                  .then((value) => onRefreshPressed());// Navigator
            },
          ),
        ],
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {

          Navigator
              .push(context, MaterialPageRoute(builder: (context) => AddExistingZakupy()))
              .then((value) => onRefreshPressed());// Navigator


        },
      ),
    ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,




      body: GetBuilder<ProduktController>(
        builder: (produktController) =>
            GroupedListView<ShoppingList, String>(

              elements: produktController.listaZakupow,
              groupBy: (zakup) {
                return zakup.produkt.kategorieZakupy.nazwa;
              },
              useStickyGroupSeparators: true,


              groupHeaderBuilder: (ShoppingList zakup) => Padding(
                padding: const EdgeInsets.all(8.0),

                child: Text(
                  zakup.produkt.kategorieZakupy.nazwa,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              itemBuilder: (context, ShoppingList zakup) {
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
                                      onDeleteZakup(zakup.objectId);
                                    },
                                  ),

                                  Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                            child: Text(zakup.produkt.nazwaProduktu + ' : ' + zakup.quantityToBuy.toString() + ' ' + zakup.produkt.miara.miara),
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
              title: Text('Home'),// Here HomeMain
              onTap: () {
                Get.back();
                Get.offAll(HomeMain()); // offAll to avoid the weird red bug screen
              },
            ),

            ListTile(
              title: Text('Lista Zakupów'),
              onTap: () {
                Get.back();
                // We are already here
              },
            ),

            ListTile(
              title: Text('Miary'),
              onTap: () {
                Get.back();
                Get.to(() => ListaMiar());
              },
            ),

            ListTile(
              title: Text('Kategorie'),
              onTap: () {
                Get.back();
                Get.to(() => ListaKategorii());
              },
            ),

          ], // children
        ),
      ),

    );
  }
}