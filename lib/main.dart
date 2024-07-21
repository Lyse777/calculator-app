import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lyse💛CALCULATOR💛',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = "0";
  String input = "";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "CLEAR") {
        output = "0";
        input = "";
        num1 = 0.0;
        num2 = 0.0;
        operand = "";
      } else if (buttonText == "DEL") {
        if (output.isNotEmpty) {
          output = output.substring(0, output.length - 1);
          if (output.isEmpty) {
            output = "0";
          }
          input = input.substring(0, input.length - 1);
        }
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "/" || buttonText == "X") {
        if (operand.isEmpty) {
          num1 = double.parse(output);
          operand = buttonText;
          input = "$output $operand";
          output = "0";
        } else {
          operand = buttonText;
          input = input.substring(0, input.length - 1) + operand;
        }
      } else if (buttonText == ".") {
        if (output.contains(".")) {
          return;
        } else {
          output += buttonText;
        }
      } else if (buttonText == "=") {
        num2 = double.parse(output);

        if (operand == "+") {
          output = (num1 + num2).toString();
        } else if (operand == "-") {
          output = (num1 - num2).toString();
        } else if (operand == "X") {
          output = (num1 * num2).toString();
        } else if (operand == "/") {
          output = (num1 / num2).toString();
        }

        input = "$num1 $operand $num2 =";
        operand = "";
      } else {
        if (output == "0") {
          output = buttonText;
        } else {
          output += buttonText;
        }
      }

      if (buttonText != "=" && buttonText != "CLEAR" && !["+", "-", "/", "X"].contains(buttonText)) {
        input += buttonText;
      }
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.all(24.0),
          side: BorderSide(width: 2, color: Colors.purple),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lyse💛CALCULATOR💛')),
      body: Container(
        color: Colors.pink[50],
        child: Column(children: <Widget>[
          Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    output,
                    style: TextStyle(
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ],
              )),
          Expanded(
            child: Divider(),
          ),
          Column(children: [
            Row(children: [
              buildButton("7"),
              buildButton("8"),
              buildButton("9"),
              buildButton("/")
            ]),
            Row(children: [
              buildButton("4"),
              buildButton("5"),
              buildButton("6"),
              buildButton("X")
            ]),
            Row(children: [
              buildButton("1"),
              buildButton("2"),
              buildButton("3"),
              buildButton("-")
            ]),
            Row(children: [
              buildButton("."),
              buildButton("0"),
              buildButton("DEL"),
              buildButton("+")
            ]),
            Row(children: [
              buildButton("CLEAR"),
              buildButton("="),
            ])
          ])
        ]),
      ),
    );
  }
}
