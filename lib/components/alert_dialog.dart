import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogBuilder {
  static const alertDialogTitle = 'An error occurred';
  static const alertDialogButtonText = 'CLOSE';

  static Future<void> showAlertDialog(
      BuildContext context, String errorMessage) async {
    return Platform.isAndroid
        ? _showAndroidAlertDialog(context, errorMessage)
        : _showCupertinoAlertDialog(context, errorMessage);
  }

  static Future<void> _showAndroidAlertDialog(
      BuildContext context, String errorMessage) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(alertDialogTitle),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(errorMessage),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(alertDialogButtonText),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> _showCupertinoAlertDialog(
      BuildContext context, String errorMessage) {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text(alertDialogTitle),
        content: Text(errorMessage),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(alertDialogButtonText),
          ),
        ],
      ),
    );
  }
}
