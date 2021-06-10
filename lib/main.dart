import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spizarnia_domowa_app/screens/home.dart';
import 'package:spizarnia_domowa_app/screens/home_main.dart';
import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';
import 'package:spizarnia_domowa_app/screens/screen_choice.dart';

void main() {
  Get.put(ProduktController());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final ProduktController produktController = ProduktController.to;

  @override
  void initState() {
    super.initState();
    produktController.fetchAllProdukts();
    produktController.fetchKategorieProdukty();
    produktController.fetchKategorieZakupy();
    produktController.fetchMiary();
    produktController.fetchZakupy();

    //produktController.fetchAllKategorie();
    //produktController.fetchZakupy();

    //produktController.fetchProduktyKategorii("napoje");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.blue),
      ),
      home: HomeMain(),
    );
  }// Widget build
}


