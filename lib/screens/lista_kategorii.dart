import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uuid/uuid.dart';

import 'package:grouped_list/grouped_list.dart';

import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';
import 'package:spizarnia_domowa_app/model/kategoria.dart';
import 'package:spizarnia_domowa_app/model/kategoria_zakupy.dart';
import 'package:spizarnia_domowa_app/model/grupa.dart';

class ListaKategorii extends StatefulWidget{
  @override
  _ListaKategorii createState() => _ListaKategorii();

}

class _ListaKategorii extends State<ListaKategorii>{

  var uuid = Uuid();

  final ProduktController produktController = ProduktController.to;


  final nameController = TextEditingController();
  final listaController = TextEditingController();


  onClearPressed() {
    nameController.clear();
    //listaController.clear();
  }

  onAddKategoriaPressed() {

    Grupa grupaKategorii = new Grupa(
      nazwa_server: produktController.currentlyChosenGroupName,
      kod_grupy: produktController.currentlyChosenGroupCode,
    );

    if(listaController.text == "produkty"){

      List<String> kategoriaProduktyCheck = [];
      produktController.kategorie.forEach((element) {kategoriaProduktyCheck.add(element.nazwa); } );

      if(kategoriaProduktyCheck.contains(nameController.text)){

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Taka kategoria już istnieje!"),
              duration: Duration(seconds: 2),
            )
        );
        nameController.clear();

      }else{

        Kategoria kategoria = new Kategoria(
          objectId: uuid.v4(),
          nazwa: nameController.text,
          grupa: grupaKategorii,
        );
        produktController.addKategoriaProdukty(kategoria);
      }
    }

    if(listaController.text == "zakupy"){

      List<String> kategoriaZakupyCheck = [];
      produktController.kategorieZakupy.forEach((element) {kategoriaZakupyCheck.add(element.nazwa); } );

      if(kategoriaZakupyCheck.contains(nameController.text)){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Taka kategoria już istnieje!"),
              duration: Duration(seconds: 2),
            )
        );
        nameController.clear();

      }else{

        KategoriaZakupy kategoriaZakupy = new KategoriaZakupy(
          objectId: uuid.v4(),
          nazwa: nameController.text,
          grupa: grupaKategorii,
        );
        produktController.addKategoriaZakupy(kategoriaZakupy);
      }
    }
    onClearPressed();
  }

  onDeleteKategoriaProduktuPressed(String objectId){
    showDialog(context: context, builder: (_) =>
        AlertDialog(
          title: Text('Czy na pewno usunąć kategorię produktu?'),

          actions: [
            TextButton(
                onPressed: () {
                  produktController.deleteKategorieProdukty(objectId);
                  Navigator.pop(context);// close popup
                },
                child: Text('Usuń')
            ),

            TextButton(
                onPressed: () {
                  Navigator.pop(context);// close popup
                },
                child: Text('Anuluj')
            ),
          ],
        ),
    );
  }

  onDeleteKategoriaZakupuPressed(String objectId){
    showDialog(context: context, builder: (_) =>
        AlertDialog(
          title: Text('Czy na pewno usunąć kategorię zakupu?'),

          actions: [
            TextButton(
                onPressed: () {
                  produktController.deleteKategorieZakupy(objectId);
                  Navigator.pop(context);// close popup
                },
                child: Text('Usuń')
            ),

            TextButton(
                onPressed: () {
                  Navigator.pop(context);// close popup
                },
                child: Text('Anuluj')
            ),
          ],
        ),
    );
  }

  @override
  void initState() {
    produktController.fetchKategorieProdukty();
    produktController.fetchKategorieZakupy();
    listaController.text = "produkty";
    super.initState();
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(

      appBar: AppBar(
        toolbarHeight: 42.5,
        title: Text('Spiżarnia Domowa'),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {

          showDialog(
              context: context,
              builder: (context) {

                return StatefulBuilder(
                    builder: (context, setState) {

                      return AlertDialog(
                        title: Text('Dodaj kategorię:'),

                        content: Column(

                          children: [

                            TextField(
                              controller: nameController,
                              decoration: InputDecoration(hintText: "Nazwa kategorii"),
                            ),

                            SizedBox(
                              width: 10,
                              height: 20,
                            ),
                            Text("Dodaj do listy:"),

                            DropdownButton<String>(
                              value: listaController.text,
                              icon: Icon(Icons.arrow_downward_rounded),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Colors.deepPurpleAccent),

                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String newValue){
                                setState(() {
                                  //dropdownButtonValue = newValue;
                                  listaController.text = newValue;
                                });
                              },

                              items: <String>['produkty', 'zakupy']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),

                            ),

                          ], // children

                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                // Add new Kategoria here
                                onAddKategoriaPressed();
                                Navigator.pop(context);// close popup
                                //Navigator.pop(context);// go back to list of products
                              },
                              child: Text('Dodaj')
                          ),
                        ],

                      );

                    } // StatefullBuilder builder

                );
              } // showDialog builder
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,


      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Card(
              elevation: 5.0,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              //color: Colors.lightGreen,

              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20 ,vertical: 6),
                child: Text(
                  "Kategorie Produktów",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // Produkt category list
            Expanded(
              child: GetBuilder<ProduktController> (
                  builder: (produktController) =>

                      ListView.builder(
                          itemCount: produktController.kategorie.length,
                          itemBuilder: (context, index) =>
                              Container(
                                height: 55,
                                child: Card(
                                  elevation: 5,
                                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [

                                      if(produktController.kategorie[index].nazwa != 'Inne')
                                        IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: () => {
                                              onDeleteKategoriaProduktuPressed(produktController.kategorie[index].objectId)
                                            }),

                                      if(produktController.kategorie[index].nazwa == 'Inne')
                                        Opacity(
                                          opacity: 0.0,
                                          child: IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: () => {},
                                          ),
                                        ),

                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10 ,vertical: 6),
                                        child: Text(
                                            produktController.kategorie[index].nazwa
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                      )
              ),
            ),

            Card(
              elevation: 5.0,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              //color: Colors.lightGreen,

              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20 ,vertical: 6),
                child: Text(
                  "Kategorie Zakupów",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // Shopping category list
            Expanded(
              child: GetBuilder<ProduktController> (
                  builder: (produktController) =>

                      ListView.builder(
                          itemCount: produktController.kategorieZakupy.length,
                          itemBuilder: (context, index) =>
                              Container(
                                height: 55,
                                child: Card(
                                  elevation: 5,
                                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [

                                      if(produktController.kategorieZakupy[index].nazwa != 'Inne')
                                        IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: () => {
                                              onDeleteKategoriaZakupuPressed(produktController.kategorieZakupy[index].objectId)
                                            }),

                                      if(produktController.kategorieZakupy[index].nazwa == 'Inne')
                                        Opacity(
                                          opacity: 0.0,
                                          child: IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: () => {},
                                          ),
                                        ),

                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10 ,vertical: 6),
                                        child: Text(
                                            produktController.kategorieZakupy[index].nazwa
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                      )
              ),
            ),

          ],
        ),
      ),
      );

  } // Build

}