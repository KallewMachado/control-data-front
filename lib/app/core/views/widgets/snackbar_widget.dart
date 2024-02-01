import 'package:flutter/material.dart';

class SnackBarWidget {
  static successSnackBar(BuildContext context, String msgSuccess,
      {int time = 2}) {
    FocusScope.of(context).requestFocus(FocusNode());
    ScaffoldMessenger.of(context).clearSnackBars();
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: time),
        backgroundColor: Colors.greenAccent,
        content: Text(
          msgSuccess,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  static errorSnackBar(BuildContext context, String msgError, {int time = 2}) {
    FocusScope.of(context).requestFocus(FocusNode());
    ScaffoldMessenger.of(context).clearSnackBars();
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: time),
        backgroundColor: Colors.redAccent,
        content: Text(
          msgError,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  static informationSnackBar(BuildContext context, String msgError,
      {int time = 2}) {
    FocusScope.of(context).requestFocus(FocusNode());
    ScaffoldMessenger.of(context).clearSnackBars();
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: time),
        backgroundColor: Colors.blueAccent,
        content: Text(
          msgError,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
