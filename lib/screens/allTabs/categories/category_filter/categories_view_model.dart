import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../home/home_view_model.dart';

final categoryFilterViewModelProvider = ChangeNotifierProvider((ref) => CategoryFilterViewModel());

class CategoryFilterViewModel with ChangeNotifier {
  late BuildContext context;

  bool isLoading = false;

  List<Filter> mainFilter = [
    Filter(id: 0, name: "Modest Clothing", isSelected: false),
    Filter(id: 1, name: "Jeans - Denim Wear", isSelected: false),
    Filter(id: 2, name: "Pyjamas Sleepwear", isSelected: false),
    Filter(id: 3, name: "Headscarf", isSelected: false),
    Filter(id: 4, name: "Uniforms - Aprons - Work Wears", isSelected: false),
    Filter(id: 5, name: "General", isSelected: false),
    Filter(id: 6, name: "Pyjamas Sleepwear", isSelected: false),
    Filter(id: 7, name: "Headscarf", isSelected: false),
    Filter(id: 8, name: "Jeans", isSelected: false),
    Filter(id: 9, name: "Uniforms - Aprons - Work Wears", isSelected: false),
    Filter(id: 10, name: "Pyjamas Sleepwear", isSelected: false),
    Filter(id: 11, name: "Jeans", isSelected: false),
    Filter(id: 12, name: "Modest Clothing", isSelected: false),
    Filter(id: 13, name: "Pyjamas Sleepwear", isSelected: false),
    Filter(id: 14, name: "Jeans", isSelected: false),
    Filter(id: 15, name: "Modest Clothing", isSelected: false),
  ];

  getData() {
    isLoading = true;
    notifyListeners();

    Timer(const Duration(seconds: 3), () {
      isLoading = false;
      notifyListeners();
    });
  }

  didSelectFilter(int indx) {
    mainFilter[indx].isSelected = !(mainFilter[indx].isSelected ?? false);
    notifyListeners();
  }
}
