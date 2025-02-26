import 'package:flutter/material.dart';
import 'package:turkish_marketer/extentions.dart';

showConfirmationDialog({
  required BuildContext context,
  String title = "",
  String content = "",
  bool barrierDismissible = true,
  String textButton = "yes",
  Function()? onAccept,
  Function()? onError,
}) {
  showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return PopScope(
        canPop: true,
        child: AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(content),
            ],
          ),
          actions: <Widget>[
            if (barrierDismissible) ...[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                  if (onError != null) {
                    onError();
                  }
                },
                child: Text("no".localized()),
              ),
            ],
            TextButton(
              onPressed: onAccept,
              child: Text(textButton.localized()),
            ),
          ],
        ),
      );
    },
  );
}
