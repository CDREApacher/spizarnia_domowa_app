import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:spizarnia_domowa_app/widget/custom_button.dart';
import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/model/atrybuty.dart';
import 'package:spizarnia_domowa_app/model/produkt_zakupy.dart';
import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';
import 'package:spizarnia_domowa_app/widget/custom_button.dart';
import 'package:spizarnia_domowa_app/screens/home.dart';

class ProduktDetail extends StatelessWidget {

  final Produkt chosen_produkt;


  final nameController = TextEditingController();
  final iloscController = TextEditingController();
  final miaraController = TextEditingController();
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



  onAddZakupPressed(Produkt produkt) {
    ProduktZakupy zakup = new ProduktZakupy(

      nazwaProduktu: produkt.nazwaProduktu,
      miara: produkt.miara,
      kategoriaZakupy: produkt.kategorieZakupy,
      ilosc: int.parse(iloscController.text),
      objectIdProduktu : produkt.objectId,

    );
    produktController.addNewZakup(zakup);
  }


  onCheckUpdatePressed(){
    if(chosen_produkt.autoZakup == false){
      onUpdatePressed(chosen_produkt.objectId);
    }else{
      if( (int.parse(iloscController.text) >= chosen_produkt.progAutoZakupu) || (chosen_produkt.ilosc <= int.parse(iloscController.text)) ){ // chosen_produkt.ilosc after update >= chosen_produkt.progAutoZakupu
        onUpdatePressed(chosen_produkt.objectId);
      }else{// chosen_produkt.ilosc after update < chosen_produkt.progAutoZakupu
        int index = produktController.findProduktInZakupyList(chosen_produkt.objectId);

        int naszProg = chosen_produkt.progAutoZakupu;
        int staraWartosc = chosen_produkt.ilosc;
        int nowaWartosc = int.parse(iloscController.text);
        int wynik;

        if(staraWartosc >= naszProg){
          // To co w bazie było orginalnie większe niż próg
          wynik = naszProg - nowaWartosc;
        }else{
          // To co w bazie NIE było orginalnie większe niż próg
          wynik = staraWartosc - nowaWartosc;
        }
        if(wynik < 0){wynik = wynik * (-1);}


        if(index == -1){// No produkt like this found in zakupy lista // create new zakup

          ProduktZakupy zakupDodaj = new ProduktZakupy(

            nazwaProduktu: chosen_produkt.nazwaProduktu,
            miara: chosen_produkt.miara,
            kategoriaZakupy: chosen_produkt.kategorieZakupy,
            ilosc: wynik,
            objectIdProduktu : chosen_produkt.objectId,

            );
          produktController.addNewZakup(zakupDodaj);

          onUpdatePressed(chosen_produkt.objectId);

        }else{// Produkt like this found in zakupy lista // get the Produkt

          ProduktZakupy zakup = produktController.getProduktFromZakupy(index);

          if(zakup.ilosc + wynik + nowaWartosc < chosen_produkt.progAutoZakupu){
            zakup.ilosc = chosen_produkt.progAutoZakupu - nowaWartosc;
          }else{
            zakup.ilosc += wynik;
          }

          produktController.updateZakup(zakup.objectId, zakup); // update zakupy

          onUpdatePressed(chosen_produkt.objectId); // update produkty

        }// Third else

      }// Second else

    }// First else

  }// onCheckUpdatePressed()

  onScreenOpened(objectId){
    produktController.fetchAtrybuty(objectId);
  }

  onAddAtributePressed(){

    Atrybuty atrybut = new Atrybuty(
      nazwa: atrybutController.text,
      objectIdProdukt: chosen_produkt.objectId,
    );

    produktController.addAtrybut(atrybut);
    //onScreenOpened(objectId)
    //produktController.fetchZakupy(chosen_produkt.objectId);
  }

  ProduktDetail({Key key, @required this.chosen_produkt}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    bool _autoZakup = chosen_produkt.autoZakup;

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


              onCheckUpdatePressed(),


              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Produkt Zaktualizowany"),
                  duration: Duration(seconds: 2),
                )
              ),


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
          //Navigator.pop(context);
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
                print(value); // TODO remove debug
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

            SwitchListTile(
                title: Text("Turn me on!"),
                value: _autoZakup,
                onChanged: (bool value) {

                },
            ),



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