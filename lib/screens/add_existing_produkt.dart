// Built in
import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:spizarnia_domowa_app/model/kody_kreskowe.dart';


// Custom Widgets
import 'package:spizarnia_domowa_app/widget/custom_button.dart';

// Modles
import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/model/produkt_zakupy.dart';
import 'package:spizarnia_domowa_app/model/kategoria.dart';
import 'package:spizarnia_domowa_app/model/kategoria_zakupy.dart';
import 'package:spizarnia_domowa_app/model/grupa.dart';

// Controller
import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';

// Screens Widgets
import 'package:spizarnia_domowa_app/screens/lista_kategorii.dart';
import 'package:spizarnia_domowa_app/screens/lista_zakupow.dart';
import 'package:spizarnia_domowa_app/screens/lista_miar.dart';
import 'package:spizarnia_domowa_app/screens/tryb_zakupow.dart';
import 'package:spizarnia_domowa_app/screens/home.dart';
import 'package:spizarnia_domowa_app/screens/add_produkt.dart';

// Debug
import 'package:logger/logger.dart';

import '../model/produkt.dart';
import 'produkt_detail.dart';



class AddExistingProduct extends StatefulWidget{

  @override
  State<AddExistingProduct> createState() => _AddExistingProductState();

}

class _AddExistingProductState extends State<AddExistingProduct> {
  final nameController = TextEditingController();
  final ProduktController produktController = ProduktController.to;

  final iloscController = TextEditingController();

  onUpdatePressed(Produkt chosen_produkt) {

    Grupa grupaProduktu = new Grupa(
      nazwa_server: produktController.currentlyChosenGroupName,
      kod_grupy: produktController.currentlyChosenGroupCode,
    );

    Produkt produkt = new Produkt(
      objectId: chosen_produkt.objectId, //
      nazwaProduktu: chosen_produkt.nazwaProduktu, //
      ilosc: int.parse(iloscController.text), //

      progAutoZakupu: chosen_produkt.progAutoZakupu, //
      autoZakup: chosen_produkt.autoZakup, //

      miara: chosen_produkt.miara,
      kategorieProdukty: chosen_produkt.kategorieProdukty,
      kategorieZakupy: chosen_produkt.kategorieZakupy,

      atrybuty: chosen_produkt.atrybuty, //

      grupa: grupaProduktu,

      kody_kreskowe: chosen_produkt.kody_kreskowe,

      daty_waznosci: chosen_produkt.daty_waznosci,
    );

    produktController.updateProdukt(produkt.objectId, produkt);
  }



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

    if(scanResult != "-1"){


      // Here we need to check if a barcode such as this already exists

      // Make a list of all the barcodes of all the products
      // OR ALTERNATELY check inside the loop


      bool foundProduct = false;
      Produkt produktZkodu;

        breaklabel:
        for (var i = 0; i < produktController.produkty.length; i++){
          for (var j = 0; j < produktController.produkty[i].kody_kreskowe.length; j++){

            if(produktController.produkty[i].kody_kreskowe[j].barcode_code == scanResult){
              foundProduct = true;
              produktZkodu = produktController.produkty[i];
              break breaklabel;
            }

          } // for j
        } // for i

      if(foundProduct){

        // Try to go to the productDetail screen of the product with this code

        navigator.push(
          MaterialPageRoute(
            builder: (_) {
              return ProduktDetail(chosen_produkt: produktZkodu);
            },
          ),
        ).then((value) =>
            Timer(Duration(milliseconds: 500), () {
              produktController.fetchAllProdukts();
            })
        );

      }else{

        // Means we didn't find this barcode
        // So now remember the code
        produktController.kod_kreskowy_nowego_produktu = scanResult;
        // Take us to the add product screen
        // Add a product AND right after add this barcode


        showDialog(context: context, builder: (_) =>
            AlertDialog(
              title: Text('Kod nie powiązany z żadym produktem.'),
              content: Text('Czy chcesz utworzć nowy produkt?'),

              actions: [
                TextButton(
                    onPressed: () {

                      Get.back();


                      navigator.push(
                        MaterialPageRoute(
                          builder: (_) {
                            return AddProdukt();
                          },
                        ),
                      ).then((value) =>
                          Timer(Duration(milliseconds: 500), () {
                            produktController.fetchAllProdukts();
                          })
                      );


                    },
                    child: Text('Dodaj')
                ),
              ],

            ),
        );
      } // else

    } // scan result != '-1'

  }// scanBarcode()

  @override
  Widget build(BuildContext context) {
    return Scaffold(


//////////////////////////////////////////////////////////
      appBar: AppBar(

        toolbarHeight: 42.5,

        title: Text('Produkty'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add_chart),
              tooltip: "Zeskanuj kod kreskowy",
              onPressed: () => {
                scanBarcode()
              }
          ),
        ],
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator
              .push(context, MaterialPageRoute(builder: (context) => AddProdukt()))
              .then((value) => null);// Navigator
        },
      ),
    ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//////////////////////////////////////////////////////////
      body: Container(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /*TextField(
          controller: nameController,
          decoration: InputDecoration(hintText: "Nazwa"),
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed:() {
          },
        ),*/

            Expanded(
              child: GetBuilder<ProduktController> (
                  builder: (produktController) =>

                      ListView.builder(
                          itemCount: produktController.produkty.length,
                          itemBuilder: (context, index) =>
                              Container(
                                height: 55,
                                child: Card(
                                  elevation: 5,
                                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),

                                  child: InkWell(
                                    onTap: () {
                                      showDialog(context: context, builder: (_) =>
                                          AlertDialog(
                                            title: Text('Ilość ' +  produktController.produkty[index].nazwaProduktu + ' do listy produktów. (' +  produktController.produkty[index].miara.miara + ')'),
                                            content: SpinBox(
                                              value: double.parse(produktController.produkty[index].ilosc.toString()),
                                              min: 0,
                                              max: 2048,
                                              onChanged: (value) {
                                                print(value); // TODO remove debug print
                                                int val = value.toInt();
                                                iloscController.text = val.toString();
                                              },
                                            ),

                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    onUpdatePressed(produktController.produkty[index]);
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: Text("Zaktualizowano "  +  produktController.produkty[index].nazwaProduktu + ": "  + iloscController.text + " " +  produktController.produkty[index].miara.miara ),
                                                        duration: Duration(seconds: 5),
                                                      ),
                                                    );
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);

                                                  },
                                                  child: Text('Dodaj')
                                              ),
                                            ],

                                          ),
                                      );
                                    },
                                    child:Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10 ,vertical: 6),
                                          child: Text(
                                              produktController.produkty[index].nazwaProduktu
                                          ),
                                        ),
                                        Icon(Icons.add_rounded),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                      )
              ),
            ),

          ],

        ),
      ),
/////////////////////////////////////////////////////////////////////////
    );
  }}// class