// Built in
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:grouped_list/grouped_list.dart';

// Custom Widgets
import 'package:spizarnia_domowa_app/widget/custom_button.dart';

// Modles
import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/model/produkt_zakupy.dart';
import 'package:spizarnia_domowa_app/model/grupa.dart';

// Controller
import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';

// Screens Widgets
import 'package:spizarnia_domowa_app/screens/lista_kategorii.dart';
import 'package:spizarnia_domowa_app/screens/lista_zakupow.dart';
import 'package:spizarnia_domowa_app/screens/lista_miar.dart';
import 'package:spizarnia_domowa_app/screens/tryb_zakupow.dart';
import 'package:spizarnia_domowa_app/screens/lista_grup.dart';
import 'package:spizarnia_domowa_app/screens/home.dart';

// Debug
import 'package:logger/logger.dart';
import 'dart:developer';


class HomeMain extends StatelessWidget{


  final ProduktController produktController = ProduktController.to;

  // tmp add a group TODO delete
  dodajGrupe(){
    String nazwa = "Test_z_Apki_LOG";

    produktController.addGrupy(nazwa);
  }
  pokazGrupy(){
    log("lista grup po add");
    log(produktController.listaGrup.toString());
    log("Aktualnie wybrana grupa:");
    log(produktController.currentlyChosenGroupCode);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

//////////////////////////////////////////////////////////
      appBar: AppBar(

        toolbarHeight: 42.5,

        title: Text('Domowa spiżarnia'),

        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.group_add),
            onPressed: () => {
              dodajGrupe()
            },
          ),
          IconButton(
            icon: Icon(Icons.group),
            onPressed: () => {
              pokazGrupy()
            },
          ),


        ],

      ),

//////////////////////////////////////////////////////////
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator
                  .push(context, MaterialPageRoute(builder: (context) => Home()))
                  .then((value) => null);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.article, size: 100),
                  Text("Lista Produktów",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              color: Colors.blue,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator
                  .push(context, MaterialPageRoute(builder: (context) => ListaZakupow()))
                  .then((value) => null);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.assignment_outlined, size: 100),
                  Text("Lista Zakupów",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              color: Colors.blue,
            ),
          ),
          InkWell(
            onTap: () {

              produktController.fetchZakupy();

              produktController.zakupyWyswietlaj.clear();
              if(produktController.zakupyWyswietlaj.isEmpty){
                produktController.zakupyWyswietlaj = produktController.listaZakupow.map((v) => v).toList();
              }

              Navigator
                  .push(context, MaterialPageRoute(builder: (context) => TrybZakupow()))
                  .then((value) => null);// Navigator

            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_rounded, size: 100),
                  Text("Tryb Zakupowy",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              color: Colors.blue,
            ),
          ),
          InkWell(
            onTap: () {

              Navigator
                  .push(context, MaterialPageRoute(builder: (context) => ListaGrup()));
                  //.then((value) => null);// Navigator

            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.group_rounded, size: 100),
                  Text("Lista Grup",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              color: Colors.blue,
            ),
          ),


        ],
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
                Get.back();
                Get.to(() => Home());

              },
            ),

            ListTile(
              title: Text('Lista Zakupów'),
              onTap: () {
                Get.back();
                Get.to(() => ListaZakupow());
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
                /*
                Navigator.pop(context);
                Navigator
                    .push(context, MaterialPageRoute(builder: (context) => ListaKategorii()))
                    .then((value) => null);
                */
                Get.back();
                Get.to(() => ListaKategorii());
              },
            ),

          ], // children
        ),
      ),

    );
  }// Widget build

}// class HomeMain