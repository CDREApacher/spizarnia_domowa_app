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
import 'package:spizarnia_domowa_app/model/shopping_list.dart';
import 'package:spizarnia_domowa_app/model/grupa.dart';

// Controller
import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';

// Screens Widgets
import 'package:spizarnia_domowa_app/screens/lista_kategorii.dart';
import 'package:spizarnia_domowa_app/screens/lista_zakupow.dart';
import 'package:spizarnia_domowa_app/screens/lista_miar.dart';
import 'package:spizarnia_domowa_app/screens/tryb_zakupow.dart';
import 'package:spizarnia_domowa_app/screens/home.dart';
import 'package:spizarnia_domowa_app/screens/add_produkt.dart';
import 'package:spizarnia_domowa_app/screens/add_new_zakupy.dart';

// Debug
import 'package:logger/logger.dart';



class AddExistingZakupy extends StatelessWidget{

  var uuid = Uuid();


  final nameController = TextEditingController(); //
  final ProduktController produktController = ProduktController.to;
  final iloscController = TextEditingController();

  onUpdatePressed(Produkt chosen_produkt) {


    Produkt produkt = new Produkt(
      objectId: chosen_produkt.objectId, //
      nazwaProduktu: chosen_produkt.nazwaProduktu, //
      ilosc: int.parse(iloscController.text), //

      progAutoZakupu: chosen_produkt.progAutoZakupu, //
      autoZakup: chosen_produkt.autoZakup, //

      miara: chosen_produkt.miara,
      kategorieProdukty: chosen_produkt.kategorieProdukty,
      kategorieZakupy: chosen_produkt.kategorieZakupy,

      atrybuty: chosen_produkt.atrybuty, //
    );

    //produktController.addProdukt(produkt);
    produktController.updateProdukt(produkt.objectId, produkt);
  }


  onAddZakupPressed(Produkt produkt){

    Grupa grupaZakupu = new Grupa(
      nazwa_server: produktController.currentlyChosenGroupName,
      kod_grupy: produktController.currentlyChosenGroupCode,
    );

    ShoppingList listaZakupow = new ShoppingList(
      objectId: uuid.v4(),
      quantityToBuy: int.parse(iloscController.text),
      produkt: produkt,
      grupa: grupaZakupu,
    );

    produktController.addNewZakup(listaZakupow);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(


//////////////////////////////////////////////////////////
      appBar: AppBar(

        toolbarHeight: 42.5,

        title: Text('Produkty'),

      ),

      floatingActionButton: Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator
              .push(context, MaterialPageRoute(builder: (context) => AddNewZakup()))
              .then((value) => null);// Navigator
        },
      ),
    ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//////////////////////////////////////////////////////////
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
                                      showDialog(context: context, builder: (_) =>
                                          AlertDialog(
                                            title: Text('Ilo???? ' +  produktController.produkty[index].nazwaProduktu + ' do listy produkt??w. (' +  produktController.produkty[index].miara.miara + ')'),
                                            content: SpinBox(
                                              value: 0,//double.parse(produktController.produkty[index].ilosc.toString()),
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
                                                    //onUpdatePressed(produktController.produkty[index]);



                                                    onAddZakupPressed(produktController.produkty[index]);





                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: Text("Dodano "  +  produktController.produkty[index].nazwaProduktu + ": "  + iloscController.text + " " +  produktController.produkty[index].miara.miara ),
                                                        duration: Duration(seconds: 5),
                                                      ),
                                                    );
                                                    Navigator.pop(context);
                                                    //Navigator.pop(context);

                                                  },
                                                  child: Text('Dodaj')
                                              ),
                                            ],

                                          ),
                                      );
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
/////////////////////////////////////////////////////////////////////////
    );
  }// Widget build

}// class