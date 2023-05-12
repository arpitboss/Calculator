import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'buttons.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = '';
  var userAnswer = '';

  //final kMyTextStyle = TextStyle(fontSize: 20.0, color: Colors.pink[900]);
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    '+/-',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent[200],
          title: const Center(
            child: Icon(
              Icons.calculate_outlined,
              size: 50,
            ),
            // ,style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),)),
          ),
        ),
        backgroundColor: Colors.black12,
        body: Column(
          children: <Widget>[
            Expanded(
                child: Container(
              color: Colors.black12,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 50.0),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userQuestion,
                      style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.centerRight,
                      child: Text(
                        userAnswer,
                        style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            )),
            Expanded(
              flex: 2,
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return MyButton(
                        onPressed: () {
                          setState(() {
                            userQuestion = '';
                            userAnswer = '0';
                          });
                        },
                        color: Colors.redAccent,
                        text: buttons[index],
                        textColor: Colors.white,
                      );
                    } else if (index == 1) {
                      return MyButton(
                        onPressed: () {
                          setState(() {
                            userQuestion = userQuestion.substring(
                                0, userQuestion.length - 1);
                          });
                        },
                        color: Color(0xFFd78c28),
                        text: buttons[index],
                        textColor: Colors.white,
                      );
                    }

                    // Equal Button
                    else if (index == buttons.length - 1) {
                      return MyButton(
                        onPressed: () {
                          setState(() {
                            calculation();
                          });
                        },
                        color: Color(0xFFd78c28),
                        text: buttons[index],
                        textColor: Colors.white,
                      );
                    } else {
                      return MyButton(
                        onPressed: () {
                          setState(() {
                            userQuestion += buttons[index];
                          });
                        },
                        color: isOperator(buttons[index])
                            ? Colors.blueAccent[400]
                            : Colors.white,
                        text: buttons[index],
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.black,
                      );
                    }
                  }),
            ),
          ],
        ));
  }

  bool isOperator(String text) {
    if (text == '%' ||
        text == '/' ||
        text == 'x' ||
        text == '-' ||
        text == '+' ||
        text == '=') {
      return true;
    } else {
      return false;
    }
  }

  void calculation() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');

    Parser p = Parser();
    Expression e = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = e.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}
