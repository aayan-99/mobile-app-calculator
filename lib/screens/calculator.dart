import 'package:calculator_app/themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var input = '';
  var output = '';
  var operation = '';
  var hideInput = false;
  var outputSize = 25.0;

  buttonOnClick(value) {
    if (value == 'AC') {
      input = '';
      output = '';
    } else if (value == '⌫') {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == '=') {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll('x', '*');
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith('.0')) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        outputSize = 46.0;
      }
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 25.0;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: getBody(),
    );
  }

  getBody() {
    return Column(
      children: [
        getCalcScreen(),
        getAllButtons(),
      ],
    );
  }

  getAllButtons() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
          child: Row(
            children: [
              getButton(
                text: 'AC',
                buttonBG: operatorColor,
                tColor: orangeColor,
              ),
              getButton(
                text: '⌫',
                buttonBG: operatorColor,
              ),
              getButton(text: '%', buttonBG: operatorColor),
              getButton(
                text: '/',
                buttonBG: operatorColor,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Row(
            children: [
              getButton(
                text: '7',
              ),
              getButton(
                text: '8',
              ),
              getButton(
                text: '9',
              ),
              getButton(
                text: 'x',
                buttonBG: operatorColor,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Row(
            children: [
              getButton(
                text: '4',
              ),
              getButton(
                text: '5',
              ),
              getButton(
                text: '6',
              ),
              getButton(
                text: '-',
                buttonBG: operatorColor,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Row(
            children: [
              getButton(
                text: '1',
              ),
              getButton(
                text: '2',
              ),
              getButton(
                text: '3',
              ),
              getButton(
                text: '+',
                buttonBG: operatorColor,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Row(
            children: [
              getButton(
                text: '0',
              ),
              getButton(
                text: '00',
              ),
              getButton(
                text: '.',
                buttonBG: operatorColor,
              ),
              getButton(
                text: '=',
                buttonBG: orangeColor,
              ),
            ],
          ),
        ),
      ],
    );
  }

  getCalcScreen() {
    return Expanded(
        child: Container(
      // color: Colors.red,
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            hideInput ? '' : input,
            style: const TextStyle(
              fontSize: 46,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            output,
            style: TextStyle(
              fontSize: outputSize,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    ));
  }

  getButton({text, tColor = Colors.white, buttonBG = buttonColor}) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: () => buttonOnClick(text),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: buttonBG,
          padding: const EdgeInsets.all(22),
        ),
        child: Text(
          '$text',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: tColor,
          ),
        ),
      ),
    ));
  }
}
