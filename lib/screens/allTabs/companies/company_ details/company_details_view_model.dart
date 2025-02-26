import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final companyDetailsViewModelProvider = ChangeNotifierProvider((ref) => CompanyDetailsViewModel());

class CompanyDetailsViewModel with ChangeNotifier {
  late BuildContext context;

  bool isLoading = false;

  List<String> tags = [
    "spices",
    "jam",
    "pulses",
    "chocolate",
    "confectionery products confectionery products confectionery products",
    "confectionary",
    "chocolate bar",
    "cereal",
    "seasoning",
    "turkish delight",
    "food",
    "food products",
    "wheat food",
    "food service",
    "canned foods",
    "organic food",
    "dried foods",
    "frozen foods",
    "food supplements",
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
