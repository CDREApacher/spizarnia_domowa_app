import 'package:flutter/material.dart';

import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';

class ListaZakupow extends StatefulWidget{
  @override
  _ListaZakupow createState() => _ListaZakupow();

}

class _ListaZakupow extends State<ListaZakupow>{

  final ProduktController produktController = ProduktController.to;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 42.5,
        title: Text("Lista Zakupów"),
      ),
    );
  }
}