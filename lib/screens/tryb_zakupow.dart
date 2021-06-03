import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';

import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';

import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/model/produkt_zakupy.dart';

import 'package:spizarnia_domowa_app/screens/zakup_detail.dart';
import 'package:spizarnia_domowa_app/screens/home.dart';

class TrybZakupow extends StatefulWidget {
  @override
  _TrybZakupowState createState() => _TrybZakupowState();
}

class _TrybZakupowState extends State<TrybZakupow> {

  final ProduktController produktController = ProduktController.to;

  onAddToCart(ProduktZakupy zakup){
    // Add to doKupienia
    produktController.doKupienia.add(zakup);

    // Remove from zakupy
    produktController.zakupyWyswietlaj.removeWhere((element) => element.objectId == zakup.objectId);
    produktController.update();
  }

  onEndZakupy(){
    for(var i = 0; i < produktController.doKupienia.length; i++){
      // TODO add all items from doKupienia list to the database
      // TODO for each element added to database update produkty list
      // TODO for each element added to produkty list remove them from doKupienia list

      // nie tyle post co put
      // w tej chili zaktualizuj te produkty
      // produktController.updateProdukt(id, produkt)


      // Get the index of the produkt we want to update
      int produktIndex = produktController.produkty.indexWhere((element) => element.objectId == produktController.doKupienia[i].objectIdProduktu);
      // Get the produkt by the index
      Produkt ref = produktController.produkty[produktIndex];

      String id = ref.objectId;

      Produkt produkt = new Produkt(

        nazwaProduktu: produktController.doKupienia[i].nazwaProduktu,
        ilosc: ref.ilosc + produktController.doKupienia[i].ilosc, // Increase from what is in ref
        miara: produktController.doKupienia[i].miara,
        progAutoZakupu: ref.progAutoZakupu, // get from produkt ref
        autoZakup: ref.autoZakup, // get from produkt ref
        kategorieProdukty: ref.kategorieProdukty, // get frfom produkt ref
        kategorieZakupy: ref.kategorieZakupy, //get from produkt ref

      );

      // Update in the database
      produktController.updateProdukt(id, produkt);


      int zakupIndex = produktController.zakupy.indexWhere((element) => element.objectId == produktController.doKupienia[i].objectId);
      ProduktZakupy zakupRef = produktController.zakupy[zakupIndex];

      // Remove from database
      produktController.deleteZakup(zakupRef.objectId);

    } // for
    // Remove all items from doKupienia
    produktController.doKupienia.clear();
    produktController.zakupyWyswietlaj.clear();

    // Update the view
    produktController.update();

    Navigator
        .push(context, MaterialPageRoute(builder: (context) => Home()))
        .then((value) => null);

  } // onEndZakupy()

  @override
  void initState(){

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
              onEndZakupy();
            },
          ),
        ],

      ),
      // TODO get both lists to display
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.start,

          children: [

           /* Card(
              elevation: 5.0,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              color: Colors.yellowAccent,

              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20 ,vertical: 6),
                child: Text(
                  "Lista rzeczy do kupienia",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            */

            SizedBox(

              height: 400,

              child: Expanded(
                child: GetBuilder<ProduktController>(
                  builder: (produktController) =>
                      GroupedListView<ProduktZakupy, String>(

                        elements: produktController.zakupyWyswietlaj,
                        groupBy: (zakup) {
                          return zakup.kategoriaZakupy;
                        },
                        useStickyGroupSeparators: false,

                        groupHeaderBuilder: (ProduktZakupy zakup) => Padding(
                          padding: const EdgeInsets.all(8.0),

                          child: Text(
                            zakup.kategoriaZakupy,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),

                        itemBuilder: (context, ProduktZakupy zakup) {
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
                                        Navigator
                                            .push(context, MaterialPageRoute(builder: (context) => ZakupDetail(chosen_produkt: zakup)))
                                            .then((value) => {} );
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
                                                  child: Text(zakup.nazwaProduktu + ' : ' + zakup.ilosc.toString() + ' ' + zakup.miara),
                                                ),

                                                IconButton(
                                                    icon: Icon(Icons.add_shopping_cart_rounded),
                                                    onPressed: () {
                                                      // TODO remove from zakupy list
                                                      // TODO add to doKupienia list
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
              ),
            ),



            Card(
              elevation: 5.0,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              color: Colors.lightGreen,

              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20 ,vertical: 6),
                child: Text(
                  "Lista rzeczy w koszyku",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // TODO Display list of produkts added to doKupienia

            Expanded(
              child: GetBuilder<ProduktController> (
                  builder: (produktController) =>
                      //Text("TEXT ADDED BY THE SECOND GETBUILDER"),


                      ListView.builder(
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
                                            produktController.doKupienia[index].nazwaProduktu
                                                + " : "
                                                + produktController.doKupienia[index].ilosc.toString()
                                                + produktController.doKupienia[index].miara
                                        ),
                                      ),


                                    ],
                                  ),
                                ),
                              ),




                      )




              ),
            ),

            //Text("TEST TEST"),
          ],
        ),
      ),



















    );
  }

}