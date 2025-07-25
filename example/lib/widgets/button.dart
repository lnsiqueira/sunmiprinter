

import 'package:flutter/material.dart';

class  Button extends StatelessWidget {
  final VoidCallback  onPressed;
  final Icon icon;

  Button({required this.onPressed, required this.icon});

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
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      shape: CircleBorder(
        side: BorderSide(
          color: Theme
              .of(context)
              .colorScheme
              .primary,
          width: 5.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          icon,
        ],
      ),
    );
  }
}