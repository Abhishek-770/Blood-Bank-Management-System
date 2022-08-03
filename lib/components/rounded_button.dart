import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class RoundedButton extends StatelessWidget {
  RoundedButton({required this.title,required this.colour,required this.onPressed});
  final String title;
  final VoidCallback onPressed;
  final Color colour;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 150.0,
          height: 60.0,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}