import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/post_model.dart';

final homeViewModelProvider = ChangeNotifierProvider((ref) => HomeViewModel());

class Filter {
  int? id;
  String? name;
  bool? isSelected;

  Filter({required this.id, required this.name, this.isSelected});
}

class HomeViewModel extends ChangeNotifier {
  late BuildContext context;

  bool isLoading = false;
  List<PostModel> items = [];

  Map<String, dynamic> params = {};

  List<Filter> mainFilter = [
    Filter(id: 0, name: "Imports", isSelected: false),
    Filter(id: 1, name: "Exports", isSelected: false),
    Filter(id: 2, name: "Tendders", isSelected: false),
    Filter(id: 3, name: "Sponsored", isSelected: false),
  ];

  didSelectFilter(int indx) {
    mainFilter[indx].isSelected = !(mainFilter[indx].isSelected ?? false);
    notifyListeners();
  }

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
