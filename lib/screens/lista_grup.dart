import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:flutter_spinbox/material.dart';

import 'package:uuid/uuid.dart';

import 'package:spizarnia_domowa_app/widget/custom_button.dart';
import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/model/miara.dart';
import 'package:spizarnia_domowa_app/model/kategoria_zakupy.dart';
import 'package:spizarnia_domowa_app/model/kategoria.dart';
import 'package:spizarnia_domowa_app/model/atrybuty.dart';
import 'package:spizarnia_domowa_app/model/grupa.dart';
import 'package:spizarnia_domowa_app/screens/lista_zakupow.dart';
import 'package:spizarnia_domowa_app/screens/lista_miar.dart';
import 'package:spizarnia_domowa_app/screens/lista_kategorii.dart';
import 'package:spizarnia_domowa_app/screens/group_detail.dart';
import 'package:spizarnia_domowa_app/screens/join_group.dart';


import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';

import 'package:spizarnia_domowa_app/screens/home.dart';
import 'package:spizarnia_domowa_app/screens/home_main.dart';

import 'join_group.dart';

class ListaGrup extends StatefulWidget {

  @override
  _ListaGrupState createState() => _ListaGrupState();
}



class _ListaGrupState extends State<ListaGrup> {


  final ProduktController produktController = ProduktController.to;

  String currentGroup;


  void swapGroup(Grupa wybranaGrupa){
    produktController.selectActiveGroup(wybranaGrupa.nazwa_server, wybranaGrupa.kod_grupy);

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Wybrano grupę " + wybranaGrupa.nazwa_server),
          duration: Duration(seconds: 2),
        )
    );



    // Clear displayKategorieZakupy
    produktController.displayKategorieZakupy.clear();
    // Clear displayKategorie
    produktController.displayKategorie.clear();
    // Clear displayMiary
    produktController.displayMiary.clear();

  }

  @override
  void initState(){

    currentGroup = produktController.currentlyChosenGroupName;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 42.5,
        title: Text('Lista Grup'),

      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {

            navigator.push(
              MaterialPageRoute(
                builder: (_) {
                  return JoinGroup();
                },
              ),
            ).then((value) =>
                setState(() {
                  currentGroup = produktController.currentlyChosenGroupName;
                })
            );


          },
        ),
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
            new Container(
              padding: const EdgeInsets.all(10.0),
              color: Colors.transparent,
              child: new Container(
                  decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.all(
                        const Radius.circular(40.0)
                      )
                  ),
                  child: new Center(
                    child: new Text(currentGroup,
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white), ),
                  )
              ),
            ),

            Expanded(
              child: GetBuilder<ProduktController> (
                  builder: (produktController) =>

                      ListView.builder(
                          itemCount: produktController.listaGrup.length,
                          itemBuilder: (context, index) =>
                              Container(
                                height: 55,
                                child: Card(
                                  elevation: 5,
                                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),

                                  child: InkWell(
                                    onTap: () {


                                      navigator.push(
                                        MaterialPageRoute(
                                          builder: (_) {
                                            return GroupDetail(chosen_group: produktController.listaGrup[index],);
                                          },
                                        ),
                                      );

                                    },
                                    child:Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10 ,vertical: 6),
                                          child: Text(
                                              produktController.listaGrup[index].nazwa_server
                                          ),
                                        ),
                                        //Icon(Icons.add_rounded),
                                        IconButton(
                                            icon: Icon(Icons.swap_vert_rounded),
                                            onPressed: () => {
                                              swapGroup(produktController.listaGrup[index]),

                                              setState(() {
                                                currentGroup = produktController.listaGrup[index].nazwa_server;
                                              })

                                            }
                                        ),
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
                Get.back();//Closes the drawer
                Get.offAll(HomeMain());
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
                Get.back();
                Get.to(() => ListaKategorii());
              },
            ),

          ], // children
        ),
      ),
    );

  }}//class AddProdukt