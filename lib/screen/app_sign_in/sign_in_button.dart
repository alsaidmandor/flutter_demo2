import 'package:flutter/material.dart';
import 'package:flutter_demo2/common_widget/custom_raisdbutton.dart';

class SignInButton extends CustomRaisedButton {
  SignInButton({
    String txt,
    Color color,
    Color txtColor,
    VoidCallback onPressed,
  }) : assert(txt != null),
      super(
          child: Text(
            txt,
            style: TextStyle(
              color: txtColor,
              fontSize: 15.0,
            ),
          ),
          color: color,
          onPressed: onPressed,
        );
}
