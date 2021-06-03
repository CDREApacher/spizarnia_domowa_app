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

// Controller
import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';

// Screens Widgets
import 'package:spizarnia_domowa_app/screens/lista_kategorii.dart';
import 'package:spizarnia_domowa_app/screens/lista_zakupow.dart';
import 'package:spizarnia_domowa_app/screens/lista_miar.dart';
import 'package:spizarnia_domowa_app/screens/tryb_zakupow.dart';
import 'package:spizarnia_domowa_app/screens/home.dart';
import 'package:spizarnia_domowa_app/screens/add_produkt.dart';

// Debug
import 'package:logger/logger.dart';



class AddExistingProduct extends StatelessWidget{


  final nameController = TextEditingController(); //
  final ProduktController produktController = ProduktController.to;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

//////////////////////////////////////////////////////////

      appBar: AppBar(

        toolbarHeight: 42.5,

        title: Text('Produkty'),

      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator
              .push(context, MaterialPageRoute(builder: (context) => AddProdukt()))
              .then((value) => null);// Navigator
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//////////////////////////////////////////////////////////

      body: Container(
    child:Column(
    mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextField(
          controller: nameController,
          decoration: InputDecoration(hintText: "Nazwa"),
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed:() {

          },
        ),

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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10 ,vertical: 6),
                                    child: Text(
                                        produktController.produkty[index].nazwaProduktu
                                    ),
                                  )
                                ],
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

}// class Home