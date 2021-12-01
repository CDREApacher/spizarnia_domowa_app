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

    super.initState();
    //Dont actually call here
    //produktController.fetchFromDatabse();

  }


  Future<Widget> decideHomeScreen() async {

    SharedPreferences sprefs = await SharedPreferences.getInstance();
    String code = sprefs.getString('spidom_default_group_code') ?? 'none';


    if(code != 'none'){
      produktController.getDefaultDeviceGroup(); // also downloads all from DB
      produktController.getDeviceGroupList();
      return HomeMain();
    } else {
      return Witaj();
    }
  }


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.blue),
      ),

      home: FutureBuilder(
        future: decideHomeScreen(),
        builder: (BuildContext context, AsyncSnapshot<Widget> widget) {

          if(widget.connectionState == ConnectionState.done){
            if (!widget.hasData) {
              return Center(
                  child: Text('Wystąpił Błąd')
              );
            }
            return widget.data;
          }
          return Center(
            child: CircularProgressIndicator(),
          );

        }, // builder
      ),

    );
  }// Widget build
}


