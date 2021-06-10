import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinbox/material.dart';

import 'package:spizarnia_domowa_app/widget/custom_button.dart';
import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/model/produkt_zakupy.dart';
import 'package:spizarnia_domowa_app/model/atrybuty.dart';
import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';
import 'package:spizarnia_domowa_app/widget/custom_button.dart';
import 'package:spizarnia_domowa_app/screens/home.dart';

class ZakupDetail extends StatefulWidget{

  final ProduktZakupy chosen_produkt;

  ZakupDetail({Key key, @required this.chosen_produkt}) : super(key: key);

  @override
  _ZakupDetailState createState() => _ZakupDetailState();
}

class _ZakupDetailState extends State<ZakupDetail> {
  final ProduktController produktController = ProduktController.to;

  final nameController = TextEditingController();

  final iloscController = TextEditingController();

  final miaraController = TextEditingController();

  final kategoriaZakupyController = TextEditingController();

  onScreenOpened(objectId){
    produktController.fetchAtrybuty(objectId);
  }

  onUpdatePressed(String id) {

    ProduktZakupy zakup = new ProduktZakupy(
      objectIdProduktu: widget.chosen_produkt.objectIdProduktu,

      nazwaProduktu: widget.chosen_produkt.nazwaProduktu,
      ilosc: int.parse(iloscController.text),
      miara: widget.chosen_produkt.miara,
      kategoriaZakupy: kategoriaZakupyController.text,
    );

    produktController.updateZakup(id, zakup);
  }

  createListKategorieProduktu(){
    if(produktController.displayKategorie.length == 0) { // check to see if it was already created
      for (var i = 0; i < produktController.kategorie.length; i++) {
        //  if (produktController.kategorie[i].lista == 'produkty') {
        produktController.displayKategorie.add(produktController.kategorie[i].nazwa);

      }
    }
    print(produktController.displayKategorie);
  }

  @override
  Widget build(BuildContext context) {


    iloscController.text = widget.chosen_produkt.ilosc.toString();
    onScreenOpened(widget.chosen_produkt.objectIdProduktu);
    kategoriaZakupyController.text = widget.chosen_produkt.kategoriaZakupy;
    createListKategorieProduktu();


    return Scaffold(

      appBar: AppBar(
        toolbarHeight: 42.5,
        title: Text('Szczegóły zakupu'),


        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () => {

              onUpdatePressed(widget.chosen_produkt.objectId),
              Navigator.pop(context),

            },
          ),
        ],
      ),


      /*
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          /*
          onScreenOpened(chosen_produkt.objectId);

          showDialog(context: context, builder: (_) =>
              AlertDialog(
                title: Text('Dodaj krótką notkę:'),

                content: TextField(
                  controller: atrybutController,
                  decoration: InputDecoration(hintText: "Tutaj dodaj notkę"),

                  /* onChanged: (value) {
                    String val = value;
                    atrybutController.text = val;
                  }, // Allows for spelling backwards */

                ),

                actions: [
                  TextButton(
                      onPressed: () {
                        onAddAtributePressed();
                        onScreenOpened(chosen_produkt.objectId);
                        Navigator.pop(context);
                      },
                      child: Text('Dodaj'))
                ],
              ),
          );
        */
        }, // onPressed

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      */




      body: Container(
        padding: EdgeInsets.all(24),

        child: Column(
          children: [

            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                widget.chosen_produkt.nazwaProduktu,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
            ),

            Text("Ilość " + widget.chosen_produkt.miara + " produktu:"),

            SpinBox(
              value: double.parse(iloscController.text),
              min: 0,
              max: 2048,
              onChanged: (value)  {
                print(value);
                int val = value.toInt();
                iloscController.text = val.toString();
              },
            ),


            Row(
              children: [
                Text("Kategoria zakupu: ",
                  style: TextStyle(
                    fontSize: 15,

                  ),
                ),

                DropdownButton(
                  value: kategoriaZakupyController.text,
                  icon: Icon(Icons.arrow_downward_rounded),
                  iconSize: 15,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 15),

                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),

                  onChanged: (String newValue){
                    setState(() {
                      kategoriaZakupyController.text = newValue;
                    });
                  },

                  items: produktController.displayKategorie.map((zakup) {
                    return DropdownMenuItem(
                      child: new Text(zakup),
                      value: zakup,
                    );
                  }).toList(),
                ),
              ],

            ),
            SizedBox(
              height: 10,
            ),
            GetBuilder<ProduktController>(
              builder: (produktController) =>

                  Expanded(

                    child: ListView.separated(
                      itemBuilder: (context, index) => Row(
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          Text(produktController.atrybuty[index].nazwa),
                        ],

                      ),

                      separatorBuilder: (context, index) =>
                          Divider(color: Colors.black),

                      itemCount: produktController.atrybuty.length,
                    ),
                  ),
            ),







          ],
        ),
      ),



    );
  }
}