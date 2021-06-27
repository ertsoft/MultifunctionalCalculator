import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

/*  own file */
import './buttons.dart';
import './menu.dart';

class MultipleCalculator extends StatefulWidget {
  @override
  _MultipleCalculatoState createState() => _MultipleCalculatoState();
}

class _MultipleCalculatoState extends State<MultipleCalculator> {
  @override
  void initState() {
    super.initState();

    setLandscape();
  }

  @override
  void dispose() {
    super.dispose();
    setAllOrientations();
  }

  Future setLandscape() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  Future setAllOrientations() async {
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  var userQuestion = "";

  var userAnswer = "";

  final List<String> buttons = [
    'lg',
    'ln',
    'log',
    'C',
    '⌫',
    '%',
    '÷',
    '√',
    '∛',
    '^',
    '9',
    '8',
    '7',
    'x',
    'sin',
    'cos',
    'tan',
    '6',
    '5',
    '4',
    '-',
    'Rad',
    '|x|',
    'cot',
    '3',
    '2',
    '1',
    '+',
    'ℼ',
    'e',
    'x!',
    ',',
    '0',
    '( )',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 30,
      ),
      drawer: Menu(),
      body: Container(
          child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(userQuestion, style: TextStyle(fontSize: 25)),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(userAnswer,
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: GridView.builder(
                itemCount: 35,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.99,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 2,
                    crossAxisCount: 7),
                itemBuilder: (context, int index) {
                  // Clear button
                  if (index == 3) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          userQuestion = '';
                          userAnswer = "";
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.white30,
                      textColor: Colors.red,
                    );
                  }

                  // Delete button
                  else if (index == 4) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          if (userQuestion.length >= 1) {
                            userQuestion = userQuestion.substring(
                                0, userQuestion.length - 1);
                          } else {
                            userQuestion = '';
                          }
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.white30,
                      textColor: Colors.lightGreenAccent,
                    );
                  }

