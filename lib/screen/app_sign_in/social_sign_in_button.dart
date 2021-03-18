import 'package:flutter/material.dart';
import 'package:flutter_demo2/common_widget/custom_raisdbutton.dart';

class SocialSignInButton extends CustomRaisedButton {
  SocialSignInButton({
    @required String assetName,
    @required String txt,
    Color color,
    Color txtColor,
    VoidCallback onPressed,
  }) :assert(assetName != null),
        assert(txt != null),
        super(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(assetName),
        Text(txt,style: TextStyle(color: txtColor, fontSize: 15.0),),
        Opacity(opacity: 0.0,child: Image.asset(assetName),),
      ],
    ),
    color: color,
    onPressed: onPressed,
  );
}
