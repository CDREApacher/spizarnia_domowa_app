import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spizarnia_domowa_app/widget/custom_button.dart';
import 'package:spizarnia_domowa_app/model/produkt.dart';
import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';


class Home extends StatelessWidget{

  final nameController = TextEditingController();
  final idController = TextEditingController();

  final ProduktController produktController = ProduktController.to;

  onItemPressed(Produkt produkt) {}

  onClearPressed() {
    nameController.clear();
    idController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test połączenia z backendem')),
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Selected item goes here'),
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: "Name"),
            ),
            TextField(
              controller: idController,
              decoration: InputDecoration(hintText: "ID"),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  onPressed: () => {},
                  text: "Add",
                ),
                CustomButton(
                  onPressed: () => {},
                  text: "Update",
                ),
                CustomButton(
                  onPressed: () => onClearPressed(),
                  text: "Clear",
                ),
              ],
            ),
          SizedBox(height: 16),




            GetBuilder<ProduktController>(builder: (produktController) =>

            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width:200,
                      child: InkWell(
                        onTap: () =>
                            onItemPressed(produktController.produkty[index]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Text(produktController.produkty[index].nazwa),
                            SizedBox(height: 4),
                            Text(produktController.produkty[index].id.toString()),
                            SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => {},
                    ),
                  ],
                ),
                  separatorBuilder: (context, index) =>
                      Divider(color: Colors.black),
                  itemCount: produktController.produkty.length),
              ),

              ),


            ],
          ),
        ),
      );
  }// Widget build

}// class Home