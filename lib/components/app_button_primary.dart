import 'package:flutter/material.dart';

class AppButtonPrimary extends StatelessWidget {
  final String text;
  final Color color;
  final Function onTapFn;

  AppButtonPrimary({
    @required this.text,
    @required this.color,
    @required this.onTapFn,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(8.0),
        child: MaterialButton(
          onPressed: onTapFn,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
          ),
        ),
      ),
    );
  }
}