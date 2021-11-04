import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:uuid/uuid.dart';


import 'package:spizarnia_domowa_app/widget/custom_button.dart';
import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/model/produkt_zakupy.dart';
import 'package:spizarnia_domowa_app/model/atrybuty.dart';
import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';
import 'package:spizarnia_domowa_app/widget/custom_button.dart';
import 'package:spizarnia_domowa_app/screens/home.dart';
import 'package:spizarnia_domowa_app/model/shopping_list.dart';
import 'package:spizarnia_domowa_app/model/grupa.dart';


class ZakupDetail extends StatefulWidget{

  final ShoppingList chosen_produkt;

  ZakupDetail({Key key, @required this.chosen_produkt}) : super(key: key);

  @override
  _ZakupDetailState createState() => _ZakupDetailState();
}

class _ZakupDetailState extends State<ZakupDetail> {

  final ProduktController produktController = ProduktController.to;

  var uuid = Uuid();

  final nameController = TextEditingController();

  final iloscController = TextEditingController();

  final miaraController = TextEditingController();

  final kategoriaZakupyController = TextEditingController();

  onUpdatePressed(String id) {


    Grupa grupaZakupu = new Grupa(
      nazwa_server: produktController.currentlyChosenGroupName,
      kod_grupy: produktController.currentlyChosenGroupCode,
    );

    ShoppingList updatedZakup = new ShoppingList(
      objectId: widget.chosen_produkt.objectId,
      quantityToBuy: int.parse(iloscController.text),
      grupa: grupaZakupu,
      produkt: widget.chosen_produkt.produkt,
    );

    int quantity = int.parse(iloscController.text);

    produktController.updateZakup(widget.chosen_produkt.objectId, quantity, updatedZakup);

/*
    produktController.updateZakup(id, listaZakupow);

    ProduktZakupy zakup = new ProduktZakupy(
      objectIdProduktu: chosen_produkt.objectIdProduktu,

      nazwaProduktu: chosen_produkt.nazwaProduktu,
      ilosc: int.parse(iloscController.text),
      miara: chosen_produkt.miara,
      kategoriaZakupy: chosen_produkt.kategoriaZakupy,
    );



 */
  }

  @override
  Widget build(BuildContext context) {


    iloscController.text = widget.chosen_produkt.quantityToBuy.toString();



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
                widget.chosen_produkt.produkt.nazwaProduktu,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),

            Text("Ilość " + widget.chosen_produkt.produkt.miara.miara + " produktu:"),

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


            Text("Kategoria zakupu " + widget.chosen_produkt.produkt.kategorieZakupy.nazwa,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
              ),
            ),

            SizedBox(height: 22),







            GetBuilder<ProduktController>(
              builder: (produktController) =>

                  Expanded(

                    child: ListView.separated(

                      itemBuilder: (context, index) => Row(
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [


                          Text(widget.chosen_produkt.produkt.atrybuty[index].nazwa),
                        ],

                      ),


                      separatorBuilder: (context, index) =>
                          Divider(color: Colors.black),


                      itemCount: widget.chosen_produkt.produkt.atrybuty.length,
                    ),

                  ),

            ),





          ],
        ),
      ),



    );
  }
}