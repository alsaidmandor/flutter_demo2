import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool> showAlertDialog(
  BuildContext context, {
  @required String title,
  @required String content,
      String cancelActionText ,
  @required String defaultActionText,
}) {
  if (!Platform.isIOS) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            if(cancelActionText != null)
                FlatButton(
                  child: Text(cancelActionText),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(false); // Dismiss alert dialog
                  },
                ),

            FlatButton(
              child: Text(defaultActionText),
              onPressed: () {
                Navigator.of(dialogContext).pop(true); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  return showCupertinoDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          if(cancelActionText != null)
            FlatButton(
              child: Text(cancelActionText),
              onPressed: () {
                Navigator.of(dialogContext).pop(false); // Dismiss alert dialog
              },
            ),
          FlatButton(
            child: Text(defaultActionText),
            onPressed: () {
              Navigator.of(dialogContext).pop(true); // Dismiss alert dialog
            },
          ),
        ],
      );
    },
  );
}
