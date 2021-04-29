import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spizarnia_domowa_app/widget/custom_button.dart';
import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';
import 'package:spizarnia_domowa_app/widget/custom_button.dart';

import 'package:spizarnia_domowa_app/screens/home.dart';

class AddProdukt extends StatelessWidget {


  final nameController = TextEditingController();
  final iloscController = TextEditingController();

  final ProduktController produktController = ProduktController.to;


  onConfirmPressed() {
    Produkt produkt = new Produkt(
        nazwa: nameController.text,
        ilosc: int.parse(iloscController.text)
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
      appBar: AppBar(title: Text('Debug Spiżarnia Domowa')),

      body: Container(

        padding: EdgeInsets.all(24),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[

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

                CustomButton(
                  onPressed: () => onConfirmPressed(),
                  text: "Potwierdź",
                ),

                CustomButton(
                  //onPressed: () => onCancelPressed(),
                  text: "Anuluj",
                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute( builder: (context) => Home() ),
                    );

                  },
                ),

              ],

            ),

          ],

        ),

      ),

    );

  }//Widget build
  
}//class AddProdukt