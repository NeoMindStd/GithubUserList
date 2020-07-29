import 'package:flutter/material.dart';
import 'package:github_user_list/constant/strings.dart' as Strings;

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
            title: Text(Strings.Global.INFO),
            content: Text(message),
            actions: <Widget>[
              MaterialButton(
                child: Text(
                  Strings.Global.CONFIRM,
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onConfirm != null) onConfirm();
                },
              ),
            ],
          ),
        ),
      );

  Future showYesNoDialog(String message, {void onConfirm(), void onCancel()}) =>
      showDialog(
        context: _context,
        builder: (BuildContext context) => WillPopScope(
          onWillPop: () async => _onWillPop(onCancel),
          child: AlertDialog(
            title: Text(Strings.Global.INFO),
            content: Text(message),
            actions: <Widget>[
              MaterialButton(
                child: Text(
                  Strings.Global.YES,
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onConfirm != null) onConfirm();
                },
              ),
              MaterialButton(
                child: Text(
                  Strings.Global.NO,
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onCancel != null) onCancel();
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
