

import 'package:flutter/material.dart';

class  CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback  onPressed;

  CustomButton({required this.text,  required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(text),
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
    );
  }
}