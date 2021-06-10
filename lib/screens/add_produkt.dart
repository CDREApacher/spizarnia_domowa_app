import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinbox/material.dart';

import 'package:uuid/uuid.dart';

import 'package:spizarnia_domowa_app/widget/custom_button.dart';
import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/model/miara.dart';
import 'package:spizarnia_domowa_app/model/kategoria_zakupy.dart';
import 'package:spizarnia_domowa_app/model/kategoria.dart';
import 'package:spizarnia_domowa_app/model/atrybuty.dart';


import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';

import 'package:spizarnia_domowa_app/screens/home.dart';

class AddProdukt extends StatefulWidget {

  @override
  _AddProduktState createState() => _AddProduktState();
}



class _AddProduktState extends State<AddProdukt> {

  var uuid = Uuid();

  final nameController = TextEditingController();

  final iloscController = TextEditingController();

  final miaraController = TextEditingController();

  final kategoriaProduktyController = TextEditingController();

  final kategoriaZakupyController = TextEditingController();

  final ProduktController produktController = ProduktController.to;



  onConfirmPressed() {

    List<Atrybuty> atrybutyProduktu = [];

    int indexMiara = produktController.miary.indexWhere((element) => element.miara == miaraController.text);
    String idMiara = produktController.miary[indexMiara].objectId;

    Miara miaraProduktu = new Miara(
      objectId: idMiara,
      miara: miaraController.text,
    );

    int indexKategoriaProduktu = produktController.kategorie.indexWhere((element) => element.nazwa == kategoriaProduktyController.text);
    String idKategoriaProduktu = produktController.kategorie[indexKategoriaProduktu].objectId;

    Kategoria kategoriaProduktu = new Kategoria(
      objectId: idKategoriaProduktu,
      nazwa: kategoriaProduktyController.text,
    );

    int indexKategoriaZakupu = produktController.kategorieZakupy.indexWhere((element) => element.nazwa == kategoriaZakupyController.text);
    String idKategoriaZakupu = produktController.kategorieZakupy[indexKategoriaZakupu].objectId;

    KategoriaZakupy kategoriaZakupu = new KategoriaZakupy(
      objectId: idKategoriaZakupu,
      nazwa: kategoriaZakupyController.text,
    );

    Produkt produkt = new Produkt(
      objectId: uuid.v4(),
      nazwaProduktu: nameController.text,
      ilosc: int.parse(iloscController.text),

      progAutoZakupu: 0,
      autoZakup: false,

      miara: miaraProduktu,

      kategorieProdukty: kategoriaProduktu,

      kategorieZakupy: kategoriaZakupu,

      atrybuty: atrybutyProduktu,
    );

    produktController.addProdukt(produkt);
  }



  onClearPressed() {
    nameController.clear();
    iloscController.clear();
  }



  createListKategorieProduktu(){
    if(produktController.displayKategorie.length == 0) { // check to see if it was already created

      for (var i = 0; i < produktController.kategorie.length; i++) {
        produktController.displayKategorie.add(produktController.kategorie[i].nazwa);
      }

    }
    print(produktController.displayKategorie);
  }

  createListKategorieZakupu(){
    if(produktController.displayKategorieZakupy.length == 0) { // check to see if it was already created

      for (var i = 0; i < produktController.kategorieZakupy.length; i++) {
        produktController.displayKategorieZakupy.add(produktController.kategorieZakupy[i].nazwa);
      }

    }
    print(produktController.displayKategorieZakupy);
  }

  createListMiary(){
    if(produktController.displayMiary.length == 0) { // check to see if it was already created

      for (var i = 0; i < produktController.miary.length; i++) {
        produktController.displayMiary.add(produktController.miary[i].miara);
      }

    }
    print(produktController.displayMiary);
  }

  @override
  void initState(){
    createListKategorieProduktu();
    createListKategorieZakupu();
    createListMiary();
    kategoriaProduktyController.text = produktController.displayKategorie.first;
    kategoriaZakupyController.text = produktController.displayKategorieZakupy.first;
    miaraController.text = produktController.displayMiary.first;
    super.initState();
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

            Text(
              "Nazwa produktu",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: "nazwa"),
            ),

            SizedBox(height: 16),

            Text(
              "Ilość produktu",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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

            SizedBox(height: 16),

            Text(
              "Miara produktu",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),


            DropdownButton<String>(
              value: miaraController.text,
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
                  miaraController.text = newValue;
                });
              },

              items: produktController.displayMiary.map((miara) {
                return DropdownMenuItem(
                  child: new Text(miara),
                  value: miara,
                );
              }).toList(),

            ),


            SizedBox(height: 16),

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


            SizedBox(height: 16),

            Text(
              "Kategoria zakupu",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 16),

            DropdownButton<String>(
              value: kategoriaZakupyController.text,
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
                  kategoriaZakupyController.text = newValue;
                });
              },

              items: produktController.displayKategorieZakupy.map((zakup) {
                return DropdownMenuItem(
                  child: new Text(zakup),
                  value: zakup,
                );
              }).toList(),

            ),



          ],

        ),

      ),

    );

  }}//class AddProdukt