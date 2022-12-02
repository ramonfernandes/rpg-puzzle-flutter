import 'dart:ffi';

import 'package:flutter/material.dart';

int inputTimes = 0;
int answer = 0;

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // Array of button
  final List<String> buttons = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
  List<String> pressedButtons = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: isCorrect() ? Colors.green : Colors.white,
        body: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(15),
                      alignment: Alignment.center,
                      child: Text(
                        '$answer',
                        style: TextStyle(
                            fontSize: 115,
                            color: Colors.black,
                            backgroundColor: isCorrect() ? Colors.green : Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ]),
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          int pressed = index + 1;
                          if (!pressedButtons.contains('$pressed')) {
                            inputTimes++;
                            answer += pressed;
                            pressedButtons.add('$pressed');
                            if (inputTimes >= 4 && !isCorrect()) {
                              answer = 0;
                              inputTimes = 0;
                              pressedButtons = [];
                            }
                          }
                        });
                      },
                      buttonText: buttons[index],
                      color: pressedButtons.contains('${index+1}') ? Colors.red[50] : Colors.blue[50],
                      textColor: Colors.black,
                    );
                  }),
            ),
          ],
        ));
  }
}

bool isCorrect() {
  return answer == 23;
}

class MyButton extends StatelessWidget {
  // declaring variables
  final color;
  final textColor;
  final String buttonText;
  final buttontapped;

  //Constructor
  MyButton(
      {this.color,
      this.textColor,
      required this.buttonText,
      this.buttontapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttontapped,
      child: Padding(
        padding: const EdgeInsets.all(0.2),
        child: ClipRRect(
          // borderRadius: BorderRadius.circular(25),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
