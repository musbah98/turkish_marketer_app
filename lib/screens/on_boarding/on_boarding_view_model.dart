import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final onBoardingViewModelProvider = ChangeNotifierProvider.autoDispose((ref) {
  return OnBoardingViewModel();
});

class OnBoardingViewModel extends ChangeNotifier {
  OnBoardingViewModel() : super() {
    init();
  }

  late BuildContext? context;

  late PageController pageViewController;
  late PageController imagePageViewController;

  int currentPageIndex = 0;

  late List<Map<String, dynamic>> data = [];

  void init({BuildContext? context}) {
    this.context = context;

    pageViewController = PageController();
    imagePageViewController = PageController();

    data = [
      {
        'color': '#ffe24e',
        'title': 'Hmmm, Healthy food',
        'image': 'https://cdn1.smartprix.com/rx-ilzaIAyLd-w1200-h1200/lzaIAyLd.jpg',
        'description':
            "A variety of foods made by the best chef. Ingredients are easy to find, all delicious flavors can only be found at cookbunda",
        'skip': true
      },
      {
        'color': '#a3e4f1',
        'title': 'Fresh Drinks, Stay Fresh',
        'image': 'https://petapixel.com/assets/uploads/2024/01/The-Star-of-System-Sol-Rectangle-640x800.jpg',
        'description':
            'Not all food, we provide clear healthy drink options for you. Fresh taste always accompanies you',
        'skip': true
      },
      {
        'color': '#31b77a',
        'title': 'Let\'s Cooking',
        'image':
            'https://img.freepik.com/free-photo/closeup-scarlet-macaw-from-side-view-scarlet-macaw-closeup-head_488145-3540.jpg?semt=ais_hybrid&w=740&q=80',
        'description': 'Are you ready to make a dish for your friends or family? create an account and cooks',
        'skip': false
      },
    ];
  }

  changeCurrentPageIndex(int indx) {
    if (indx <= data.length - 1) {
      pageViewController.animateToPage(indx, duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
      imagePageViewController.animateToPage(indx, duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
      currentPageIndex = indx;
    } else {
      pageViewController.jumpToPage(0);
      imagePageViewController.jumpToPage(0);
      currentPageIndex = 0;
    }
    notifyListeners();
  }
}
