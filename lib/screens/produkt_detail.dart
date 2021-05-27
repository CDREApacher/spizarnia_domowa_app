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

class ProduktDetail extends StatefulWidget {

  final Produkt chosen_produkt;


  ProduktDetail({Key key, @required this.chosen_produkt}) : super(key: key);

  @override
  _ProduktDetailState createState() => _ProduktDetailState();
}



class _ProduktDetailState extends State<ProduktDetail> {
  final nameController = TextEditingController();

  final iloscController = TextEditingController();

  final miaraController = TextEditingController();

  final kategoriaProduktyController = TextEditingController();

  final kategoriaZakupyController = TextEditingController();

  final atrybutController = TextEditingController();

  final iloscAutoZakupuController = TextEditingController();

  final ProduktController produktController = ProduktController.to;

  onUpdatePressed(String id) {

    Produkt produkt = new Produkt(
      autoZakup: widget.chosen_produkt.autoZakup,
      progAutoZakupu: int.parse(iloscAutoZakupuController.text),

      nazwaProduktu: widget.chosen_produkt.nazwaProduktu,
      ilosc: int.parse(iloscController.text),
      miara: widget.chosen_produkt.miara,
      kategorieProdukty: widget.chosen_produkt.kategorieProdukty,
      kategorieZakupy: widget.chosen_produkt.kategorieProdukty,
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
    if(widget.chosen_produkt.autoZakup == false){
      onUpdatePressed(widget.chosen_produkt.objectId);
    }else{
      if( (int.parse(iloscController.text) >= widget.chosen_produkt.progAutoZakupu) || (widget.chosen_produkt.ilosc <= int.parse(iloscController.text)) ){ // chosen_produkt.ilosc after update >= chosen_produkt.progAutoZakupu
        onUpdatePressed(widget.chosen_produkt.objectId);
      }else{// chosen_produkt.ilosc after update < chosen_produkt.progAutoZakupu
        int index = produktController.findProduktInZakupyList(widget.chosen_produkt.objectId);

        int naszProg = widget.chosen_produkt.progAutoZakupu;
        int staraWartosc = widget.chosen_produkt.ilosc;
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

            nazwaProduktu: widget.chosen_produkt.nazwaProduktu,
            miara: widget.chosen_produkt.miara,
            kategoriaZakupy: widget.chosen_produkt.kategorieZakupy,
            ilosc: wynik,
            objectIdProduktu : widget.chosen_produkt.objectId,

            );
          produktController.addNewZakup(zakupDodaj);

          onUpdatePressed(widget.chosen_produkt.objectId);

        }else{// Produkt like this found in zakupy lista // get the Produkt

          ProduktZakupy zakup = produktController.getProduktFromZakupy(index);

          if(zakup.ilosc + wynik + nowaWartosc < widget.chosen_produkt.progAutoZakupu){
            zakup.ilosc = widget.chosen_produkt.progAutoZakupu - nowaWartosc;
          }else{
            zakup.ilosc += wynik;
          }

          produktController.updateZakup(zakup.objectId, zakup); // update zakupy

          onUpdatePressed(widget.chosen_produkt.objectId); // update produkty

        }// Third else

      }// Second else

    }// First else

  }
  onScreenOpened(objectId){
    produktController.fetchAtrybuty(objectId);
  }

  onAddAtributePressed(){

    Atrybuty atrybut = new Atrybuty(
      nazwa: atrybutController.text,
      objectIdProdukt: widget.chosen_produkt.objectId,
    );

    produktController.addAtrybut(atrybut);
    //onScreenOpened(objectId)
    //produktController.fetchZakupy(chosen_produkt.objectId);
  }


  @override
  void initState() {
    //bool _checkbox = widget.chosen_produkt.autoZakup;
    super.initState();
  }
  
  bool _checkbox = false;

  @override
  Widget build(BuildContext context) {

  _checkbox = widget.chosen_produkt.autoZakup;

    iloscAutoZakupuController.text = widget.chosen_produkt.progAutoZakupu.toString();
    iloscController.text = widget.chosen_produkt.ilosc.toString();
    onScreenOpened(widget.chosen_produkt.objectId);

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
          onScreenOpened(widget.chosen_produkt.objectId);

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
                        onScreenOpened(widget.chosen_produkt.objectId);
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
                widget.chosen_produkt.nazwaProduktu,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),

            Text("Ilość " + widget.chosen_produkt.miara + " produktu:"),


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

            Text("Kategoria produktu: " + widget.chosen_produkt.kategorieProdukty,
                style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
            ),


            Text("Kategoria zakupu " + widget.chosen_produkt.kategorieZakupy,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),
              ),

            SizedBox(height: 22),


            SwitchListTile(
                title: Text("Włącz auto zakup:"),
                value: _checkbox,
                onChanged: (bool value) {

                  widget.chosen_produkt.autoZakup = value;
                  setState(() {
                    _checkbox = value;
                  });

                  if(value == true){


                    showDialog(context: context, builder: (_) =>
                        AlertDialog(
                          title: Text('Ustal próg automatycznego dodawania'),
                          content: SpinBox(
                            value: double.parse(iloscAutoZakupuController.text),
                            min: 0,
                            max: 2048,
                            onChanged: (value) {
                              print(value); // TODO remove debug print
                              int val = value.toInt();
                              iloscAutoZakupuController.text = val.toString();
                            },
                          ),

                          actions: [
                            TextButton(
                                onPressed: () {
                                  //onAddZakupPressed(produkt);
                                  Navigator.pop(context);
                                },
                                child: Text('Zatwierdź')
                            ),
                          ],

                        ),
                    );


                  }

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

  }}//class ProduktDetail