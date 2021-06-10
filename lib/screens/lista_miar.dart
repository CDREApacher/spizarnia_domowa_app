import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uuid/uuid.dart';

import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';
import 'package:spizarnia_domowa_app/model/miara.dart';

class ListaMiar extends StatefulWidget {
  @override
  _ListaMiar createState() => _ListaMiar();
}



class _ListaMiar extends State<ListaMiar> {

  var uuid = Uuid();

  final ProduktController produktController = ProduktController.to;

  final nameController = TextEditingController();

  onAddMiaraPressed(){
    Miara miara = new Miara(
      objectId: uuid.v4(),
      miara: nameController.text,
    );

    produktController.addMiary(miara);
  }

  /*
  onDeleteMiaraPressed(String objectId){
    produktController.deleteMiary(objectId);
  }
   */

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
                            Navigator.pop(context);
                            Navigator.pop(context);
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(produktController.miary[index].miara),
                    ),


                    IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: (){

                          /*
                          showDialog(
                              context: context,
                              builder: (_) =>
                                  AlertDialog(
                                    title: Text('Usunąć kategorię: "' + produktController.miary[index].miara + '"'),

                                    //content: ,

                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            // Delete selected Miara here
                                            //onDeleteMiaraPressed(produktController.miary[index].objectId);
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Usuń',
                                            style: TextStyle(
                                                color: Colors.red),
                                          )
                                      ),
                                    ],
                                  )
                          );
                          */
                        }


                    ),

                  ],
                ),

              );
              }, // itemBuilder



            //separatorBuilder: (context, index) => Divider(
            //  color: Colors.black,
            //),



          ),
      ),
    );

  }




}