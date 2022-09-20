import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ConfirmationDialog {

  static const cancelText = 'CANCEL';
  static const approvalText = 'CONFIRM';

  static Future<bool> showConfirmationDialog(
      BuildContext context, String dialogTitle, String dialogMessage) async {
    return Platform.isAndroid
        ? _showAndroidConfirmationDialog(context, dialogTitle, dialogMessage)
        : _showCupertinoConfirmationDialog(context, dialogTitle, dialogMessage);
  }

  static Future<bool> _showAndroidConfirmationDialog(
      BuildContext context, String dialogTitle, String dialogMessage) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(dialogTitle),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(dialogMessage),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(approvalText),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            TextButton(
              child: const Text(cancelText),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }

  static Future<bool> _showCupertinoConfirmationDialog(
      BuildContext context, String dialogTitle, String dialogMessage) {
    return showCupertinoModalPopup<bool>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(dialogTitle),
        content: Text(dialogMessage),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text(approvalText),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text(cancelText),
          ),
        ],
      ),
    );
  }
}
