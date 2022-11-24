import 'package:flutter/material.dart';
import 'package:socket_flutter/utils/constants.dart';

void showToast(BuildContext context, String message, String type) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: scaffold.hideCurrentSnackBar,
        textColor: Theme.of(context).brightness == Brightness.dark
            ? kContentColorLightTheme
            : kContentColorDarkTheme,
      ),
    ),
  );
}
