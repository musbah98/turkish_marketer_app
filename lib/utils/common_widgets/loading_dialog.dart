import 'package:flutter/material.dart';
import 'package:turkish_marketer/extentions.dart';
import 'app_circular_progress.dart';
import '../app_widgets/custom_app_text.dart';

class LoadingAlertDialog {
  static OverlayEntry? _overlayEntry;

  static void show(
    BuildContext context, {
    String? title,
    Widget? customLoader,
  }) {
    final overlayState = Overlay.of(context);
    if (_overlayEntry != null) return;
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: const Color.fromARGB(70, 44, 44, 44),
              ),
            ),
            Center(
              child: AlertDialog(
                backgroundColor: Colors.white,
                title: customTextApp(
                  text: 'loading'.localized(),
                  fontWeight: FontWeight.bold,
                  size: 20,
                ),
                content: Row(
                  children: <Widget>[
                    customLoader ??
                        appCircularProgress(
                          width: 40,
                          height: 40,
                          strokeWidth: 4,
                        ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: customTextApp(
                        text: title ?? 'please_wait...'.localized(),
                        maxLine: 2,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );

    overlayState.insert(_overlayEntry!);
  }

  static void dismiss() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
