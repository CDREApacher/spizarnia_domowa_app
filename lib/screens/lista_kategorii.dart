import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';
import 'package:spizarnia_domowa_app/model/kategoria.dart';

class ListaKategorii extends StatefulWidget{
  @override
  _ListaKategorii createState() => _ListaKategorii();

}

class _ListaKategorii extends State<ListaKategorii>{

  final ProduktController produktController = ProduktController.to;


  final nameController = TextEditingController();
  final listaController = TextEditingController();


  onClearPressed() {
    nameController.clear();
    listaController.clear();
  }

  onDodajKategorie() {
    Kategoria kategoria = new Kategoria (
      nazwa: nameController.text,
      lista: listaController.text,
    );

    produktController.addKategorie(kategoria);
    onClearPressed();
  }


  @override
  void initState() {
    produktController.fetchAllKategorie();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(

      appBar: AppBar(
        toolbarHeight: 42.5,
        title: Text('Spiżarnia Domowa'),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {


          showDialog(context: context, builder: (_) =>
              AlertDialog(
                title: Text('Dodaj kategorię:'),

                content: Column(

                  children: [

                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(hintText: "Nazwa kategorii"),

                    ),

                    TextField(
                      controller: listaController,
                      decoration: InputDecoration(hintText: "Nazwa listy"),
                    ),

                  ],

                ),

                actions: [
                  TextButton(
                      onPressed: () {

                        onDodajKategorie();

                        Navigator.pop(context);
                      },
                      child: Text('Dodaj'))
                ],
              ),
          ); // showDialog


        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,




      body: Container(
        padding: EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[

            GetBuilder<ProduktController>(
                builder: (produktController) =>

                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [

                              SizedBox(
                                width:340,

                                child: InkWell(
                                  onTap: () {},

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [

                                      SizedBox(height: 8),

                                      Row(

                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          Text(produktController.kategorie[index].nazwa),

                                          Text(produktController.kategorie[index].lista),

                                        ],

                                      ),

                                      SizedBox(height: 8),

                                    ],
                                  ),
                                ),
                              ),

                            ],

                          ),

                          separatorBuilder: (context, index) =>
                              Divider(color: Colors.black),

                          itemCount: produktController.kategorie.length,
                      ),
                    ),
            ),


          ],

        ),
      ),




    );

  } // Build

}