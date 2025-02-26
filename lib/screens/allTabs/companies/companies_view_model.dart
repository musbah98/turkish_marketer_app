import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/post_model.dart';
import '../home/home_view_model.dart';

final companiesViewModelProvider = ChangeNotifierProvider((ref) => CompaniesViewModel());

class CompaniesViewModel with ChangeNotifier {
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
  ];

  List<Filter> mainFilter = [
    Filter(id: 0, name: "Imports", isSelected: false),
    Filter(id: 1, name: "Exports", isSelected: false),
    Filter(id: 2, name: "Tendders", isSelected: false),
    Filter(id: 3, name: "Sponsored", isSelected: false),
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
      ];

      isLoading = false;
      notifyListeners();
    });
  }
}
