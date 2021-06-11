// Built in
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:uuid/uuid.dart';

// Custom Widgets
import 'package:spizarnia_domowa_app/widget/custom_button.dart';

// Modles
import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/model/produkt_zakupy.dart';



import 'package:spizarnia_domowa_app/model/kategoria.dart';
import 'package:spizarnia_domowa_app/model/kategoria_zakupy.dart';
import 'package:spizarnia_domowa_app/model/miara.dart';
import 'package:spizarnia_domowa_app/model/shopping_list.dart';




// Controller
import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';

// Screens Widgets
import 'package:spizarnia_domowa_app/screens/lista_kategorii.dart';
import 'package:spizarnia_domowa_app/screens/add_produkt.dart';
import 'package:spizarnia_domowa_app/screens/produkt_detail.dart';
import 'package:spizarnia_domowa_app/screens/lista_zakupow.dart';
import 'package:spizarnia_domowa_app/screens/lista_miar.dart';
import 'package:spizarnia_domowa_app/screens/add_existing_produkt.dart';

// Debug
import 'package:logger/logger.dart';



class Home extends StatelessWidget{

  var uuid = Uuid();

  final nameController = TextEditingController();
  final iloscController = TextEditingController();

  final ProduktController produktController = ProduktController.to;

  // Debug
  Logger logger = Logger();
  //


  onItemPressed(Produkt produkt) {
    nameController.text = produkt.nazwaProduktu;
    iloscController.text = produkt.ilosc.toString();

    produktController.setSelected(produkt);
  }

  /*
  onAddPressed() {
    Produkt produkt = new Produkt(
        nazwaProduktu: nameController.text,
        ilosc: int.parse(iloscController.text)
    );
    onClearPressed();
    produktController.addProdukt(produkt);
  }
  */

  onDeletePressed(String id) {
    onClearPressed();
    produktController.deleteProdukt(id);
  }

  onUpdatePressed(String id) {
    Produkt produkt = new Produkt(
        nazwaProduktu: nameController.text,
        ilosc: int.parse(iloscController.text)
    );


    onClearPressed();

    produktController.updateProdukt(id, produkt);
  }

  onClearPressed() {
    nameController.clear();
    iloscController.clear();

    produktController.clearSelected();
  }

  onRefreshPressed() {
    produktController.refreshAllProdukts();
    //logger.d(produktController.produkty);
  }

  onKategoriePressed(String kategoria) {
    produktController.fetchProduktyKategorii(kategoria);
  }


  /*
  onAddZakupPressed(Produkt produkt) {
    ProduktZakupy zakup = new ProduktZakupy(

        nazwaProduktu: produkt.nazwaProduktu,
        miara: produkt.miara,
        kategoriaZakupy: produkt.kategorieZakupy,
        ilosc: int.parse(iloscController.text),
        objectIdProduktu : produkt.objectId,

    );
    produktController.addNewZakup(zakup);
  }
  */


  onAddZakupPressed(Produkt produkt){

    ShoppingList listaZakupow = new ShoppingList(
      objectId: uuid.v4(),
      quantityToBuy: int.parse(iloscController.text),
      produkt: produkt,
    );

    produktController.addNewZakup(listaZakupow);
  }


  @override
  Widget build(BuildContext context) {
    onRefreshPressed();
    produktController.update();
    return Scaffold(

//////////////////////////////////////////////////////////

      appBar: AppBar(

        toolbarHeight: 42.5,

        title: Text('Spiżarnia Domowa'),

        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            tooltip: "Odśwież listę",
            onPressed: () => {
              onRefreshPressed(),
              //onKategoriePressed("nabiał"),
            }
          ),
        ],

      ),

//////////////////////////////////////////////////////////

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator
              .push(context, MaterialPageRoute(builder: (context) => AddExistingProduct()))
              .then((value) => onRefreshPressed());// Navigator
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

///////////////////////////////////////////////////////////



      body: GetBuilder<ProduktController>(
        builder: (produktController) =>
            GroupedListView<Produkt, String>(

              elements: produktController.produkty,
              groupBy: (produkt) {
                return produkt.kategorieProdukty.nazwa;
              },
              useStickyGroupSeparators: true,

              groupHeaderBuilder: (Produkt produkt) => Padding(
                padding: const EdgeInsets.all(8.0),

                child: Text(
                  produkt.kategorieProdukty.nazwa,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              itemBuilder: (context, Produkt produkt) {
                return Card(
                  elevation: 5.0,
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      IconButton(
                          icon: Icon(Icons.add_business_rounded),
                          onPressed: () => {

                            showDialog(context: context, builder: (_) =>
                                AlertDialog(
                                  title: Text('Dodaj ' + produkt.nazwaProduktu + ' do listy zakupów. (' + produkt.miara.miara + ')'),
                                  content: SpinBox(
                                    value: 0,
                                    min: 0,
                                    max: 2048,
                                    onChanged: (value) {
                                      print(value); // TODO remove debug print
                                      int val = value.toInt();
                                      iloscController.text = val.toString();
                                    },
                                  ),

                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          onAddZakupPressed(produkt);
                                          Navigator.pop(context);
                                        },
                                        child: Text('Dodaj')
                                    ),
                                  ],

                                ),
                            ), // showDialog

                          } // onPressed
                      ),

                      Expanded(
                        child: InkWell(
                          onTap: () {
                            //onRefreshPressed();
                            Navigator
                                .push(context, MaterialPageRoute(builder: (context) => ProduktDetail(chosen_produkt: produkt)))
                                .then((value) => onRefreshPressed());
                          },

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(produkt.nazwaProduktu + ' : ' + produkt.ilosc.toString() + ' ' + produkt.miara.miara),
                              Icon(Icons.arrow_forward_ios_rounded),
                            ],
                          ),

                        ),
                      ),

                    ],
                  ),

                );
              }, // itemBuilder
            ),
      ),

/////////////////////////////////////////////////////////////////////////

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
                Navigator.pop(context);
                // We're already here so do nothing but close the drawer

              },
            ),

            ListTile(
              title: Text('Lista Zakupów'),
              onTap: () {
                Navigator.pop(context);
                // Go to the new screen lista_zakupow.dart
                Navigator
                    .push(context, MaterialPageRoute(builder: (context) => ListaZakupow()))
                    .then((value) => onRefreshPressed());
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
  }// Widget build

}// class Home