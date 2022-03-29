import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  void initState() {
    super.initState();
  }

  String topBarText = "";
  List<String> calcChars = ["7", "8", "9", "+", "4", "5", "6", "-", "1", "2", "3", "*", "0", "=", "clear", "/"];
  String computeEquation(String input) {
    //expects String input with operators in between
    //For example "123 + 456"
    var splitEquation = input.split(" ");
    //['123', '+', '456]
    while (splitEquation.length >= 3) {
      var val1 = int.parse(splitEquation[0]);
      var op = splitEquation[1];
      var val2 = int.parse(splitEquation[2]);
      var ret = 0;
      if (op == "+") {
        ret = val1 + val2;
      } else if (op == "-") {
        ret = val1 - val2;
      } else if (op == "*") {
        ret = val1 * val2;
      } else if (op == "/") {
        ret = val1 ~/ val2;
      } else {
        return "ERROR";
      }
      splitEquation.removeAt(0);
      splitEquation.removeAt(1);
      splitEquation[0] = ret.toString();
    }
    if (splitEquation.length == 1) {
      return splitEquation[0];
    }
    return "ERROR";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      )),
                  width: MediaQuery.of(context).size.width * .9,
                  height: 100,
                  child: Center(child: Text(topBarText))),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                child: GridView.count(
                  padding: const EdgeInsets.all(18),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  crossAxisCount: 4,
                  children: List.generate(16, (index) {
                    return InkWell(
                      onTap: () {
                        if (index == 14) {
                          setState(() {
                            topBarText = "";
                          });
                        } else if (index == 13) {
                          setState(() {
                            topBarText = computeEquation(topBarText);
                          });
                        } else if (index % 4 == 3) {
                          setState(() {
                            topBarText += " " + calcChars[index] + " ";
                          });
                        } else {
                          setState(() {
                            topBarText += calcChars[index];
                          });
                        }
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.green,
                        ),
                        child: Center(
                          child: Text(
                            calcChars[index],
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
