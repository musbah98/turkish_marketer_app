import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/post_model.dart';

final categoriesViewModelProvider = ChangeNotifierProvider((ref) => CategoriesViewModel());

class CategoriesViewModel with ChangeNotifier {
  late BuildContext context;

  bool isLoading = false;
  List<PostModel> items = [
    PostModel(),
    PostModel(),
    PostModel(),
    PostModel(),
    PostModel(),
    PostModel(),
    PostModel(),
    PostModel(),
    PostModel(),
    PostModel(),
    PostModel(),
  ];

  getData() {
    isLoading = true;
    notifyListeners();

    Timer(const Duration(seconds: 3), () {
      items = [
        PostModel(),
        PostModel(),
        PostModel(),
        PostModel(),
        PostModel(),
        PostModel(),
        PostModel(),
        PostModel(),
      ];

      isLoading = false;
      notifyListeners();
    });
  }
}
