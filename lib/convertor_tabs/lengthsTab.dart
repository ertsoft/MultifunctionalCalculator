import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:math' as math;

class LengthsConvertor extends StatefulWidget {
  @override
  _LengthsConvertorState createState() => _LengthsConvertorState();
}

class _LengthsConvertorState extends State<LengthsConvertor> {
  final fromController = TextEditingController();

  var _lengths_dictionary = {
    'mm': 0,
    'cm': 1,
    'dm': 2,
    'm': 3,
    'dam': 4,
    'hm': 5,
    'km': 6
  };

  String _FirstCurrentItemSelected = 'mm';
  String _SecondCurrentItemSelected = 'mm';
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
            Text('\n'),
            ListTile(
              leading: Container(
                width: 345,
                child: Transform.scale(
                  scale: scale,
                  child: IconButton(
                    icon: Icon(
                      Icons.swap_horizontal_circle_outlined,
                      color: Colors.deepPurple.shade900,
                      size: 80,
                    ),
                    onPressed: () {
                      switchVales();
                    },
                  ),
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
            Text('\n'),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                _inputQuestion,
                style: TextStyle(
                    fontFamily: "Courier",
                    fontSize: _inputQuestion.length < 15 ? 40 : 15,
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

      int first_index = _lengths_dictionary[_FirstCurrentItemSelected];
      int second_index = _lengths_dictionary[_SecondCurrentItemSelected];

      int difference_factor = first_index - second_index;

      _inputQuestion =
          (input_value * math.pow(10, difference_factor)).toString();
    });

    scaleArrow();
  }
}
