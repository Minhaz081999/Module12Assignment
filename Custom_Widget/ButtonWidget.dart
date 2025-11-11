import 'package:flutter/material.dart';


class ButtonWidget extends StatelessWidget {
  // variable nibo
  String text;
  Color ? buttonColor;
  bool isDark;
  //
  final VoidCallback onClick;

   ButtonWidget({
    super.key,
     required this.text,
     this.buttonColor,
    required this.isDark,
     required this.onClick

  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor ?? (isDark ? Colors.grey : Colors.blue),
                padding: EdgeInsets.all(25),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                )
            ),
            onPressed: onClick,
            child: Text(text,
              style: TextStyle(
                fontSize: 20,
                color: isDark ? Colors.white : Colors.black,

              ),
            )
        ),
      ),
    );
  }
}