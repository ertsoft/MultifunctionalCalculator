import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/services.dart';

/*  own file */
import './buttons.dart';
import './menu.dart';

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
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

  var userQuestion = "";
  var userAnswer = "";

  final List<String> buttons = [
    'C',
    '⌫',
    '%',
    '÷',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    ',',
    '0',
    '( )',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.yellowAccent[100], Colors.purple[900]],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft)),
        ),
        elevation:5,
        title: Text("Calculator Simplu",
          style: TextStyle(fontStyle: FontStyle.italic),),
      ),
      drawer: Menu(),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Flexible(
                fit: FlexFit.loose,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        alignment: Alignment.centerRight,
                        //child: Text(userQuestion, style: TextStyle(fontSize: 35))
                        child: RichText(
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: userQuestion,
                                style: TextStyle(
                                    fontSize: 35, color: Colors.black)),
                          ]),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(20),
                          alignment: Alignment.centerRight,
                          child: Text(
                            userAnswer,
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                )),
            Flexible(
              fit: FlexFit.loose,
              flex: 3,

              // means that this Expanded is twice bigger than the other

              child: Container(
                child: GridView.builder(
                    itemCount: 20,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 8,
                        crossAxisCount: 4),
                    itemBuilder: (context, int index) {

                      // Clear button:
                      if (index == 0) {
                        return MyButton(
                          buttonTapped: () {
                            setState(() {
                              userQuestion = '';
                              userAnswer = "";
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.grey[300],
                          textColor: Colors.redAccent[400],
                        );
                      }

                      // Delete button
                      else if (index == 1) {
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
                          color: Colors.grey[300],
                          textColor: Colors.deepPurple[900],
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

                              if (userQuestion.length == 17){ return null;}
                              else {GetPharantese();}
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.grey[300],
                          textColor: Colors.black,
                        );
                      }

                      // the Others buttons:
                      else if (index < 20 &&
                          index != 1 &&
                          index != 0 &&
                          index != buttons.length - 1 &&
                          index != buttons.length - 2) {
                        return MyButton(
                          buttonTapped: userQuestion.length == 17
                              ? () => {}
                              : userQuestion != '' &&
                                      isOperator(userQuestion[
                                          userQuestion.length - 1]) &&
                                      isOperator(buttons[index])
                                  ? () => {}
                                  : userQuestion == '' && buttons[index] == ','
                                      ? () {
                                          setState(() {
                                            userQuestion +=
                                                '0' + buttons[index];
                                          });
                                        }
                                      : () {
                                          setState(() {
                                            userQuestion += buttons[index];
                                          });
                                        },
                          buttonText: buttons[index],
                          color: isOperator(buttons[index])
                              ? Colors.grey[300]
                              : Colors.grey[300],
                          textColor: isOperator(buttons[index])
                              ? Colors.orange[700]
                              : Colors.black,
                        );
                      }

                      // index should be < 20. If we don't put this else, then
                      // it will grow to infinite. !!!
                      else {
                        return null;
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '÷' || x == '%' || x == '-' || x == '+' || x == 'x' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    finalQuestion = finalQuestion.replaceAll(',', '.');
    finalQuestion = finalQuestion.replaceAll('÷', '/');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
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
