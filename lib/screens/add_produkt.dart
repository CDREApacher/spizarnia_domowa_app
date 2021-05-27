import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:spizarnia_domowa_app/widget/custom_button.dart';
import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';
import 'package:spizarnia_domowa_app/widget/custom_button.dart';

import 'package:spizarnia_domowa_app/screens/home.dart';

class AddProdukt extends StatefulWidget {

  @override
  _AddProduktState createState() => _AddProduktState();
}



class _AddProduktState extends State<AddProdukt> {

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

  createList(){
    /*
    produktController.kategorie.forEach((element) {
      produktController.displayKategorie.add(element.nazwa);
    });
    */

    if(produktController.displayKategorie.length == 0) { // check to see if it was already created
      for (var i = 0; i < produktController.kategorie.length; i++) {
        if (produktController.kategorie[i].lista == 'produkty') {
          produktController.displayKategorie.add(produktController.kategorie[i].nazwa);
        }
      }
    }

  }

  @override
  void initState(){
    super.initState();
    createList();
    kategoriaProduktyController.text = produktController.displayKategorie.first;
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

          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget>[

            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: "nazwa"),
            ),

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

            Text(
              "Kategoria produktu",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            DropdownButton<String>(
                value: kategoriaProduktyController.text,
                icon: Icon(Icons.arrow_downward_rounded),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurpleAccent),

                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),

                onChanged: (String newValue){
                  setState(() {
                    kategoriaProduktyController.text = newValue;
                  });
                },

                items: produktController.displayKategorie.map((produkt) {
                  return DropdownMenuItem(
                    child: new Text(produkt),
                    value: produkt,
                  );
                }).toList(),

            ),

            /*
            TextField(
              //Kategoria zakupy
              controller: kategoriaZakupyController,
              decoration: InputDecoration(hintText: "kategoria w zakupach"),
            ),
            */
            SizedBox(height: 16),

          ],

        ),

      ),

    );

  }}//class AddProdukt