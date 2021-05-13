import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spizarnia_domowa_app/screens/home.dart';
import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';

class AddAtrybut extends StatefulWidget{
  @override
  _AddAtrybut createState() => _AddAtrybut();
}

final ProduktController produktController = ProduktController.to;

class _AddAtrybut extends State<AddAtrybut> {
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}