// Built in
import 'dart:async';
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
import 'package:get/get_rx/src/rx_types/rx_types.dart';

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
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'lista_grup.dart';
import 'lista_zakupow.dart';
import 'tryb_zakupow.dart';

class HomeMain extends StatefulWidget{


  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  final ProduktController produktController = ProduktController.to;

  dodajGrupe(){
    String nazwa = "Test_z_Apki_LOG";

    produktController.addGrupy(nazwa);
  }

  pokazGrupy() async {
    //produktController.listaGrup.add(produktController.currentlyChosenGroup);
    log("lista grup po add");
    log(produktController.listaGrup[0].nazwa_server);
    log("Aktualnie wybrana grupa NAZWA:");
    log(produktController.currentlyChosenGroupName);
    log("Aktualnie wybrana grupa KOD:");
    log(produktController.currentlyChosenGroupCode);


    SharedPreferences sprefs = await SharedPreferences.getInstance();

    String encodedGroupString = sprefs.getString('spidom_group_list');
    log("Encoded");
    log(encodedGroupString);

    Iterable l = json.decode(encodedGroupString);
    produktController.listaGrup = RxList.from(l.map((model) => Grupa.fromJson(model)));


    log("lista grup po MAGICZNYCH WIDZIMISIACH");

    produktController.listaGrup.forEach((Grupa grupa) {
      log(grupa.nazwa_server);
      log(grupa.kod_grupy);
    });


  }

  @override
  void initState(){

    //produktController.fetchKategorieProdukty();
    //produktController.fetchKategorieZakupy();
    //produktController.fetchMiary();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

//////////////////////////////////////////////////////////
      appBar: AppBar(

        toolbarHeight: 42.5,

        title: Text('Domowa spiżarnia'),

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

              Get.to(Home());

            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.article, size: 80, color: Colors.white),
                  Text("Lista Produktów",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),

              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.blue, Colors.blueAccent],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),

          InkWell(
            onTap: () {

              /*
              * Might need to set proper lists once we integrate tryb zakupowy to lista zakupow
              * */

              Get.to(ListaZakupow());

            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.assignment_outlined, size: 80, color: Colors.white),
                  Text("Lista Zakupów",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),

              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.blue, Colors.blueAccent],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),

          InkWell(
            onTap: () {
              /*
              produktController.fetchZakupy();

              produktController.doKupienia.clear();
              produktController.zakupyWyswietlaj.clear();
              if(produktController.zakupyWyswietlaj.isEmpty){
                produktController.zakupyWyswietlaj = RxList.from(produktController.listaZakupow);
              }
              */

              //Get.to(TrybZakupow());

              /*
              * Cannot figure out why lista_zakupow works but this not
              * */
              Get.snackbar(
                  "Dostępny z ekranu Listy Zakupów",
                  "W tej wersji przejście do Trybu Zakupowego dostępne tylko z Listy Zakupów",
                snackPosition: SnackPosition.BOTTOM,
                duration: Duration(seconds: 5),
                icon: Icon(Icons.label_important_outlined),
                borderRadius: 10,
                margin: EdgeInsets.all(10),
                forwardAnimationCurve: Curves.easeOutBack,

              );

            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_rounded, size: 80, color: Colors.white),
                  Text("Tryb Zakupowy",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),

              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.blue, Colors.blueAccent],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),

          InkWell(
            onTap: () {

              Get.to(ListaGrup());

            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.group_rounded, size: 80, color: Colors.white),
                  Text("Lista Grup",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),

              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.blue, Colors.blueAccent],
                ),
                shape: BoxShape.circle,
              ),
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
  }}// class HomeMain