                  // Equal button
                  else if (index == buttons.length - 1) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          equalPressed();
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.orangeAccent,
                      textColor: Colors.black,
                    );
                  }

                  // Pharantese  button
                  else if (index == buttons.length - 2) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          GetPharantese();
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.white30,
                      textColor: Colors.black,
                    );
                  }

                  // the Others buttons:
                  else if (index < 35 &&
                      index != 3 &&
                      index != 4 &&
                      index != buttons.length - 1 &&
                      index != buttons.length - 2) {
                    return MyButton(
                      buttonTapped: userQuestion != '' &&
                              isOperator(
                                  userQuestion[userQuestion.length - 1]) &&
                              isOperator(buttons[index])
                          ? () => {}
                          : userQuestion == '' && buttons[index] == ','
                              ? () {
                                  setState(() {
                                    userQuestion += '0' + buttons[index];
                                  });
                                }
                              : userQuestion == '' && buttons[index] == '^'
                                  ? () => {}
                                  : userQuestion == '' &&
                                              isOperator(buttons[index]) ||
                                          buttons[index] == 'x!' &&
                                              userQuestion == ''
                                      ? () => {}
                                      : buttons[index] == '|x|'
                                          ? () {
                                              setState(() {
                                                userQuestion += 'abs';
                                              });
                                            }
                                          : buttons[index] == 'x!'
                                              ? () {
                                                  setState(() {
                                                    userQuestion += '!';
                                                  });
                                                }
                                              : buttons[index] == 'lg'
                                                  ? () {
                                                      setState(() {
                                                        userQuestion += 'lg(';
                                                      });
                                                    }
                                                  : buttons[index] == '∛'
                                                      ? () => {}
                                                      : () {
                                                          setState(() {
                                                            userQuestion +=
                                                                buttons[index];
                                                          });
                                                        },
                      buttonText: buttons[index],
                      color: isOperator(buttons[index])
                          ? Colors.brown
                          : Colors.white30,
                      textColor: isOperator(buttons[index])
                          ? Colors.black
                          : isFromMultiple(buttons[index])
                              ? Colors.black
                              : Colors.white,
                    );
                  }

                  // index should be < 20. If we don't put this else, then
                  // it will grow to infinite. !!!
                  else {
                    return null;
                  }
                },
              ),
            ),
          )
        ],
      )),
    );
  }

  bool isOperator(String x) {
    if (x == '÷' || x == '%' || x == '-' || x == '+' || x == 'x' || x == '=') {
      return true;
    }
    return false;
  }

  bool isFromMultiple(String x) {
    if (x == 'lg' ||
        x == 'ln' ||
        x == 'log' ||
        x == '' ||
        x == '√' ||
        x == '∛' ||
        x == '^' ||
        x == 'sin' ||
        x == 'cos' ||
        x == 'tan' ||
        x == 'Rad' ||
        x == '|x|' ||
        x == 'cot' ||
        x == 'ℼ' ||
        x == 'e' ||
        x == ',' ||
        x == '( )' ||
        x == 'x!') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    int startPosition = 0;
    int endPosition = 0;

    for (int i = 0; i < finalQuestion.length; i++) {
      if (finalQuestion.length == 2) {
        finalQuestion = GetFactorial(finalQuestion[i]);
      }

      // if (IsNumber(finalQuestion[i])){
      //     startPosition = i;
      //     if(finalQuestion[i+1] != '!'){
      //       endPosition += 1;
      //     }
      //     else if(finalQuestion[i+1] == '!'){
      //       finalQuestion = finalQuestion.substring(0, i) +
      //                        GetFactorial(finalQuestion.substring(startPosition, endPosition));
      //     }
      // }
      // else if(finalQuestion.length > 2){
      //   if(finalQuestion[i+1] == '!') {
      //     print(finalQuestion);
      //     finalQuestion = finalQuestion.substring(0, i) +
      //         GetFactorial(finalQuestion[i]);
      //     print(finalQuestion);
      //   }
      // }
      // else if(finalQuestion.length >2 && i+1 > finalQuestion.length){
      //   if(finalQuestion[i+1] == '!') {
      //     print(finalQuestion);
      //     finalQuestion = finalQuestion.substring(0, i) +
      //         GetFactorial(finalQuestion[i]) + finalQuestion.substring(i+2, finalQuestion.length-1);
      //     print(finalQuestion);
      //   }
      // }

      else {break;}
    }

    finalQuestion = finalQuestion.replaceAll('x', '*');
    finalQuestion = finalQuestion.replaceAll(',', '.');
    finalQuestion = finalQuestion.replaceAll('÷', '/');
    finalQuestion = finalQuestion.replaceAll("cot", '1/tan');
    finalQuestion = finalQuestion.replaceAll("ℼ", '3.1415926535897932');
    finalQuestion = finalQuestion.replaceAll("e", '2.718281828459045');
    finalQuestion =
        finalQuestion.replaceAll("Rad", '(3.1415926535897932/180)*');
    finalQuestion = finalQuestion.replaceAll("√", 'sqrt');
    finalQuestion = finalQuestion.replaceAll('!', 'findFactorial');
    finalQuestion = finalQuestion.replaceAll('lg', 'log10');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }

  String GetFactorial(String numberINstr) {
    var num = int.parse(numberINstr);
    int factorial = 1;

    for (int i = 1; i <= num; i++) {
      factorial = factorial * i;
    }

    return factorial.toString();
  }

  bool IsNumber(String x) {
    if (x == '0' ||
        x == '1' ||
        x == '2' ||
        x == '3' ||
        x == '4' ||
        x == '5' ||
        x == '6' ||
        x == '7' ||
        x == '8' ||
        x == '9') {
      return true;
    }
  }

  void GetPharantese() {
    var rightNumber = 0;
    var leftNumber = 0;

    for (int i = 0; i < userQuestion.length; i++) {
      if (userQuestion[i] == '(') {
        leftNumber += 1;
      } else if (userQuestion[i] == ')') {
        rightNumber += 1;
      }
    }

    if (rightNumber == leftNumber) {
      setState(() {
        userQuestion += '(';
      });
    } else if (isOperator(userQuestion[userQuestion.length - 1])) {
      setState(() {
        userQuestion += '(';
      });
    } else if (leftNumber > rightNumber) {
      setState(() {
        userQuestion += ')';
      });
    }
  }
}
