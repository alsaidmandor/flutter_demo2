import 'package:flutter/material.dart';
import 'package:flutter_demo2/common_widget/custom_raisdbutton.dart';

class FormSubmitButton extends CustomRaisedButton {
  FormSubmitButton({
   @required String txt,
      VoidCallback onPressed,
  }) : assert(txt != null),
      super(
          child: Text(
            txt,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          color: Colors.indigo,
          borderRadius: 4.0,
          onPressed: onPressed,
        );
}
