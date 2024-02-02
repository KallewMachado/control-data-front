import 'package:flutter/material.dart';

class CustomDialogWidet {
  static show(BuildContext context,
      {Widget Function(BuildContext context)? title,
      Widget Function(BuildContext context)? content,
      double? elevation,
      List<Widget>? actions,
      bool barrierDismissible = true,
      Color? backgroundColor}) {
    actions ??= [
      Center(
        child: ElevatedButton(
          child: const Text("Fechar"),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      ),
    ];

    showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: ((BuildContext ctx) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          shape: ContinuousRectangleBorder(
            side: const BorderSide(
              width: 2,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          scrollable: false,
          elevation: elevation,
          title: title != null
              ? Center(
                  child: title(ctx),
                )
              : Container(),
          content: content != null ? content(ctx) : Container(),
          actions: actions ?? [],
        );
      }),
    );
  }
}
