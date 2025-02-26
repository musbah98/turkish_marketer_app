import 'package:flutter/material.dart';
import '../../di.dart';
import '../app_widgets/custom_app_text.dart';
import '../routing/navigation_service.dart';

showSnackBar(
  String text,
) {
  ScaffoldMessenger.of(sl<NavigationService>().getContext()).showSnackBar(
    SnackBar(
      backgroundColor: const Color(0xFF718096).withOpacity(0.9),
      behavior: SnackBarBehavior.floating,
      content: customTextApp(
        text: text,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}
