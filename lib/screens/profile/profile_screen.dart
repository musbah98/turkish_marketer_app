import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/utils/app_widgets/app_card_widgets/profile_card.dart';
import 'package:turkish_marketer/utils/app_widgets/buttons_widgets/custom_app_button.dart';

import '../../utils/app_widgets/app_top_header_image.dart';
import '../../utils/app_widgets/buttons_widgets/custom_app_back_button.dart';
import '../../utils/app_widgets/custom_app_bar.dart';
import '../../utils/change_langage_dialog/change_language_state.dart';
import '../../utils/decoration_and_assets/colors.dart';
import '../../utils/decoration_and_assets/images.dart';
import 'profile_view_model.dart';
//import 'settings_view_model.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  var languageState = ChangeLanguageState();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = ref.read(profileViewModelProvider);
      viewModel.showDataList();
    });
    languageState.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final viewModel = ref.watch(profileViewModelProvider);

          return SingleChildScrollView(
            child: Stack(
              children: [
                appTopHeaderImage(image: backgroundGrid),
                Column(
                  children: [
                    customAppBar(
                      title: "my_profile".localized(),
                      actions: [const SizedBox(width: 56)],
                      leading: customAppBackbutton(),
                    ),
                    ...viewModel.profileItems.map((section) => buildSection(section)),
                    const SizedBox(height: 20),
                    _buildDeleteAccount(),
                    const SizedBox(height: 20),
                    _buildLogoutButton(),
                    const SizedBox(height: 30),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Build each section with containers
  Widget buildSection(ProfileSection section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 4),
          child: profileCard(ProfileItem(title: section.title), isItem: false),
        ),
        Column(
          children: section.items
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: profileCard(item),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  // Delete account container
  Widget _buildDeleteAccount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: profileCard(
        ProfileItem(title: "delete_my_account".localized()),
        isItem: true,
        isDelete: true,
      ),
    );
  }

  // Logout button container
  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: customButtonApp(
              image: logoutIcon,
              text: "Logout".localized(),
              backgroundColor: lightRedColor,
              textColor: const Color(0xFF912018),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
