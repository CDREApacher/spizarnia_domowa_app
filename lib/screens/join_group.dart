import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:spizarnia_domowa_app/model/grupa.dart';

import 'package:uuid/uuid.dart';

import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/model/atrybuty.dart';
import 'package:spizarnia_domowa_app/model/produkt_zakupy.dart';
import 'package:spizarnia_domowa_app/model/miara.dart';
import 'package:spizarnia_domowa_app/model/kategoria.dart';
import 'package:spizarnia_domowa_app/model/kategoria_zakupy.dart';
import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';

import 'package:get/get.dart';

import 'dart:developer';

class JoinGroup extends StatefulWidget {



  @override
  _JoinGroupState createState() => _JoinGroupState();
}



class _JoinGroupState extends State<JoinGroup> {

  var uuid = Uuid();

  final nameController = TextEditingController(); //

  final kodController = TextEditingController(); //

  final qr = TextEditingController();

  final a = TextEditingController();



  final ProduktController produktController = ProduktController.to;




  bool _checkbox = false;

  String scanResult;

  Future scanBarcode() async {
    String scanResult;

    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Anuluj",
        false,
        ScanMode.QR,
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

    if(scanResult != "-1"){
      kodController.text = scanResult;
      dolaczDoGrupy();
      Get.back();
    }


  }



  void utworzGrupe() {

    log(nameController.text);
    produktController.addGrupy(nameController.text);
    nameController.clear();

    log(produktController.currentlyChosenGroupName);
    log(produktController.currentlyChosenGroupCode);
  }

  void dolaczDoGrupy(){


    log(kodController.text);

    produktController.joinGrupy(kodController.text);


    kodController.clear();

    produktController.listaGrup.forEach((Grupa grupa) {
      log("Lista zapisana");
      log(grupa.nazwa_server);
      log(grupa.kod_grupy);
    });

    Get.back();
    Get.back();



  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(
        toolbarHeight: 42.5,
        title: Text('Dołączy do grupy'),

      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.only(left: 10.0, top:60.0, right: 10.0),
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        crossAxisCount: 2,
        children: <Widget>[


          InkWell(
            onTap: () {
              showDialog(context: context, builder: (_) =>
                  AlertDialog(
                    title: Text('Dołącz do grupy:'),

                    content: TextField(
                      controller: kodController,
                      decoration: InputDecoration(hintText: "kod grupy"),

                    ),

                    actions: [


                      TextButton(
                          onPressed: () {

                            dolaczDoGrupy();


                          },
                          child: Text('Dołącz')


                      ),



                    ],
                  ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Icon(Icons.group_rounded, size: 80, color: Colors.white),
                  Text("Dołącz do grupy",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.blue, Colors.blueAccent],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),

          InkWell(
            onTap: () {

              scanBarcode();

            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.qr_code_scanner_rounded, size: 80, color: Colors.white),
                  Text("Dołącz z QR",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.blue, Colors.blueAccent],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),

          InkWell(
            onTap: () {
              showDialog(context: context, builder: (_) =>
                  AlertDialog(
                    title: Text('Utwórz grupę:'),

                    content: TextField(
                      controller: nameController,
                      decoration: InputDecoration(hintText: "Nazwa grupy"),

                    ),

                    actions: [


                      TextButton(
                          onPressed: () {

                            utworzGrupe();
                            Get.back();
                            Get.back();
                          },
                          child: Text('Utwórz')),



                    ],
                  ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.group_add_rounded, size: 80, color: Colors.white),
                  Text("Utwórz grupę",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.blue, Colors.blueAccent],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),



        ],
      ),
    );

  }

}//class ProduktDetail