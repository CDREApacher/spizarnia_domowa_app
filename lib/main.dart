import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spizarnia_domowa_app/screens/home.dart';
import 'package:spizarnia_domowa_app/screens/home_main.dart';
import 'package:spizarnia_domowa_app/controller/produkt_controller.dart';
import 'package:spizarnia_domowa_app/screens/screen_choice.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:spizarnia_domowa_app/screens/witaj.dart';

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


  void clearPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }


  @override
  void initState() {

    //clearPreferences();
    //produktController.test_addTestGrupy();
    produktController.getDefaultDeviceGroup();
    produktController.getDeviceGroupList();
    super.initState();

    //produktController.fetchAllProdukts();
    //produktController.fetchKategorieProdukty();
    //produktController.fetchKategorieZakupy();
    //produktController.fetchMiary();
    //produktController.fetchZakupy();
    // Replece the above with this; Dont actually call here
    //produktController.fetchFromDatabse();

  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.blue),
      ),
      home: HomeMain(),
    );
  }// Widget build
}


