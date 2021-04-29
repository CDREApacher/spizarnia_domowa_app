import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spizarnia_domowa_app/widget/custom_button.dart';
import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';

import 'package:spizarnia_domowa_app/screens/add_produkt.dart';
import 'package:spizarnia_domowa_app/screens/produkt_detail.dart';


class Home extends StatelessWidget{

  final nameController = TextEditingController();
  final iloscController = TextEditingController();

  final ProduktController produktController = ProduktController.to;

  onItemPressed(Produkt produkt) {
    nameController.text = produkt.nazwa;
    iloscController.text = produkt.ilosc.toString();

    produktController.setSelected(produkt);
  }

  onAddPressed() {
    Produkt produkt = new Produkt(
        nazwa: nameController.text,
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
        nazwa: nameController.text,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(



      appBar: AppBar(title: Text('Debug Spiżarnia Domowa')),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProdukt()),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

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
                            
                            Navigator.push(
                                context, MaterialPageRoute(
                                builder: (context) => ProduktDetail(chosen_produkt: produktController.produkty[index])
                            )
                            );//Navigator
                            
                            
                          },


                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [

                            SizedBox(height: 8),

                            Text(produktController.produkty[index].nazwa),

                            SizedBox(height: 4),

                            Text(produktController.produkty[index].ilosc.toString()),

                            SizedBox(height: 8),
                          ],
                        ),

                      ),

                    ),

                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => onDeletePressed(produktController.produkty[index].id),
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
      );
  }// Widget build

}// class Home