import 'package:flutter/material.dart';
import 'package:spizarnia_domowa_app/model/grupa.dart';
import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';

import 'package:qr_flutter/qr_flutter.dart';
class GroupDetail extends StatefulWidget {

  final Grupa chosen_group;


  GroupDetail({Key key, @required this.chosen_group}) : super(key: key);

  @override
  _GroupDetailState createState() => _GroupDetailState();
}



class _GroupDetailState extends State<GroupDetail> {


  final ProduktController produktController = ProduktController.to;


  @override
  void initState() {

    super.initState();
  }

/*
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
*/


  @override
  Widget build(BuildContext context) {



    return Scaffold(

      appBar: AppBar(
        toolbarHeight: 42.5,
        title: Text('Szczegóły grupy'),

      ),


      body: Container(
        padding: EdgeInsets.all(100),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text("Nazwa Grupy"),

            Align(
              alignment: Alignment.center,
              child:

              Text(
                widget.chosen_group.nazwa_server,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),


            SizedBox(height: 36),

            Text("Kod Grupy"),

            Text(
              widget.chosen_group.kod_grupy,
              //textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),
            ),

            SizedBox(height: 36),

            QrImage(
              data: widget.chosen_group.kod_grupy,
              version: QrVersions.auto,
              padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
              size: 400,
            ),


          ],

        ),

      ),

    );

  }

}//class