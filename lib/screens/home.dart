import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spizarnia_domowa_app/widget/custom_button.dart';
import 'package:spizarnia_domowa_app/model/produkt.dart';
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
            onPressed: () => onRefreshPressed(),
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


      /*
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () =>  () {
            Navigator
                .push(context, MaterialPageRoute(builder: (context) => AddProdukt()))
                .then((value) => onRefreshPressed());// Navigator
          },

        ),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      */
///////////////////////////////////////////////////////////

      body: Container(
        padding: EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[



            /*
            GetBuilder<ProduktController>(
                builder: (produktController) =>
                    Text(
                        produktController.selectedProduct == null
                            ? ''
                            : produktController.selectedProduct.id,
                    )

            ),

            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: "nazwa"),
            ),

            TextField(
              controller: iloscController,
              decoration: InputDecoration(hintText: "ilosc"),
            ),

            SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

              GetBuilder<ProduktController>(
                builder: (produktController) =>

                  CustomButton(
                    onPressed: produktController.selectedProduct == null
                        ? () => onAddPressed()
                        : null,
                    text: "Add",
                  ),

                ),

                GetBuilder<ProduktController>(
                  builder: (produktController) =>

                  CustomButton(
                   onPressed: produktController.selectedProduct == null
                       ? null
                       : () => onUpdatePressed(produktController.selectedProduct.id),
                   text: "Update",
                  ),

                ),

                  CustomButton(
                    onPressed: () => onClearPressed(),
                   text: "Clear",
                  ),

              ],

            ),

          SizedBox(height: 16),
            */



            GetBuilder<ProduktController>(
              builder: (produktController) =>

                  Expanded(

                    child: ListView.separated(
                        itemBuilder: (context, index) => Row(

                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

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
                              //onPressed: () => onDeletePressed(produktController.produkty[index].objectId),
                            ),

                          ],

                        ),

                        separatorBuilder: (context, index) =>
                            Divider(color: Colors.black),
                        itemCount: produktController.produkty.length),

                  ),

            ),


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
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);

                // Go to the new screen lista_zakupow.dart
                Navigator
                    .push(context, MaterialPageRoute(builder: (context) => ListaZakupow()))
                    .then((value) => null);


              },
            ),

            ListTile(
              title: Text('Edytuj wprowadzone miary'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);

                // Go to the new screen lista_zakupow.dart
                Navigator
                    .push(context, MaterialPageRoute(builder: (context) => ListaZakupow()))
                    .then((value) => null);


              },
            ),

            ListTile(
              title: Text('Edytuj wprowadzone kategorie'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);

                // Go to the new screen lista_zakupow.dart
                Navigator
                    .push(context, MaterialPageRoute(builder: (context) => ListaZakupow()))
                    .then((value) => null);


              },
            ),


          ],


        ),

      ),


    );
  }// Widget build

}// class Home