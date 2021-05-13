import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';

import 'package:spizarnia_domowa_app/screens/produkt_detail.dart';

class ListaZakupow extends StatefulWidget{
  @override
  _ListaZakupow createState() => _ListaZakupow();

}

class _ListaZakupow extends State<ListaZakupow>{

  final ProduktController produktController = ProduktController.to;


  onRefreshPressed() {
    produktController.refreshAllProdukts();
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
                                              .push(
                                                context,
                                              MaterialPageRoute(builder: (context) => ProduktDetail(chosen_produkt: produktController.produkty[index]))) // push
                                            .then(
                                               (value) => onRefreshPressed()
                                               );//Navigator
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
      ),
    );
  }
}