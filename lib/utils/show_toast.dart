import 'package:flutter/material.dart';
import 'package:socket_flutter/utils/constants.dart';

void showToast(BuildContext context, String message, String type, {int duration = 1500}) {
  final scaffold = ScaffoldMessenger.of(context);
  // decide the color of the toast
  if (type == "success") {
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: kPrimaryColor,
        content: Text(
          message,
          style: const TextStyle(color: Colors.black),
        ),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'OK',
          onPressed: scaffold.hideCurrentSnackBar,
          textColor: Colors.black,
        ),
        duration: Duration(milliseconds: duration),
      ),
    );
  } else if (type == "error") {
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: kErrorColor,
        content: Text(
          message,
          style: const TextStyle(color: Colors.black),
        ),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'OK',
          onPressed: scaffold.hideCurrentSnackBar,
          textColor: Colors.black,
        ),
        duration: Duration(milliseconds: duration),
      ),
    );
  } else if (type == "info") {
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: kSecondaryColor,
        content: Text(
          message,
          style: const TextStyle(color: Colors.black),
        ),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'OK',
          onPressed: scaffold.hideCurrentSnackBar,
          textColor: Colors.black,
        ),
        duration: Duration(milliseconds: duration),
      ),
    );
  } else {
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: kPrimaryColor,
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: const TextStyle(color: Colors.black),
        ),
        action: SnackBarAction(
          label: 'OK',
          onPressed: scaffold.hideCurrentSnackBar,
          textColor: Colors.black,
        ),
        duration: Duration(milliseconds: duration),
      ),
    );
  }
}
