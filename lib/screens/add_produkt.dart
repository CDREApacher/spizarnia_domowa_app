import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:spizarnia_domowa_app/widget/custom_button.dart';
import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';
import 'package:spizarnia_domowa_app/widget/custom_button.dart';

import 'package:spizarnia_domowa_app/screens/home.dart';

class AddProdukt extends StatelessWidget {

  String rod = "sztuk";

  final nameController = TextEditingController();
  final iloscController = TextEditingController();
  final miaraController = TextEditingController();
  final kategoriaProduktyController = TextEditingController();
  final kategoriaZakupyController = TextEditingController();

  final ProduktController produktController = ProduktController.to;


  onConfirmPressed() {
    Produkt produkt = new Produkt(
      nazwaProduktu: nameController.text,
      ilosc: int.parse(iloscController.text),
      miara: miaraController.text,
      kategorieProdukty: kategoriaProduktyController.text,
      kategorieZakupy: kategoriaProduktyController.text,
    );

    produktController.addProdukt(produkt);
  }


  onClearPressed() {
    nameController.clear();
    iloscController.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 42.5,
        title: Text('Dodaj Produkt'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () => {
              onConfirmPressed(),
              Navigator.pop(context),
            },
          ),
        ],
      ),




      body: Container(

        padding: EdgeInsets.all(24),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[

            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: "nazwa"),
            ),

            /*
            TextField(
              controller: iloscController,
              decoration: InputDecoration(hintText: "ilosc"),
            ),
            */

            SpinBox(
              value: 0,
              min: 0,
              max: 2048,
              onChanged: (value) {
                print(value);
                int val = value.toInt();
                iloscController.text = val.toString();
              },
            ),

            TextField(
              controller: miaraController,
              decoration: InputDecoration(hintText: "miara"),
            ),

            TextField(
              //Kategoria produktu
              controller: kategoriaProduktyController,
              decoration: InputDecoration(hintText: "kategoria produktu"),
            ),
            /*
            TextField(
              //Kategoria zakupy
              controller: kategoriaZakupyController,
              decoration: InputDecoration(hintText: "kategoria w zakupach"),
            ),
            */
            SizedBox(height: 16),



            /*


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [

                CustomButton(
                  onPressed: () => {
                    onConfirmPressed(),
                    Navigator.pop(context),
                  },
                  text: "Potwierdź",
                ),


              ],

            ),

            */




          ],

        ),

      ),

    );

  }//Widget build

}//class AddProdukt