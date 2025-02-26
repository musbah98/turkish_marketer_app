import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/screens/allTabs/companies/companies_screen.dart';
import 'package:turkish_marketer/screens/allTabs/categories/categories_screen.dart';
import 'package:turkish_marketer/screens/allTabs/home/home_screen.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/images.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/colors.dart';
import 'tab_bar_view_model.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  List<BottomNavigationBarItem> items = [];

  @override
  void initState() {
    super.initState();
    items = [
      BottomNavigationBarItem(
        icon: SizedBox(height: 30, child: Image.asset(homeIcon)),
        activeIcon: SizedBox(height: 30, child: Image.asset(homeIcon, color: redColor1)),
        label: 'home'.localized(),
      ),
      BottomNavigationBarItem(
        icon: SizedBox(height: 30, child: Image.asset(importsIcon)),
        activeIcon: SizedBox(height: 30, child: Image.asset(importsIcon, color: redColor1)),
        label: 'imports'.localized(),
      ),
      BottomNavigationBarItem(
        icon: SizedBox(height: 30, child: Image.asset(exportsIcon)),
        activeIcon: SizedBox(height: 30, child: Image.asset(exportsIcon, color: redColor1)),
        label: 'exports'.localized(),
      ),
      BottomNavigationBarItem(
        icon: SizedBox(height: 30, child: Image.asset(companiesIcon)),
        activeIcon: SizedBox(height: 30, child: Image.asset(companiesIcon, color: redColor1)),
        label: 'companies'.localized(),
      ),
      BottomNavigationBarItem(
        icon: SizedBox(height: 30, child: Image.asset(categoriesIcon)),
        activeIcon: SizedBox(height: 30, child: Image.asset(categoriesIcon, color: redColor1)),
        label: 'categories'.localized(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, _) {
          final tabBarViewModel = ref.watch(tabBarViewModelProvider);
          final index = ref.watch(tabBarViewModel.selectedIndex);

          return Stack(
            children: [
              Visibility(
                visible: index == 0,
                child: const HomeScreen(), // Home Screen
              ),
              Visibility(
                visible: index == 1,
                child: const HomeScreen(), // Replace with Imports Screen
              ),
              Visibility(
                visible: index == 2,
                child: const HomeScreen(), // Replace with Exports Screen
              ),
              Visibility(
                visible: index == 3,
                child: const CompaniesScreen(),
              ),
              Visibility(
                visible: index == 4,
                child: const CategoriesScreen(),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Consumer(
        builder: (context, ref, _) {
          final tabBarViewModel = ref.watch(tabBarViewModelProvider);
          final index = ref.watch(tabBarViewModel.selectedIndex);

          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.33,
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            child: BottomNavigationBar(
              enableFeedback: true,
              showUnselectedLabels: true,
              showSelectedLabels: true,
              selectedItemColor: redColor1,
              backgroundColor: Colors.white,
              selectedFontSize: 10,
              unselectedFontSize: 10,
              type: BottomNavigationBarType.fixed,
              unselectedLabelStyle: const TextStyle(
                color: grayColor,
                fontWeight: FontWeight.w500,
              ),
              selectedLabelStyle: const TextStyle(
                color: redColor1,
                fontWeight: FontWeight.w500,
              ),
              items: items,
              currentIndex: index,
              onTap: (index) {
                ref.read(tabBarViewModel.selectedIndex.notifier).state = index;
              },
            ),
          );
        },
      ),
    );
  }
}
