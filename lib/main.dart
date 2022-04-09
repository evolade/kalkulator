import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String display = "";
  List<int> firstDigits = [];
  List<int> secondDigits = [];
  String operation = "";
  bool operated = false;
  bool done = false;

  void clear() {
    setState(() {
      display = "";
      firstDigits.clear();
      secondDigits.clear();
      operation = "";
      operated = false;
    });
  }

  void type(int digit) {
    setState(() {
      if (done) {
        clear();
        done = false;
      }

      if (!operated) {
        firstDigits.add(digit);
      } else {
        secondDigits.add(digit);
      }

      display += digit.toString();
    });
  }

  void operate(String symbol) {
    if (!operated) {
      setState(() {
        display += symbol;
        operation = symbol;
        operated = true;
      });
    }
  }

  void equals() {
    setState(() {
      int firsts = int.parse(firstDigits.join());
      int seconds = int.parse(secondDigits.join());
      if (operation == "+") {
        display = "${firsts + seconds}";
      }

      if (operation == "-") {
        display = "${firsts - seconds}";
      }

      if (operation == "X") {
        display = "${firsts * seconds}";
      }

      if (operation == "/") {
        display = "${firsts / seconds}";
      }

      done = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 27, 28),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: SizedBox(
                height: 525,
                width: size.width,
                child: Column(
                  children: [
                    Text(
                      display,
                      style: const TextStyle(
                        fontSize: 50,
                        color: Colors.white70,
                      ),
                    ),
                    Row(
                      children: [
                        KalkulatorButton(text: "C", onPressed: () => clear()),
                        KalkulatorButton(
                            text: "/", onPressed: () => operate("/")),
                      ],
                    ),
                    Row(
                      children: [
                        KalkulatorButton(text: "7", onPressed: () => type(7)),
                        KalkulatorButton(text: "8", onPressed: () => type(8)),
                        KalkulatorButton(text: "9", onPressed: () => type(9)),
                        KalkulatorButton(
                            text: "X", onPressed: () => operate("X")),
                      ],
                    ),
                    Row(
                      children: [
                        KalkulatorButton(text: "4", onPressed: () => type(4)),
                        KalkulatorButton(text: "5", onPressed: () => type(5)),
                        KalkulatorButton(text: "6", onPressed: () => type(6)),
                        KalkulatorButton(
                            text: "-", onPressed: () => operate("-")),
                      ],
                    ),
                    Row(
                      children: [
                        KalkulatorButton(text: "1", onPressed: () => type(1)),
                        KalkulatorButton(text: "2", onPressed: () => type(2)),
                        KalkulatorButton(text: "3", onPressed: () => type(3)),
                        KalkulatorButton(
                            text: "+", onPressed: () => operate("+")),
                      ],
                    ),
                    Row(
                      children: [
                        KalkulatorButton(text: "0", onPressed: () => type(0)),
                        KalkulatorButton(text: "=", onPressed: () => equals()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class KalkulatorButton extends StatelessWidget {
  const KalkulatorButton({
    required this.text,
    required this.onPressed,
  });
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 80,
        margin: const EdgeInsets.all(4),
        color: Colors.black12,
        child: TextButton(
          style: TextButton.styleFrom(
              primary: const Color.fromARGB(255, 50, 50, 50)),
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white70,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
