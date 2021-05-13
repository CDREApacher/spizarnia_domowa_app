import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:spizarnia_domowa_app/widget/custom_button.dart';
import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/model/atrybuty.dart';
import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';
import 'package:spizarnia_domowa_app/widget/custom_button.dart';
import 'package:spizarnia_domowa_app/screens/home.dart';

class ProduktDetail extends StatelessWidget {

  final Produkt chosen_produkt;


  final nameController = TextEditingController();//
  final iloscController = TextEditingController();//
  final miaraController = TextEditingController();//
  final kategoriaProduktyController = TextEditingController();
  final kategoriaZakupyController = TextEditingController();

  final atrybutController = TextEditingController();



  final ProduktController produktController = ProduktController.to;

  onUpdatePressed(String id) {

    Produkt produkt = new Produkt(
      autoZakup: chosen_produkt.autoZakup,
      progAutoZakupu: chosen_produkt.progAutoZakupu,

      nazwaProduktu: chosen_produkt.nazwaProduktu,
      ilosc: int.parse(iloscController.text),
      miara: chosen_produkt.miara,
      kategorieProdukty: chosen_produkt.kategorieProdukty,
      kategorieZakupy: chosen_produkt.kategorieProdukty,
    );

    produktController.updateProdukt(id, produkt);
  }


  onScreenOpened(objectId){
    produktController.fetchAtrybuty(objectId);
  }

  onAddAtributePressed(){

    Atrybuty atrybut = new Atrybuty(
      nazwa: atrybutController.text,
      objectIdProdukt: chosen_produkt.objectId,
    );

    produktController.addAtrybut(atrybut);
  }

  ProduktDetail({Key key, @required this.chosen_produkt}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    iloscController.text = chosen_produkt.ilosc.toString();
    onScreenOpened(chosen_produkt.objectId);

    return Scaffold(

      appBar: AppBar(
        toolbarHeight: 42.5,
        title: Text('Szczegóły produktu'),


        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () => {

              onUpdatePressed(chosen_produkt.objectId),
              Navigator.pop(context),

            },
          ),
        ],
      ),


      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_comment_rounded),
        onPressed: () {
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

        },

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

      body: Container(
        padding: EdgeInsets.all(24),

        child: Column(
          children: [

            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                chosen_produkt.nazwaProduktu,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),

            Text("Ilość " + chosen_produkt.miara + " produktu:"),


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

            Text("Kategoria produktu: " + chosen_produkt.kategorieProdukty,
                style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
            ),


            Text("Kategoria zakupu " + chosen_produkt.kategorieZakupy,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),
              ),

            SizedBox(height: 22),

            //ListView(), Needed here to display all attributes of object


            GetBuilder<ProduktController>(
                builder: (produktController) =>

                    Expanded(

                      child: ListView.separated(
                          itemBuilder: (context, index) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

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

  }//Widget build

}//class ProduktDetail