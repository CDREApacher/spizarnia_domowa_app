import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:spizarnia_domowa_app/screens/lista_kategorii.dart';

import 'package:spizarnia_domowa_app/widget/custom_button.dart';
import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/model/produkt_zakupy.dart';
import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';

import 'package:spizarnia_domowa_app/screens/add_produkt.dart';
import 'package:spizarnia_domowa_app/screens/produkt_detail.dart';
import 'package:spizarnia_domowa_app/screens/lista_zakupow.dart';

class Home extends StatelessWidget{

  final nameController = TextEditingController();
  final iloscController = TextEditingController();

  final ProduktController produktController = ProduktController.to;

  onItemPressed(Produkt produkt) {
    nameController.text = produkt.nazwaProduktu;
    iloscController.text = produkt.ilosc.toString();

    produktController.setSelected(produkt);
  }

  onAddPressed() {
    Produkt produkt = new Produkt(
        nazwaProduktu: nameController.text,
        ilosc: int.parse(iloscController.text)
    );
    onClearPressed();
    produktController.addProdukt(produkt);
  }

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
  }

  onKategoriePressed(String kategoria) {
    produktController.fetchProduktyKategorii(kategoria);
  }

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

  @override
  Widget build(BuildContext context) {
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
              .push(context, MaterialPageRoute(builder: (context) => AddProdukt()))
              .then((value) => onRefreshPressed());// Navigator
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,



///////////////////////////////////////////////////////////

      body: Container(
        padding: EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[



            // Column child # 1
            // Grab all the categories from the database
            /*
            GetBuilder<ProduktController>(
                builder: (produktController) =>

                    Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                /*
                                Card(
                                  color: Colors.lightBlueAccent,
                                  child: SizedBox.expand(
                                    child: Text(produktController.kategorie[index].nazwa),
                                    ),
                                  ),
                                */

                                SizedBox(
                                  width: 300,

                                  child: InkWell(
                                    onTap: () {},

                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,

                                      children: [



                                        Container(
                                          //padding: EdgeInsets.only(bottom:10,top:10,left:10,right: 10),
                                          //width: 200,
                                          margin: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.red, width: 2.0),
                                            borderRadius: BorderRadius.circular(5)
                                          ),

                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                            children: [

                                              Text(produktController.kategorie[index].nazwa),
                                              Text(produktController.kategorie[index].lista),


                                              //////////////////////////////////////////////////////////////////////
                                              /*
                                              ListView.builder(
                                                  itemCount: produktController.produkty.length,
                                                  itemBuilder: (context, index2) {
                                                      return ListTile(
                                                        title: Text(produktController.produkty[index2].nazwaProduktu),
                                                      );
                                                  }
                                              ),*/





                                              /*
                                              GetBuilder<ProduktController>(
                                                builder: (produktController) =>

                                                    Expanded(

                                                      child: ListView.separated(
                                                          itemBuilder: (context, index2) => Row(

                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [

                                                              SizedBox(
                                                                width:200,

                                                                child: InkWell(
                                                                  onTap: () {

                                                                    Navigator
                                                                        .push(
                                                                        context,
                                                                        MaterialPageRoute(builder: (context) => ProduktDetail(chosen_produkt: produktController.produkty[index2]))) // push
                                                                        .then(
                                                                            (value) => onRefreshPressed()
                                                                    );//Navigator
                                                                  }, //onTap

                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [

                                                                      SizedBox(height: 8),

                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [

                                                                          Text(produktController.produkty[index2].nazwaProduktu),

                                                                          Text(produktController.produkty[index2].ilosc.toString() + ' ' + produktController.produkty[index2].miara),

                                                                        ],
                                                                      ),

                                                                      SizedBox(height: 8),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),

                                                              IconButton(
                                                                  icon: Icon(Icons.arrow_forward_ios_rounded),
                                                                  onPressed: () => {} //onDeletePressed(produktController.produkty[index].objectId),
                                                              ),
                                                            ], // Children
                                                          ),

                                                          separatorBuilder: (context, index) =>
                                                              Divider(color: Colors.black),
                                                          itemCount: produktController.produkty.length),
                                                    ),
                                              ),*/
                                              ///////////////////////////////////////////////////


                                              //Text(produktController.kategorie[index].lista),




                                              // Here we need the products belonging to this category !!!!!!!!
                                              //function to update produkts in category

                                              //onKategoriePressed(produktController.kategorie[index].nazwa),



                                              /*
                                              GetBuilder<ProduktController>(
                                                  builder: (produktController) =>



                                                      Expanded(
                                                        child: ListView.separated(

                                                            itemBuilder: (context, index) => Row(

                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                                              children: [

                                                                Text(produktController.produktyKategorii[index].nazwaProduktu),

                                                              ],

                                                            ),

                                                            separatorBuilder: (context, index) =>
                                                                Divider(color: Colors.black),

                                                            itemCount: produktController.produktyKategorii.length,
                                                        ),
                                                      ),
                                              ),*/












                                            ],
                                          ),

                                        ),

                                      ],
                                    ),

                                  ),
                                ),

                              ],
                            ),

                            separatorBuilder: (context, index) =>
                              Divider(color: Colors.black),

                            itemCount: produktController.kategorie.length,
                        )
                    ),
            ),*/


            // Wyświetl produkty kategorii nabiał

            /*GetBuilder<ProduktController>(
                builder: (produktController) =>

                    Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                Text(produktController.produktyKategorii[index].nazwaProduktu),
                              ],
                            ),

                            separatorBuilder: (context, index) =>
                                Divider(color: Colors.black),

                            itemCount: produktController.produktyKategorii.length
                        ),
                    ),

            ),*/





            // Column child # 2
            // Get all the products from the database
            GetBuilder<ProduktController>(
              builder: (produktController) =>

                  Expanded(

                    child: ListView.separated(
                        itemBuilder: (context, index) => Row(

                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            IconButton(
                                icon: Icon(Icons.add_business_rounded),
                                onPressed: () => {
                                  showDialog(context: context, builder: (_) => AlertDialog(
                                    title: Text('Dodaj '+ produktController.produkty[index].nazwaProduktu + ' do listy zakupów. ('+ produktController.produkty[index].miara+')'),
                                    content:  SpinBox(
                                      value: 0,
                                      min: 0,
                                      max: 2048,
                                      onChanged: (value) {
                                        print(value);
                                        int val = value.toInt();
                                        iloscController.text = val.toString();
                                      },
                                    ),

                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            onAddZakupPressed(produktController.produkty[index]);
                                            Navigator.pop(context);
                                          },


                                          child: Text('Dodaj')
                                      ),
                                    ],
                                   // elevation: 5.0,
                                    backgroundColor: Colors.white,
                                  ),
                                  ), //showDialog

                                } //onDeletePressed(produktController.produkty[index].objectId),
                            ),

                            SizedBox(
                              width:200,

                              child: InkWell(
                                onTap: () {


                                  Navigator
                                      .push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ProduktDetail(chosen_produkt: produktController.produkty[index]))) // push
                                      .then(
                                          (value) => onRefreshPressed()
                                  );//Navigator


                                }, //onTap

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    SizedBox(height: 8),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Text(produktController.produkty[index].nazwaProduktu),

                                        Text(produktController.produkty[index].ilosc.toString() + ' ' + produktController.produkty[index].miara),

                                      ],
                                    ),

                                    SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            ),

                            IconButton(
                              icon: Icon(Icons.arrow_forward_ios_rounded),
                              onPressed: () => {


                              } //onDeletePressed(produktController.produkty[index].objectId),
                            ),

                          ], // Children
                        ),

                        separatorBuilder: (context, index) =>
                            Divider(color: Colors.black),
                        itemCount: produktController.produkty.length),
                  ),
            ),

            // Column child end
          ],

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
                    .then((value) => null);


              },
            ),

            ListTile(
              title: Text('Miary'),
              onTap: () {

                Navigator.pop(context);

                // Go to the new screen containing Miary
                /*
                Navigator
                    .push(context, MaterialPageRoute(builder: (context) => ListaZakupow()))
                    .then((value) => null);
                */

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


          ],


        ),

      ),


    );
  }// Widget build

}// class Home