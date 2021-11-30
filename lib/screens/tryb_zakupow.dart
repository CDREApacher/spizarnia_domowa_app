import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';

import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';

import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/model/produkt_zakupy.dart';
import 'package:spizarnia_domowa_app/model/shopping_list.dart';
import 'package:spizarnia_domowa_app/screens/tryb_zakupowy_detail.dart';
import 'package:spizarnia_domowa_app/screens/home_main.dart';

import 'package:spizarnia_domowa_app/screens/zakup_detail.dart';

import 'tryb_zakupowy_detail.dart';

class TrybZakupow extends StatefulWidget {
  @override
  _TrybZakupowState createState() => _TrybZakupowState();
}

class _TrybZakupowState extends State<TrybZakupow> {

  final ProduktController produktController = ProduktController.to;


  onAddToCart(ShoppingList zakup){
    // Add to doKupienia
    produktController.doKupienia.add(zakup);

    // Remove from zakupy
    produktController.zakupyWyswietlaj.removeWhere((element) => element.objectId == zakup.objectId);
    produktController.update();
  }

  onEndZakupy(){
    for(var i = 0; i < produktController.doKupienia.length; i++){

      produktController.buyProdukts(produktController.doKupienia[i].objectId, produktController.doKupienia[i].quantityToBuy);

    } // for

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Dodano produkty do listy"),
          duration: Duration(seconds: 2),
        )
    );

    // Remove all items from doKupienia
    produktController.doKupienia.clear();
    produktController.zakupyWyswietlaj.clear();

    // Update the view
    produktController.update();

    //produktController.fetchZakupy();

    produktController.fetchFromDatabse();

    Get.offAll(() => HomeMain());

  } // onEndZakupy()


  @override
  void initState(){
    //produktController.doKupienia.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        toolbarHeight: 42.5,

        title: Text('Tryb Zakupowy'),

        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            tooltip: "Zakończ zakupy",
            onPressed: () {



              showDialog(context: context, builder: (_) =>
                  AlertDialog(
                    title: Text('Czy chcesz zakończyć zakupy i dodać produkty do listy produktów?'),

                    actions: [
                      TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text('Anuluj')
                      ),

                      TextButton(
                          onPressed: () {
                            Get.back();
                            onEndZakupy();
                          },
                          child: Text('Zakończ')
                      ),
                    ],

                  ),
              );

            },
          ),
        ],

      ),

      //  get both lists to display


      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.start,

            children: [






                  GetBuilder<ProduktController>(
                    builder: (produktController) =>
                        GroupedListView<ShoppingList, String>(

                          shrinkWrap: true,
                          primary: false,

                          elements: produktController.zakupyWyswietlaj,
                          groupBy: (zakup) {
                            return zakup.produkt.kategorieZakupy.nazwa;
                          },
                          useStickyGroupSeparators: false,

                          groupHeaderBuilder: (ShoppingList zakup) => Padding(
                            padding: const EdgeInsets.all(8.0),

                            child: Text(
                              zakup.produkt.kategorieZakupy.nazwa,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),

                          itemBuilder: (context, ShoppingList zakup) {
                            return Container(
                              height: 60,
                              child: Card(

                                elevation: 5.0,
                                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    Expanded(
                                      child: InkWell(
                                        onTap: () {

                                          Get.to(TrybZakupowyDetail(chosen_produkt: zakup.produkt));

                                        },

                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [


                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                                    child: Text(zakup.produkt.nazwaProduktu + ' : ' + zakup.quantityToBuy.toString() + ' ' + zakup.produkt.miara.miara),
                                                  ),

                                                  IconButton(
                                                      icon: Icon(Icons.add_shopping_cart_rounded),
                                                      onPressed: () {
                                                        //  remove from zakupy list
                                                        //  add to doKupienia list
                                                        onAddToCart(zakup);
                                                      }
                                                  ),

                                                ],
                                              ),
                                            ),

                                          ],
                                        ),

                                      ),
                                    ),

                                  ],
                                ),

                              ),

                            );

                          }, // itemBuilder
                        ),
                  ),






              // Display list of produkts added to doKupienia



                  GetBuilder<ProduktController> (
                      builder: (produktController) =>
                      //Text("TEXT ADDED BY THE SECOND GETBUILDER"),


                      ListView.builder(

                        shrinkWrap: true,
                        primary: false,

                        itemCount: produktController.doKupienia.length,

                        //separatorBuilder: (context, index) =>
                        //    Divider(color: Colors.black),

                        itemBuilder: (context, index) =>

                            Container(
                              height: 55,
                              child: Card(
                                elevation: 5.0,
                                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),


                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10 ,vertical: 6),
                                      child: Text(
                                        produktController.doKupienia[index].produkt.nazwaProduktu
                                            + " : "
                                            + produktController.doKupienia[index].quantityToBuy.toString()
                                            + " "
                                            + produktController.doKupienia[index].produkt.miara.miara
                                        ,style: TextStyle(decoration: TextDecoration.lineThrough),
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                            ),


                      )


                  ),



              //Text("TEST TEST"),
            ],
          ),
        ),
      ),


    );
  }

}