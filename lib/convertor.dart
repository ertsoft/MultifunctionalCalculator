import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

/*  own file */

import './menu.dart';
import 'convertor_tabs/degrees2radiansTab.dart';
import 'convertor_tabs/lengthsTab.dart';
import 'convertor_tabs/number2conversionTab.dart';
import 'convertor_tabs/speedTab.dart';
import 'convertor_tabs/surfaceTab.dart';
import 'convertor_tabs/temperatureTab.dart';
import 'convertor_tabs/timeTab.dart';
import 'convertor_tabs/volumeTab.dart';

class Convertor extends StatefulWidget {
  @override
  _ConvertorState createState() => _ConvertorState();
}

class _ConvertorState extends State<Convertor> {

  @override
  void initState() {
    super.initState();

    setPortrait();
  }

  @override
  void dispose() {
    setAllOrientations();

    super.dispose();
  }

  Future setPortrait() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  Future setAllOrientations() async {
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController
      (length: 8,
        child: Scaffold(
          appBar: AppBar(
            //backgroundColor: Colors.blueGrey,

            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.pink[100], Colors.deepPurple.shade900],
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft)),
            ),

          bottom: TabBar(
            indicatorColor: Colors.tealAccent,
            isScrollable: true,
           tabs: [
             Tab(icon: Icon(Icons.waves_sharp), text: "Lungimi"),
             Tab(icon: Icon(Icons.aspect_ratio), text: "Arii"),
             Tab(icon: Icon(Icons.apartment), text: "Volume"),
             Tab(icon: Icon(Icons.bar_chart), text: "Număr"),
             Tab(icon: Icon(Icons.ac_unit), text: "Temperatură"),
             Tab(icon: Icon(Icons.speed), text: "Viteză"),
             Tab(icon: Icon(Icons.access_time_outlined), text: "Timp"),
             Tab(text: " Grade \n----------\nRadiani"),
           ],
          ),
           ),
          drawer: Menu(),
          body: TabBarView(children: [
            LengthsConvertor(),
            SurfaceConvertor(),
            VolumeConvertor(),
            Number2Convertor(),
            TemperatureConvertor(),
            SpeedConvertor(),
            TimeConvertor(),
            Degrees2Radians(),
          ],

          ),
        ),
    ) ;

  }
}


