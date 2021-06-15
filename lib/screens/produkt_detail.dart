import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:uuid/uuid.dart';

import 'package:spizarnia_domowa_app/widget/custom_button.dart';
import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/model/atrybuty.dart';
import 'package:spizarnia_domowa_app/model/produkt_zakupy.dart';
import 'package:spizarnia_domowa_app/model/miara.dart';
import 'package:spizarnia_domowa_app/model/kategoria.dart';
import 'package:spizarnia_domowa_app/model/kategoria_zakupy.dart';


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

  var uuid = Uuid();

  final nameController = TextEditingController(); //

  final iloscController = TextEditingController(); //

  final miaraController = TextEditingController();

  final kategoriaProduktyController = TextEditingController();

  final kategoriaZakupyController = TextEditingController();

  final atrybutController = TextEditingController();

  final iloscAutoZakupuController = TextEditingController();

  final ProduktController produktController = ProduktController.to;

  onUpdatePressed(String id) {
  /*
    Produkt produkt = new Produkt(
      autoZakup: widget.chosen_produkt.autoZakup,
      progAutoZakupu: int.parse(iloscAutoZakupuController.text),

      //nazwaProduktu: widget.chosen_produkt.nazwaProduktu,
      nazwaProduktu: nameController.text,

      ilosc: int.parse(iloscController.text),
      miara: widget.chosen_produkt.miara,
      //kategorieProdukty: kategoriaProduktyController.text,
      //kategorieZakupy: widget.chosen_produkt.kategorieProdukty,
    );

    produktController.updateProdukt(id, produkt);
   */

/*
    int indexMiara = produktController.miary.indexWhere((element) => element.miara == miaraController.text);
    String idMiara = produktController.miary[indexMiara].objectId;

    Miara miaraProduktu = new Miara(
      objectId: idMiara,
      miara: miaraController.text,
    );
*/



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
      objectId: widget.chosen_produkt.objectId, //
      nazwaProduktu: nameController.text, //
      ilosc: int.parse(iloscController.text), //

      //progAutoZakupu: widget.chosen_produkt.progAutoZakupu, //
      progAutoZakupu: int.parse(iloscAutoZakupuController.text),
      autoZakup: widget.chosen_produkt.autoZakup, //

      miara: widget.chosen_produkt.miara,
      kategorieProdukty: kategoriaProduktu,
      kategorieZakupy: kategoriaZakupu,

      atrybuty: widget.chosen_produkt.atrybuty, //
    );

    //produktController.addProdukt(produkt);
    produktController.updateProdukt(produkt.objectId, produkt);
  }


  /*
  onAddZakupPressed(Produkt produkt) {
    ProduktZakupy zakup = new ProduktZakupy(

      nazwaProduktu: produkt.nazwaProduktu,
      //miara: produkt.miara,
      //kategoriaZakupy: produkt.kategorieZakupy,
      ilosc: int.parse(iloscController.text),
      objectIdProduktu : produkt.objectId,

    );
    produktController.addNewZakup(zakup);
  }
  */


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
            //miara: widget.chosen_produkt.miara,
            //kategoriaZakupy: widget.chosen_produkt.kategorieZakupy,
            ilosc: wynik,
            objectIdProduktu : widget.chosen_produkt.objectId,

            );
          //produktController.addNewZakup(zakupDodaj);

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

  /*
  onScreenOpened(objectId){
    produktController.fetchAtrybuty(objectId);
  }
  */


  onAddAtributePressed(String nazwa){
    String nazwaAtrybutu = nazwa;
    String idProduktu = widget.chosen_produkt.objectId;

    produktController.addAtrybut(idProduktu, nazwaAtrybutu);
    Navigator.pop(context);
  }

  onDeleteAttributePressed(String atrybutId){
    String produktId = widget.chosen_produkt.objectId;

    produktController.deleteAtrybut(produktId, atrybutId);
    Navigator.pop(context);
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


  @override
  void initState() {
    createListKategorieProduktu();
    createListKategorieZakupu();
    kategoriaProduktyController.text = widget.chosen_produkt.kategorieProdukty.nazwa;
    kategoriaZakupyController.text = widget.chosen_produkt.kategorieZakupy.nazwa;
    super.initState();
  }

  bool _checkbox = false;

  String scanResult;

  Future scanBarcode() async {
    String scanResult;

    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Anuluj",
        false,
        ScanMode.BARCODE,
      );
    } on PlatformException {
      scanResult = 'Błąd skanowania';

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("$scanResult"),
            duration: Duration(seconds: 2),
          )
      );

    }
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("$scanResult"),
          duration: Duration(seconds: 2),
        )
    );

    setState(() => this.scanResult = scanResult);
    atrybutController.text = scanResult;
  }



  @override
  Widget build(BuildContext context) {

  _checkbox = widget.chosen_produkt.autoZakup;

    iloscAutoZakupuController.text = widget.chosen_produkt.progAutoZakupu.toString();
    iloscController.text = widget.chosen_produkt.ilosc.toString();
    nameController.text = widget.chosen_produkt.nazwaProduktu;
    //onScreenOpened(widget.chosen_produkt.objectId);

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
          //onScreenOpened(widget.chosen_produkt.objectId);

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
                  IconButton(
                      icon: Icon(Icons.add_chart),
                      onPressed: () {

                        scanBarcode();
                        /*
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Produkt Zaktualizowany"),
                              duration: Duration(seconds: 2),
                            )
                        );

                        Text(
                          scanResult == null
                            ? 'scan a code!'
                            : 'Scan result : $scanResult',
                        )
                        */

                      }
                  ),

                  TextButton(
                      onPressed: () {

                        onAddAtributePressed(atrybutController.text);
                        //onScreenOpened(widget.chosen_produkt.objectId);
                        Navigator.pop(context);
                      },
                      child: Text('Dodaj')),



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

            Text(
                "Nazwa produktu",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
              ),
            ),



            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: "Nazwa"),
              textAlign: TextAlign.center,
            ),


            SizedBox(
              height: 10,
            ),

            Text(
                "Ilość " + widget.chosen_produkt.miara.miara + " produktu:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
            ),

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

            SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Kategoria produktu: ",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),


                DropdownButton(
                  value: kategoriaProduktyController.text,
                  icon: Icon(Icons.arrow_downward_rounded),
                  iconSize: 15,
                  elevation: 16,
                  style: TextStyle(color: Colors.blue, fontSize: 15),

                  underline: Container(
                    height: 2,
                    color: Colors.blue,
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
              ],
            ),





            SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Kategoria zakupu ",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),


                DropdownButton(
                  value: kategoriaZakupyController.text,
                  icon: Icon(Icons.arrow_downward_rounded),
                  iconSize: 15,
                  elevation: 16,
                  style: TextStyle(color: Colors.blue, fontSize: 15),

                  underline: Container(
                    height: 2,
                    color: Colors.blue,
                  ),

                  onChanged: (String newValueZ){
                    setState(() {
                      kategoriaZakupyController.text = newValueZ;
                    });
                  },

                  items: produktController.displayKategorieZakupy.map((produkt) {
                    return DropdownMenuItem(
                      child: new Text(produkt),
                      value: produkt,
                    );
                  }).toList(),
                ),
              ],
            ),


            SizedBox(height: 10),

            SwitchListTile(
                title: Text("Włącz auto zakup: (próg " + widget.chosen_produkt.progAutoZakupu.toString() + ")"),
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
                            mainAxisAlignment: MainAxisAlignment.start,

                            children: [
                              IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: (){
                                    onDeleteAttributePressed(widget.chosen_produkt.atrybuty[index].objectId);
                                  }
                              ),

                              Text(widget.chosen_produkt.atrybuty[index].nazwa),
                            ],

                          ),


                          separatorBuilder: (context, index) =>
                            Divider(color: Colors.black),


                          itemCount: widget.chosen_produkt.atrybuty.length,
                      ),

                    ),

            ),








          ],

        ),

      ),

    );

  }

}//class ProduktDetail