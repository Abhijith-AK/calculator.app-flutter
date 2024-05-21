import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var equation = "";
  var result = "";
  var expression = "";

  calculation(String buttonText) {
    // used to check if the result contains a decimal
    String doesContainDecimal(dynamic result) {
      if (result.toString().contains('.')) {
        List<String> splitDecimal = result.toString().split('.');
        if (!(int.parse(splitDecimal[1]) > 0)) {
          return result = splitDecimal[0].toString();
        }
      }
      return result;
    }

    setState(() {
      if (buttonText == "AC") {
        equation = "0";
        result = "0";
      } else if (buttonText == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "+/-") {
        if (equation[0] != '-') {
          equation = '-$equation';
        } else {
          equation = equation.substring(1);
        }
      } else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll('X', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('%', '%');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          if (expression.contains('%')) {
            result = doesContainDecimal(result);
          }
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget calcButton(String btntxt, Color btncolor, Color textcolor) {
    return ElevatedButton(
      onPressed: () {
        calculation(btntxt);
      },
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(btncolor),
        shape: const MaterialStatePropertyAll(CircleBorder()),
                padding: const MaterialStatePropertyAll(EdgeInsets.all(25)),

      ),
      child: Text(
        btntxt,
        textAlign: TextAlign.center,
        style: TextStyle(color: textcolor, fontSize: 25),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Calculator',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //Calculator Display
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          equation,
                          textAlign: TextAlign.left,
                          style: const TextStyle(color: Colors.grey, fontSize: 45),
                        ),
                        Text(
                          result,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 75,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //Where calculate buttons are passed
                    calcButton('AC', Colors.grey, Colors.black),
                    calcButton('⌫', Colors.grey, Colors.black),
                    calcButton('%', Colors.amber.shade700, Colors.white),
                    calcButton('/', Colors.amber.shade700, Colors.white),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //Where calculate buttons are passed
                    calcButton('7', Colors.grey.shade800, Colors.white),
                    calcButton('8', Colors.grey.shade800, Colors.white),
                    calcButton('9', Colors.grey.shade800, Colors.white),
                    calcButton('X', Colors.amber.shade700, Colors.white),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //Where calculate buttons are passed
                    calcButton('4', Colors.grey.shade800, Colors.white),
                    calcButton('5', Colors.grey.shade800, Colors.white),
                    calcButton('6', Colors.grey.shade800, Colors.white),
                    calcButton('-', Colors.amber.shade700, Colors.white),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //Where calculate buttons are passed
                    calcButton('1', Colors.grey.shade800, Colors.white),
                    calcButton('2', Colors.grey.shade800, Colors.white),
                    calcButton('3', Colors.grey.shade800, Colors.white),
                    calcButton('+', Colors.amber.shade700, Colors.white),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //Where calculate buttons are passed
                    calcButton('+/-', Colors.grey.shade800, Colors.white),
                    calcButton('0', Colors.grey.shade800, Colors.white),
                    calcButton('.', Colors.grey.shade800, Colors.white),
                    calcButton('=', Colors.amber.shade700, Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
