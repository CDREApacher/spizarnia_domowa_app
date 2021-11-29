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

    /*
    Grupa g1 = new Grupa(
      nazwa_server: "Grupa1",
      kod_grupy: "11111"
    );

    Grupa g2 = new Grupa(
      nazwa_server: "Grupa2",
      kod_grupy: "22222"
    );

    produktController.listaGrupTest.add(g1);
    produktController.listaGrupTest.add(g2);


    SharedPreferences sprefs = await SharedPreferences.getInstance();

    var encodedListaGrupTest = json.encode(produktController.listaGrupTest);

    await sprefs.setString('spidom_group_list_test', encodedListaGrupTest);
    */

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


    /*
    produktController.listaGrupTest.forEach((Grupa grupa) {
      log(grupa.nazwa_server);
      log(grupa.kod_grupy);
    });

    Grupa app = new Grupa(
      nazwa_server: "Test_z_Apki_LOG",
      kod_grupy: "YtUed",
    );
    */
    //produktController.listaGrup.add(app);
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

        actions: <Widget>[
          /*
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
          */

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
              Navigator
                  .push(context, MaterialPageRoute(builder: (context) => ListaZakupow()))
                  .then((value) => null);
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

              produktController.fetchZakupy();

              produktController.doKupienia.clear();
              produktController.zakupyWyswietlaj.clear();
              if(produktController.zakupyWyswietlaj.isEmpty){
                //produktController.zakupyWyswietlaj = produktController.listaZakupow.map((v) => v).toList();
                
                produktController.zakupyWyswietlaj = RxList.from(produktController.listaZakupow);
                
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

              /*
              produktController.listaGrupWyswietlaj = RxList.from(produktController.listaGrup);
              log(produktController.listaGrup.toString());
              log(produktController.listaGrupWyswietlaj.toString());
              */

              Navigator
                  .push(context, MaterialPageRoute(builder: (context) => ListaGrup()));
                  //.then((value) => null);// Navigator

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