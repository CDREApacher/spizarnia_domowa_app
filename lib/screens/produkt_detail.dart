import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_arc_speed_dial/flutter_arc_speed_dial.dart';
import 'package:flutter_arc_speed_dial/flutter_speed_dial_menu_button.dart';
import 'package:flutter_arc_speed_dial/main_menu_floating_action_button.dart';
import 'package:intl/intl.dart';

import 'package:uuid/uuid.dart';

import 'package:spizarnia_domowa_app/widget/custom_button.dart';
import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/model/atrybuty.dart';
import 'package:spizarnia_domowa_app/model/produkt_zakupy.dart';
import 'package:spizarnia_domowa_app/model/miara.dart';
import 'package:spizarnia_domowa_app/model/kategoria.dart';
import 'package:spizarnia_domowa_app/model/kategoria_zakupy.dart';
import 'package:spizarnia_domowa_app/model/grupa.dart';
import 'package:spizarnia_domowa_app/model/kody_kreskowe.dart';
import 'package:spizarnia_domowa_app/model/expiration_date.dart';

import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';
import 'package:spizarnia_domowa_app/widget/custom_button.dart';
import 'package:spizarnia_domowa_app/screens/home.dart';

import 'dart:developer';

import '../model/shopping_list.dart';
import '../model/shopping_list.dart';
import '../model/shopping_list.dart';

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

  final nazwaDatyController = TextEditingController();

  final iloscDniPrzypomnieniaController = TextEditingController();

  final nazwaKoduController = TextEditingController();

  final ProduktController produktController = ProduktController.to;

  onUpdatePressed(String id) {

    Grupa grupaProduktu = new Grupa(
      nazwa_server: produktController.currentlyChosenGroupName,
      kod_grupy: produktController.currentlyChosenGroupCode,
    );

    int indexKategoriaProduktu = produktController.kategorie.indexWhere((element) => element.nazwa == kategoriaProduktyController.text);
    String idKategoriaProduktu = produktController.kategorie[indexKategoriaProduktu].objectId;

    Kategoria kategoriaProduktu = new Kategoria(
      objectId: idKategoriaProduktu,
      nazwa: kategoriaProduktyController.text,
      grupa: grupaProduktu,
    );

    int indexKategoriaZakupu = produktController.kategorieZakupy.indexWhere((element) => element.nazwa == kategoriaZakupyController.text);
    String idKategoriaZakupu = produktController.kategorieZakupy[indexKategoriaZakupu].objectId;

    KategoriaZakupy kategoriaZakupu = new KategoriaZakupy(
      objectId: idKategoriaZakupu,
      nazwa: kategoriaZakupyController.text,
      grupa: grupaProduktu
    );

    int indexMiara = produktController.miary.indexWhere((element) => element.miara == miaraController.text);
    String idMiara = produktController.miary[indexMiara].objectId;

    Miara miaraProduktu = new Miara(
      objectId: idMiara,
      miara: miaraController.text,
      grupa: grupaProduktu,
    );

    Produkt produkt = new Produkt(
      objectId: widget.chosen_produkt.objectId, //
      nazwaProduktu: nameController.text, //
      ilosc: int.parse(iloscController.text), //

      progAutoZakupu: int.parse(iloscAutoZakupuController.text),

      autoZakup: _checkbox,

      miara: miaraProduktu,
      kategorieProdukty: kategoriaProduktu,
      kategorieZakupy: kategoriaZakupu,

      atrybuty: widget.chosen_produkt.atrybuty, //

      grupa: grupaProduktu,

      kody_kreskowe: widget.chosen_produkt.kody_kreskowe,

      daty_waznosci: widget.chosen_produkt.daty_waznosci,
    );

    produktController.updateProdukt(produkt.objectId, produkt);
  }


  onCheckUpdatePressed() {
    if (widget.chosen_produkt.autoZakup == false) {

      onUpdatePressed(widget.chosen_produkt.objectId);

    } else {
      // autoZakup == true

      //first check if progAutoZakupu < produkt.ilosc

      if (int.parse(iloscController.text) < widget.chosen_produkt.progAutoZakupu) {
        /*
        * Here the new ammount will be smaller than progAutoZakupu
        * Update the product anyway
        * Also create a Zakup and add it to lista zakupow
        * */

        /*
        * Firs we should check if a zakup already exists
        * if it does for now dont do anything
        * */

        bool foundZakup = false;
        ShoppingList znalezionyZakup;

        breaklabel:
        for (var i = 0 ; i < produktController.listaZakupow.length ; i++) {
          if (produktController.listaZakupow[i].produkt.objectId == widget.chosen_produkt.objectId) {
            znalezionyZakup = produktController.listaZakupow[i];
            foundZakup = true;
            break breaklabel;
          } // if
        } // for

        if (foundZakup){
          log("WE HAVE FOUND THE ZAKUP !!!");
          // We found that a zakup for this product exists so just update the product
          onUpdatePressed(widget.chosen_produkt.objectId);
          // We could also update the Zakup ammount

          ShoppingList nowyZakup = new ShoppingList(
            objectId: znalezionyZakup.objectId,
            quantityToBuy: znalezionyZakup.quantityToBuy + (widget.chosen_produkt.ilosc - int.parse(iloscController.text)),
            produkt: znalezionyZakup.produkt,
            grupa: znalezionyZakup.grupa,
          );

          produktController.updateZakup(nowyZakup.objectId, nowyZakup.quantityToBuy, nowyZakup);


        }else{
          // No zakup exists for this product so add a zakup
          log("WE HAVE -- NOT -- FOUND THE ZAKUP !!!");
          // Figure out the ammount to add
          var ileKupic = widget.chosen_produkt.progAutoZakupu - int.parse(iloscController.text);

          Grupa grupaZakupu = new Grupa(
            nazwa_server: produktController.currentlyChosenGroupName,
            kod_grupy: produktController.currentlyChosenGroupCode,
          );

          ShoppingList listaZakupow = new ShoppingList(
            objectId: uuid.v4(),
            quantityToBuy: ileKupic,
            produkt: widget.chosen_produkt,
            grupa: grupaZakupu,
          );

          onUpdatePressed(widget.chosen_produkt.objectId);

          produktController.addNewZakup(listaZakupow);

        }


      } else {
        /*
        * Here the new amount is still higher than progAutoZakupu
        * so just update the product
        * */
        onUpdatePressed(widget.chosen_produkt.objectId);
      }

    }

  }//onCheckUpdatePressed


  onAddAtributePressed(String nazwa){

    String nazwaAtrybutu = nazwa;
    String idProduktu = widget.chosen_produkt.objectId;

    produktController.addAtrybut(idProduktu, nazwaAtrybutu);

    Get.back();// Exit produkt Detail
  }

  onDeleteAttributePressed(String atrybutId){
    String produktId = widget.chosen_produkt.objectId;

    produktController.deleteAtrybut(produktId, atrybutId);
  }


  onAddDatePressed(){
    produktController.addExpDates(
        widget.chosen_produkt.objectId,
        produktController.data_produktu_poprawny_format,
        int.parse(iloscDniPrzypomnieniaController.text),
        nazwaDatyController.text
    );
    Get.back();
  }

  onDeleteDatePressed(String expDate_id){
    String produktId = widget.chosen_produkt.objectId;

    produktController.deleteExpDates(produktId, expDate_id);
  }

  onAddBarcodePressed(String barcode){
    String produktId = widget.chosen_produkt.objectId;

    produktController.addBarcodes(barcode, produktId, nazwaKoduController.text);
  }


  createListKategorieProduktu(){
    produktController.displayKategorie.clear();
    if(produktController.displayKategorie.length == 0) { // check to see if it was already created

      for (var i = 0; i < produktController.kategorie.length; i++) {
          produktController.displayKategorie.add(produktController.kategorie[i].nazwa);
      }

    }
    print(produktController.displayKategorie);
  }

  createListKategorieZakupu(){
    produktController.displayKategorieZakupy.clear();
    if(produktController.displayKategorieZakupy.length == 0) { // check to see if it was already created

      for (var i = 0; i < produktController.kategorieZakupy.length; i++) {
          produktController.displayKategorieZakupy.add(produktController.kategorieZakupy[i].nazwa);
      }

    }
    print(produktController.displayKategorieZakupy);
  }

  createListMiary(){
    produktController.displayMiary.clear();
    if(produktController.displayMiary.length == 0){
      for (var i = 0; i < produktController.miary.length; i++) {
        produktController.displayMiary.add(produktController.miary[i].miara);
      }
    }
    print(produktController.displayMiary);
  }


  @override
  void initState() {
    // May turn out to be unnecessary
    //produktController.fetchProdukt(widget.chosen_produkt.objectId);
    createListKategorieProduktu();
    createListKategorieZakupu();
    createListMiary();
    kategoriaProduktyController.text = widget.chosen_produkt.kategorieProdukty.nazwa;
    kategoriaZakupyController.text = widget.chosen_produkt.kategorieZakupy.nazwa;
    miaraController.text = widget.chosen_produkt.miara.miara;

    super.initState();
  }

  bool _checkbox;

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
      /*  scanResult = 'B????d skanowania';

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("$scanResult"),
            duration: Duration(seconds: 2),
          )
      );*/

    }
    if (!mounted) return;

   /* ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("$scanResult"),
          duration: Duration(seconds: 2),
        )
    );*/

    setState(() => this.scanResult = scanResult);
    if(scanResult != "-1"){
      log(scanResult);
      // If we got a scan result
      // Add the barcode to the product



      showDialog(context: context, builder: (_) =>
        AlertDialog(
          title: Text("Kod kreskowy"),
          content: Column(
            children: [

              Text("Nazwa dla kodu"),

              TextField(
                controller: nazwaKoduController,
                decoration: InputDecoration(hintText: "nazwa"),
                textAlign: TextAlign.center,
              ),

            ],

          ),

          actions: [
            TextButton(
                onPressed: () {

                  // Add the barcode to the product
                  onAddBarcodePressed(scanResult);
                  Get.back();

                },
                child: Text('Dodaj')
            ),
          ],

        ),
      );












    }
  }

  bool _isShowDial = false;
  DateTime selectedDate = DateTime.now();
  String formatedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,

        helpText: "Wyberz date ",
        cancelText: "Anuluj",
        confirmText: "Wybierz",
        initialDate: selectedDate,
        firstDate: DateTime(2021, 8),
        lastDate: DateTime(2041));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;

        formatedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

        produktController.data_produktu_poprawny_format = formatedDate;
      });

      showDialog(context: context, builder: (_) =>
          AlertDialog(
            title: Text('Szczeg????y daty spo??ycia'),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text("Nazwa dla daty"),

                TextField(
                  controller: nazwaDatyController,
                  decoration: InputDecoration(hintText: "nazwa"),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 16),

                Text("Ile dni wcze??niej przypomnie???"),

                SpinBox(
                  value: 0,
                  min: 0,
                  max: 2048,
                  onChanged: (value) {
                    print(value);
                    int val = value.toInt();
                    iloscDniPrzypomnieniaController.text = val.toString();
                  },
                ),


              ],
            ),



            actions: [
              TextButton(
                  onPressed: () {

                    // Add the date to the product
                    onAddDatePressed();
                    Get.back();
                    //Get.back();
                  },
                  child: Text('Dodaj')
              ),
            ],

          ),
      );
    }
  }

  var myFormat = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

  _checkbox = widget.chosen_produkt.autoZakup;

    iloscAutoZakupuController.text = widget.chosen_produkt.progAutoZakupu.toString();
    iloscController.text = widget.chosen_produkt.ilosc.toString();
    nameController.text = widget.chosen_produkt.nazwaProduktu;
    //miaraController.text = widget.chosen_produkt.miara.miara;
    //onScreenOpened(widget.chosen_produkt.objectId);

    return Scaffold(

      appBar: AppBar(
        toolbarHeight: 42.5,
        title: Text('Szczeg????y produktu'),


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

        floatingActionButton:SpeedDialMenuButton(
          //if needed to close the menu after clicking sub-FAB
          isShowSpeedDial: _isShowDial,
          //manually open or close menu
          updateSpeedDialStatus: (isShow) {
            //return any open or close change within the widget
            this._isShowDial = isShow;
          },
          //general init
          isMainFABMini: false,
          mainMenuFloatingActionButton: MainMenuFloatingActionButton(
              mini: false,
              child: Icon(Icons.more_horiz_rounded),
              onPressed: () {},
              closeMenuChild: Icon(Icons.close),
              closeMenuForegroundColor: Colors.blueAccent,
              closeMenuBackgroundColor: Colors.white),
          floatingActionButtonWidgetChildren: <FloatingActionButton>[
            FloatingActionButton(
              heroTag: "btnDate",
              mini: true,
              child: Icon(Icons.date_range_rounded),
              onPressed: () => _selectDate(context),
              backgroundColor: Colors.grey,
            ),
            FloatingActionButton(
              heroTag: "btnCode",
              mini: true,
              child: Icon(Icons.addchart_rounded), // Wtf is wrong with the Icon name between this and Co-contributor versions? add_chart_rounded vs addchart_rounded
              onPressed: () {
                scanBarcode();
              },
              backgroundColor: Colors.grey,
            ),
            FloatingActionButton(
              heroTag: "btnNote",
              mini: true,
              child: Icon(Icons.add_comment_rounded),
              onPressed: () {
                showDialog(context: context, builder: (_) =>
                    AlertDialog(
                      title: Text('Dodaj kr??tk?? notk??:'),

                      content: TextField(
                        controller: atrybutController,
                        decoration: InputDecoration(hintText: "Tutaj dodaj notk??"),

                      ),

                      actions: [

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
              },
              backgroundColor: Colors.grey,
            ),
          ],
          isSpeedDialFABsMini: true,
          paddingBtwSpeedDialButton: 15.0,
        ),






      body: SingleChildScrollView(
        child: Container(
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
                "Ilo???? " + widget.chosen_produkt.miara.miara + " produktu:",
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
                  Text("Miara produktu: ",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),

//-------------------------------------------------------------------------------------

                  DropdownButton(
                    value: miaraController.text,
                    icon: Icon(Icons.arrow_downward_rounded),
                    iconSize: 15,
                    elevation: 16,
                    style: TextStyle(color: Colors.blue, fontSize: 15),

                    underline: Container(
                      height: 2,
                      color: Colors.blue,
                    ),

                    onChanged: (String newValueX){
                      setState(() {
                        miaraController.text = newValueX;
                        log("Miara Controller text: " + miaraController.text);
                      });
                    },

                    items: produktController.displayMiary.map((miara) {
                      return DropdownMenuItem(
                        child: new Text(miara),
                        value: miara,
                      );
                    }).toList(),
                  ),
                ],
              ),

//-------------------------------------------------------------------------------------

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

                    onChanged: (String newValueY){
                      setState(() {
                        kategoriaProduktyController.text = newValueY;
                        log("Kategoria Produkty text: " + kategoriaProduktyController.text);
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
                        log("Kategoria zakupy text: " + kategoriaZakupyController.text);
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
                title: Text("W????cz auto zakup: (pr??g " + widget.chosen_produkt.progAutoZakupu.toString() + ")"),
                value: _checkbox,
                onChanged: (bool value) {

                  widget.chosen_produkt.autoZakup = value;
                  setState(() {
                    _checkbox = value;
                  });

                  if(value == true){

                    showDialog(context: context, builder: (_) =>
                        AlertDialog(
                          title: Text('Ustal pr??g automatycznego dodawania'),
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
                                  log(_checkbox.toString());
                                  Navigator.pop(context);
                                },
                                child: Text('Zatwierd??')
                            ),
                          ],

                        ),
                    );

                  }

                },
              ),

              Text("Atrybuty produktu"),

              GetBuilder<ProduktController>(
                builder: (produktController) =>

                    SizedBox(
                      width: screenWidth,
                      height: 200,
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

              Text("Daty wa??no??ci"),

              GetBuilder<ProduktController>(
                builder: (produktController) =>

                    SizedBox(
                      width: screenWidth,
                      height: 200,
                      child: ListView.separated(

                        itemBuilder: (context, index) => Row(
                          mainAxisAlignment: MainAxisAlignment.start,

                          children: [
                            IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: (){
                                  onDeleteDatePressed(widget.chosen_produkt.daty_waznosci[index].id);
                                }
                            ),

                            Text(widget.chosen_produkt.daty_waznosci[index].exp_date.toString()),
                            //Text(myFormat.format(widget.chosen_produkt.daty_waznosci[index].exp_date)),
                            Text("   "),
                            Text(widget.chosen_produkt.daty_waznosci[index].nazwa),

                          ],

                        ),


                        separatorBuilder: (context, index) =>
                            Divider(color: Colors.black),


                        itemCount: widget.chosen_produkt.daty_waznosci.length,
                      ),
                    ),

              ),





            ],

          ),

        ),
      ),

    );

  }

}//class ProduktDetail