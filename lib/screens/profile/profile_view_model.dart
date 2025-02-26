import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/utils/routing/navigation_service.dart';
import 'package:turkish_marketer/utils/routing/routes.dart';

import '../../di.dart';
import '../../utils/change_langage_dialog/change_language_view.dart';
import '../../utils/decoration_and_assets/images.dart';

final profileViewModelProvider = ChangeNotifierProvider((ref) => ProfileViewModel());

class ProfileSection {
  final String title;
  final List<ProfileItem> items;

  ProfileSection({required this.title, required this.items});
}

class ProfileItem {
  final String? icon;
  final String title;
  final VoidCallback? onPressed;

  ProfileItem({
    this.icon,
    required this.title,
    this.onPressed,
  });
}

class ProfileViewModel with ChangeNotifier {
  // Create a provider for the profile items
  late BuildContext context;

  List<ProfileSection> profileItems = [];

  showDataList() {
    profileItems = [
      ProfileSection(
        title: "profile_setting".localized(),
        items: [
          ProfileItem(
            icon: editIcon,
            title: "edit_profile".localized(),
            onPressed: () {
              sl<NavigationService>().navigateTo(editProfileScreen);
            },
          ),
          ProfileItem(
            icon: addNewIcon,
            title: "add_company".localized(),
            onPressed: () {
              sl<NavigationService>().navigateTo(addCompanyScreen);
            },
          ),
          ProfileItem(
            icon: passcodeIcon,
            title: "change_password".localized(),
            onPressed: () {
              sl<NavigationService>().navigateTo(changePaswsordScreen);
            },
          ),
          ProfileItem(
            icon: languageIcon,
            title: "change_language".localized(),
            onPressed: () {
              showDialog(
                context: sl<NavigationService>().getContext(),
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    content: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: const ChangeLanguageView(),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      ProfileSection(
        title: "Turkis Marketer".localized(),
        items: [
          ProfileItem(
            icon: contactusIcon,
            title: "contact_us".localized(),
            onPressed: () {},
          ),
          ProfileItem(
            icon: ourPartnersIcon,
            title: "our_partners".localized(),
            onPressed: () {},
          ),
          ProfileItem(
            icon: termsIcon,
            title: "terms_and_conditions".localized(),
            onPressed: () {},
          ),
          ProfileItem(
            icon: indexIcon,
            title: "index_of_products".localized(),
            onPressed: () {
              sl<NavigationService>().navigateTo(indexOfProductsScreen);
            },
          ),
        ],
      ),
      ProfileSection(
        title: "others".localized(),
        items: [
          ProfileItem(
            icon: plansIcon,
            title: "membership_plans".localized(),
            onPressed: () {},
          ),
          ProfileItem(
            icon: agentsIcon,
            title: "agents".localized(),
            onPressed: () {
              sl<NavigationService>().navigateTo(agentsScreen);
            },
          ),
        ],
      ),
    ];
    notifyListeners();
  }
}
