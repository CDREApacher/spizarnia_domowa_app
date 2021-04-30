import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:spizarnia_domowa_app/widget/custom_button.dart';
import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';
import 'package:spizarnia_domowa_app/widget/custom_button.dart';
import 'package:spizarnia_domowa_app/screens/home.dart';

class ProduktDetail extends StatelessWidget {

  final Produkt chosen_produkt;

  final iloscController = TextEditingController();

  final ProduktController produktController = ProduktController.to;

  onUpdatePressed(String id) {
    Produkt produkt = new Produkt(
        nazwa: chosen_produkt.nazwa,
        ilosc: int.parse(iloscController.text)
    );
    
    produktController.updateProdukt(id, produkt);
  }
  
  

  ProduktDetail({Key key, @required this.chosen_produkt}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    iloscController.text = chosen_produkt.ilosc.toString();

    return Scaffold(

      appBar: AppBar(
        title: Text('Szczegóły produktu'),
      ),

      body: Container(

        padding: EdgeInsets.all(24),

        child: Column(

          children: [

            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                chosen_produkt.nazwa,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),

            Text("Ilość " + chosen_produkt.rodzaj + " produktu:"),


            SpinBox(
              value: double.parse(iloscController.text),
              onChanged: (value)  {
                print(value);
                int val = value.toInt();
                iloscController.text = val.toString();
                },
            ),

            /*
            TextField(
              controller: iloscController,
              decoration: InputDecoration(hintText: "ilość"),
            ),
            */


            Row(

              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [

                CustomButton(
                  onPressed: ()  {


                    onUpdatePressed(chosen_produkt.id); // nie aktualizuje listy na głównym ekranie !!


                    Navigator.push(
                      context,
                      MaterialPageRoute( builder: (context) => Home() ),
                    );






                  },
                  text: "Zapisz zmiany",
                ),

                CustomButton(
                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute( builder: (context) => Home() ),
                    );

                  },
                  text: "Powrót",
                ),


              ],

            ),
            /*
            Text(
              'Ilość produktu: ' + chosen_produkt.ilosc.toString(),
              style: TextStyle(
                fontSize: 14
              ),
            ),
            */



            //CustomButton(), //Add custom button to save edit

          ],

        ),

      ),

    );

  }//Widget build

}//class ProduktDetail