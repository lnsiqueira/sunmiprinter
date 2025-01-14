

import 'package:flutter/material.dart';

class  CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback  onPressed;
  final Icon icon;

  CustomButton({required this.text,  required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme
          .of(context)
          .colorScheme
          .primary,
      textColor: Theme
          .of(context)
          .colorScheme
          .onPrimary,
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          icon,
          Text(text),
        ],
      ),
    );
  }
}