
import 'package:flutter/material.dart';
import 'Custom_Widget/ButtonWidget.dart';

class SimpleCalculatorApp extends StatefulWidget {
  const SimpleCalculatorApp({super.key});

  @override
  State<SimpleCalculatorApp> createState() => _SimpleCalculatorAppState();
}

class _SimpleCalculatorAppState extends State<SimpleCalculatorApp> {
  String _input = '0';
  String _output = '0';
  String _operator = '';
  double number1ST = 0;
  double number2nd = 0;
  bool _isDarkMode = true;

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void buttonPress(String value) {
    setState(() {
      if (value == 'C') {
        _output = '0';
        _input = '0';
        _operator = '';
        number1ST = 0;
        number2nd = 0;
        return;
      } else if (value == '=') {
        number2nd = double.tryParse(_input) ?? 0;
        if (_operator.isNotEmpty && _input.isNotEmpty) {
          switch (_operator) {
            case '+':
              _output = (number1ST + number2nd).toString();
              break;
            case '-':
              _output = (number1ST - number2nd).toString();
              break;
            case '*':
              _output = (number1ST * number2nd).toString();
              break;
            case '/':
              _output = (number2nd != 0)
                  ? (number1ST / number2nd).toString()
                  : "Math Error";
              break;
          }
        }
      } else if (['+', '-', '*', '/'].contains(value)) {
        _operator = value;
        number1ST = double.tryParse(_input) ?? 0;
        _input = '';
        return;
      } else {
        if (_input == '0') {
          _input = value;
        } else {
          _input += value;
        }
        _output = _input;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = _isDarkMode;
    final backgroundColor = isDark ? Colors.black : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          "Simple Calculator App",
          style: TextStyle(color: textColor),
        ),
        backgroundColor: isDark ? Colors.grey[900] : Colors.blue[100],
        actions: [
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: isDark ? Colors.yellow : Colors.black,
            ),
            onPressed: toggleTheme,
          )
        ],
      ),
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return buildPortraitLayout(textColor);
            } else {
              return buildLandscapeLayout(textColor);
            }
          },
        ),
      ),
    );
  }

  // Portrait mode layout
  Widget buildPortraitLayout(Color textColor) {
    return Column(
      children: [
        Expanded( child: buildDisplay(textColor)),
        Expanded(flex: 2, child: buildButtonGrid()),
      ],
    );
  }

  // Landscape mode layout
  Widget buildLandscapeLayout(Color textColor) {
    return Row(
      children: [
        // Display (smaller height)
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: buildDisplay(textColor),
          ),
        ),
        // Button grid (scrollable to prevent overflow)
        Expanded(
          flex: 6,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: buildButtonGrid(),
          ),
        ),
      ],
    );
  }

  // Display section
  Widget buildDisplay(Color textColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "$number1ST $_operator $_input",
            style: TextStyle(fontSize: 25, color: textColor),
          ),
          const SizedBox(height: 10),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              _output,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable button grid
  Widget buildButtonGrid() {
    return Column(
      children: [
        Row(
          children: [
            ButtonWidget(text: "7", onClick: () => buttonPress('7'), isDark: _isDarkMode),
            ButtonWidget(text: "8", onClick: () => buttonPress('8'), isDark: _isDarkMode),
            ButtonWidget(text: "9", onClick: () => buttonPress('9'), isDark: _isDarkMode),
            ButtonWidget(
                text: "/", buttonColor: Colors.orange, onClick: () => buttonPress('/'), isDark: _isDarkMode),
          ],
        ),
        Row(
          children: [
            ButtonWidget(text: "4", onClick: () => buttonPress('4'), isDark: _isDarkMode),
            ButtonWidget(text: "5", onClick: () => buttonPress('5'), isDark: _isDarkMode),
            ButtonWidget(text: "6", onClick: () => buttonPress('6'), isDark: _isDarkMode),
            ButtonWidget(
                text: "*", buttonColor: Colors.orange, onClick: () => buttonPress('*'), isDark: _isDarkMode),
          ],
        ),
        Row(
          children: [
            ButtonWidget(text: "1", onClick: () => buttonPress('1'), isDark: _isDarkMode),
            ButtonWidget(text: "2", onClick: () => buttonPress('2'), isDark: _isDarkMode),
            ButtonWidget(text: "3", onClick: () => buttonPress('3'), isDark: _isDarkMode),
            ButtonWidget(
                text: "-", buttonColor: Colors.orange, onClick: () => buttonPress('-'), isDark: _isDarkMode),
          ],
        ),
        Row(
          children: [
            ButtonWidget(text: "0", onClick: () => buttonPress('0'), isDark: _isDarkMode),
            ButtonWidget(text: ".", onClick: () => buttonPress('.'), isDark: _isDarkMode),
            ButtonWidget(text: "=", onClick: () => buttonPress('='), isDark: _isDarkMode),
            ButtonWidget(text: "AC", onClick: () => buttonPress('C'), isDark: _isDarkMode),
            ButtonWidget(
                text: "+", buttonColor: Colors.orange, onClick: () => buttonPress('+'), isDark: _isDarkMode),
          ],
        ),
      ],
    );
  }
}




