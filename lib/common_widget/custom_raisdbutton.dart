import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final Widget child;

  final Color color;

  final double borderRadius;

  final VoidCallback onPressed;

  final double height;

  CustomRaisedButton(
      {this.child,
      this.color,
      this.borderRadius: 2.0,  // default value
      this.height: 50.0,
      this.onPressed})
      : assert(borderRadius != null);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      // ignore: deprecated_member_use
      child: RaisedButton(
        child: child,
        onPressed: onPressed,
        color: color,
        disabledColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
