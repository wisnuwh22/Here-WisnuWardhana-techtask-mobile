import 'package:flutter/material.dart';

class WarningDialog {
  static WarningDialog dialog;

  static WarningDialog getInstance() {
    if(dialog == null) {
      dialog = new WarningDialog();
    }
    return dialog;
  }

  // show warning dialog if there's any error
  showWarningDialog(BuildContext context, String message) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}