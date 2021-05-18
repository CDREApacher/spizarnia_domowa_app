import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';

import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/model/produkt_zakupy.dart';

import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';

import 'package:spizarnia_domowa_app/screens/produkt_detail.dart';
import 'package:spizarnia_domowa_app/screens/zakup_detail.dart';

// Debug
import 'package:logger/logger.dart';

class ListaZakupow extends StatefulWidget{
  @override
  _ListaZakupow createState() => _ListaZakupow();

}

class _ListaZakupow extends State<ListaZakupow>{

  Logger logger = Logger(); // TODO remove debug

  final ProduktController produktController = ProduktController.to;


  onRefreshPressed() {
    produktController.fetchZakupy();
  }



  @override
  void initState() {
    produktController.fetchZakupy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 42.5,
        title: Text("Lista Zakupów"),
      ),


      /*
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
                                        width:200,

                                       child: InkWell(
                                         onTap: () {

                                              /*
                                             Navigator
                                              .push(context, MaterialPageRoute(builder: (context) => ProduktDetail(chosen_produkt: produktController.produkty[index]))) // push
                                              .then((value) => onRefreshPressed());//Navigator
                                              */

                                                   }, //onTap

                                               child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                   children: [

                                                         SizedBox(height: 8),

                                                              Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                           children: [

                                                                        Text(produktController.zakupy[index].nazwaProduktu),

                                                                   Text(produktController.zakupy[index].ilosc.toString() + ' ' + produktController.zakupy[index].miara),

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
                               itemCount: produktController.zakupy.length),
                      ),
                    ),

            ],

        ),
      ), */ // body


      body: GetBuilder<ProduktController>(
        builder: (produktController) =>
            GroupedListView<ProduktZakupy, String>(

              elements: produktController.zakupy,
              groupBy: (zakup) {
                return zakup.kategoriaZakupy;
              },
              useStickyGroupSeparators: true,

              groupHeaderBuilder: (ProduktZakupy zakup) => Padding(
                padding: const EdgeInsets.all(8.0),

                child: Text(
                  zakup.kategoriaZakupy,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              itemBuilder: (context, ProduktZakupy zakup) {
                return Container(
                    height: 60,
                    child: Card(

                      elevation: 5.0,
                      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Icon(Icons.shopping_cart_rounded),

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
                                  Text(zakup.nazwaProduktu + ' : ' + zakup.ilosc.toString() + ' ' + zakup.miara),
                                  Icon(Icons.arrow_forward_ios_rounded),
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




    );
  }
}