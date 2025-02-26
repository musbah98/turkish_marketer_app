import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postDetailsViewModelProvider = ChangeNotifierProvider((ref) => PostDetailsViewModel());

class PostDetailsViewModel with ChangeNotifier {
  late BuildContext context;

  bool isLoading = false;

  List<String> attchments = [
    "File Name.pdf",
    "File Name.pdf",
    "File Name.pdf",
  ];

  getData() {
    isLoading = true;
    notifyListeners();

    Timer(const Duration(seconds: 3), () {
      isLoading = false;
      notifyListeners();
    });
  }
}
