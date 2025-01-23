import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttonText;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onPressed;
  final double width;
  final double height;

  const MyButton({
    Key? key,
    required this.buttonText,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onPressed,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        fixedSize: Size(width, height),
      ),
      child: Text(buttonText),
    );
  }
}
