import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/*  own file */

import './menu.dart';

class IntegralsCalculator extends StatefulWidget {
  @override
  _IntegralsCalculatorState createState() => _IntegralsCalculatorState();
}

class _IntegralsCalculatorState extends State<IntegralsCalculator> {
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
    return Scaffold(
      backgroundColor: Colors.blueGrey[400],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: Menu(),
      body: Container(
        child: Text("Calculator de integrale"),
      ),
    );
  }
}
