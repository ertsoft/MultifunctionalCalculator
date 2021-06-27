import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:math' as math;

class Degrees2Radians extends StatefulWidget {
  @override
  _Degrees2RadiansState createState() => _Degrees2RadiansState();
}

class _Degrees2RadiansState extends State<Degrees2Radians> {
  final fromController = TextEditingController();

  var _lengths_dictionary = {
    'grade': 0,
    'radiani': 1,
    'grade sexagesimale': 2,
    'grade centesimale': 3,
  };

  String _FirstCurrentItemSelected = 'grade';
  String _SecondCurrentItemSelected = 'grade';
  var _inputQuestion = '';
  double scale = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Colors.lightBlue[900],
          Colors.deepPurple.shade400,
          Colors.pink[100],
          Colors.pink[200]
        ],
      )),
      child: Card(
        elevation: 1.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                child: Text(
                  "--  din  -- ",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                child: DropdownButton<String>(
                  // value: _currentItemSelected,

                  icon: const Icon(Icons.arrow_drop_down),

                  iconSize: 25,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurple.shade900,
                  ),

                  value: _FirstCurrentItemSelected,

                  items: _lengths_dictionary.keys
                      .map((String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: TextStyle(
                                    fontSize: 24, color: Colors.black)),
                          ))
                      .toList(),

                  onChanged: (String newValueSelected) {
                    setState(() {
                      _FirstCurrentItemSelected = newValueSelected;
                    });
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 180,
                child: TextField(
                  style: TextStyle(fontSize: 28),
                  controller: fromController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
            ),
            Text(''),
            ListTile(
              leading: Container(
                width: 350,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      //width: 100,
                      child: IconButton(
                        icon: Icon(
                          Icons.swap_vert,
                          color: Colors.blueGrey[400],
                          size: 40,
                        ),
                        onPressed: () => {},
                      ),
                    ),
                    Expanded(
                      //width: 150,
                      flex: 3,
                      child: Transform.scale(
                        scale: scale,
                        child: IconButton(
                          icon: Icon(
                            Icons.swap_horizontal_circle_outlined,
                            color: Colors.deepPurple.shade900,
                            size: 62,
                          ),
                          onPressed: () {
                            switchVales();
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      //width: 100,
                      child: IconButton(
                        icon: Icon(
                          Icons.padding,
                          color: Colors.deepPurpleAccent[100],
                          size: 40,
                        ),
                        onPressed: () => {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                child: Text(
                  "\n\n --  în  --    ",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                child: DropdownButton<String>(
                  // value: _currentItemSelected,

                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 25,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurple.shade900,
                  ),

                  value: _SecondCurrentItemSelected,

                  items: _lengths_dictionary.keys
                      .map((String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: TextStyle(
                                    fontSize: 24, color: Colors.black)),
                          ))
                      .toList(),

                  onChanged: (String newValueSelected) {
                    setState(() {
                      _SecondCurrentItemSelected = newValueSelected;
                    });
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                _inputQuestion,
                style: TextStyle(
                    fontFamily: "Courier",
                    fontSize: _inputQuestion.length < 15 ? 40 : 22,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    backgroundColor: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void scaleArrow() {
    Timer _timer;

    const period = const Duration(milliseconds: 0);
    _timer = Timer.periodic(period, (timer) {
      setState(() {
        scale = 1.6;
      });
    });

    const period_end = const Duration(milliseconds: 50);
    new Timer.periodic(period_end, (Timer t) {
      setState(() {
        scale = 1;
      });
      _timer.cancel();
      t.cancel();
    });
  }

  void switchVales() {
    setState(() {
      var input_value = double.parse(
        fromController.text == '' ? '0.0' : fromController.text,
      );

      if (_FirstCurrentItemSelected == 'grade' &&
          _SecondCurrentItemSelected == 'radiani') {
        _inputQuestion = (input_value * (math.pi / 180)).toString();
      } else if (_FirstCurrentItemSelected == 'radiani' &&
          _SecondCurrentItemSelected == 'grade') {
        _inputQuestion = (input_value * (180 / math.pi)).toString();
      } else if (_FirstCurrentItemSelected == _SecondCurrentItemSelected) {
        _inputQuestion = (input_value).toString();
      } else if (_FirstCurrentItemSelected == 'grade' &&
              _SecondCurrentItemSelected == 'grade sexagesimale' ||
          _FirstCurrentItemSelected == 'grade sexagesimale' &&
              _SecondCurrentItemSelected == 'grade') {
        _inputQuestion = (input_value).toString();
      } else if (_FirstCurrentItemSelected == 'grade centesimale' &&
              _SecondCurrentItemSelected == 'grade' ||
          _FirstCurrentItemSelected == 'grade centesimale' &&
              _SecondCurrentItemSelected == 'grade sexagesimale') {
        _inputQuestion = (input_value * 0.9).toString();
      } else if (_FirstCurrentItemSelected == 'grade' &&
              _SecondCurrentItemSelected == 'grade centesimale' ||
          _FirstCurrentItemSelected == 'grade sexagesimale' &&
              _SecondCurrentItemSelected == 'grade centesimale') {
        _inputQuestion = (input_value / 0.9).toString();
      }
    });
    scaleArrow();
  }
}
