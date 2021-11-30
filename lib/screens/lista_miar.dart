import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:uuid/uuid.dart';

import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';
import 'package:spizarnia_domowa_app/model/miara.dart';
import 'package:spizarnia_domowa_app/model/grupa.dart';


class ListaMiar extends StatefulWidget {

  @override
  _ListaMiar createState() => _ListaMiar();

}



class _ListaMiar extends State<ListaMiar> {

  var uuid = Uuid();

  final ProduktController produktController = ProduktController.to;

  final nameController = TextEditingController();

  onAddMiaraPressed(){

    List<String> miaraCheck = [];
    produktController.miary.forEach((element) {miaraCheck.add(element.miara);});

    if(miaraCheck.contains(nameController.text)){

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Taka miara już istnieje!"),
            duration: Duration(seconds: 2),
          )
      );
      nameController.clear();

    }else{
      Grupa grupaMiary = new Grupa(
        nazwa_server: produktController.currentlyChosenGroupName,
        kod_grupy: produktController.currentlyChosenGroupCode,
      );

      Miara miara = new Miara(
        objectId: uuid.v4(),
        miara: nameController.text,
        grupa: grupaMiary,
      );

      produktController.addMiary(miara);
      nameController.clear();
    }
  }

  onDeleteMiaraPressed(String objectId){
    showDialog(context: context, builder: (_) =>
        AlertDialog(
          title: Text('Czy na pewno usunąć miarę?'),

          actions: [
            TextButton(
                onPressed: () {
                  produktController.deleteMiary(objectId);
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
  void initState(){
    produktController.fetchMiary();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        toolbarHeight: 42.5,
        title: Text('Lista Miar'),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {

          showDialog(
              context: context,
              builder: (_) =>
                  AlertDialog(
                    title: Text("Dodaj nową miarę: "),

                    content: TextField(
                      controller: nameController,
                      decoration: InputDecoration(hintText: "Nazwa"),
                    ),

                    actions: [
                      TextButton(
                          onPressed: () {
                            // Add new Miara here
                            onAddMiaraPressed();
                            Navigator.pop(context);// Close the popup
                            //Navigator.pop(context);// Return to previous screen
                          },
                          child: Text('Dodaj')
                      ),
                    ],
                  )
          );
        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,


      body: GetBuilder<ProduktController> (
      builder: (produktController) =>
          ListView.builder(
            itemCount: produktController.miary.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 8,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    if(produktController.miary[index].miara != 'Inne')
                      IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => {
                            onDeleteMiaraPressed(produktController.miary[index].objectId)
                          }),

                    if(produktController.miary[index].miara == 'Inne')
                      Opacity(
                        opacity: 0.0,
                        child: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => {},
                        ),
                      ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text(produktController.miary[index].miara),
                    ),

                  ],
                ),

              );
              }, // itemBuilder

          ),
      ),
    );

  }




}