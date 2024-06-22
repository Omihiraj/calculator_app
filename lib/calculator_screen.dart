import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String pressedValue = "0";
  String calculationText = "";
  num answer = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(
              height: 180,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                calculationText,
                style: const TextStyle(
                    fontSize: 24,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                pressedValue,
                style: const TextStyle(
                    fontSize: 48,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    calculatorButton(buttonName: "mc"),
                    calculatorButton(buttonName: "C"),
                    calculatorButton(buttonName: "7"),
                    calculatorButton(buttonName: "4"),
                    calculatorButton(buttonName: "1"),
                    calculatorButton(buttonName: "%"),
                  ],
                ),
                Column(
                  children: [
                    calculatorButton(buttonName: "m+"),
                    calculatorButton(buttonName: "x"),
                    calculatorButton(buttonName: "8"),
                    calculatorButton(buttonName: "5"),
                    calculatorButton(buttonName: "2"),
                    calculatorButton(buttonName: "0"),
                  ],
                ),
                Column(
                  children: [
                    calculatorButton(buttonName: "m-"),
                    calculatorButton(buttonName: "/", isGreenButton: true),
                    calculatorButton(buttonName: "9"),
                    calculatorButton(buttonName: "6"),
                    calculatorButton(buttonName: "3"),
                    calculatorButton(buttonName: "."),
                  ],
                ),
                Column(
                  children: [
                    calculatorButton(buttonName: "mr"),
                    calculatorButton(buttonName: "*", isGreenButton: true),
                    calculatorButton(buttonName: "-", isGreenButton: true),
                    calculatorButton(buttonName: "+", isGreenButton: true),
                    calculatorButton(
                        buttonName: "=",
                        isGreenButton: true,
                        isEqualButton: true),
                    //calculatorButton(buttonName: "%"),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget calculatorButton(
      {required String buttonName,
      bool isGreenButton = false,
      bool isEqualButton = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          print(buttonName);
          setState(() {
            if (buttonName == "C") {
              pressedValue = "0";
              calculationText = "";
            } else if (buttonName == "=") {
              String firstPart =
                  calculationText.substring(0, calculationText.length - 1);
              String middlePart =
                  calculationText.substring(calculationText.length - 1);
              String lastPart = pressedValue;
              if (middlePart == "+") {
                answer = int.parse(firstPart) + int.parse(lastPart);
              } else if (middlePart == "-") {
                answer = int.parse(firstPart) - int.parse(lastPart);
              } else if (middlePart == "*") {
                answer = int.parse(firstPart) * int.parse(lastPart);
              } else if (middlePart == "/") {
                answer = int.parse(firstPart) / int.parse(lastPart);
              }

              setState(() {
                pressedValue = answer.toString();
                calculationText = "";
              });
            } else if (calculationText.endsWith('+') ||
                calculationText.endsWith('-') ||
                calculationText.endsWith('/') ||
                calculationText.endsWith('*')) {
              pressedValue = buttonName;
            } else if (buttonName != "+" &&
                buttonName != "-" &&
                buttonName != "*" &&
                buttonName != "/" &&
                buttonName != "=" &&
                buttonName != "mc" &&
                buttonName != "m+" &&
                buttonName != "m-" &&
                buttonName != "mr" &&
                buttonName != "%" &&
                buttonName != "x") {
              if (pressedValue[0] == "0") {
                pressedValue = buttonName;
              } else {
                pressedValue += buttonName;
              }
            }
            if (buttonName == "+" ||
                buttonName == "-" ||
                buttonName == "*" ||
                buttonName == "/") {
              calculationText += pressedValue + buttonName;
            }
          });
          // print(pressedValue);
        },
        child: Container(
          width: 60,
          height: isEqualButton ? 136 : 60,
          decoration: BoxDecoration(
            color: isGreenButton ? Colors.green : Colors.grey,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              buttonName,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
