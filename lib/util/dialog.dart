import 'package:flutter/material.dart';

class AppDialog {
  static final AppDialog _instance = AppDialog._();
  BuildContext _context;

  AppDialog._();

  factory AppDialog(BuildContext context) {
    _instance._context = context;
    return _instance;
  }

  Future showConfirmDialog(String message, {void onConfirm()}) async =>
      showDialog(
        context: _context,
        builder: (BuildContext context) => WillPopScope(
          onWillPop: () async => _onWillPop(onConfirm),
          child: AlertDialog(
            title: Text("안내"),
            content: Text(message),
            actions: <Widget>[
              MaterialButton(
                child: Text("확인"),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onConfirm != null) onConfirm();
                },
              ),
            ],
          ),
        ),
      );

  Future<bool> _onWillPop(void onDismiss()) async {
    if (onDismiss != null) onDismiss();
    return true;
  }
}
