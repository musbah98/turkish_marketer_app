import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tabBarViewModelProvider = ChangeNotifierProvider.autoDispose((ref) => TabBarViewModel());

class TabBarViewModel with ChangeNotifier {
  //var selectedIndex = 0;
  final selectedIndex = StateProvider<int>((ref) => 0);
  final dailyBadgeCount = StateProvider<int>((ref) => 0);
  final allProcBadgeCount = StateProvider<int>((ref) => 0);

  // changeSelectedIndex(vlaue) {
  //   selectedIndex = vlaue;
  //   notifyListeners();
  // }
}
