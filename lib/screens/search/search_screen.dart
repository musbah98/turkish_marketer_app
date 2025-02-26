import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/utils/app_widgets/custom_app_bar.dart';
import 'package:turkish_marketer/utils/app_widgets/app_card_widgets/post_card.dart';
import 'package:turkish_marketer/utils/common_widgets/no_data_view.dart';

import '../../utils/app_widgets/list_views_widgets/list_view_container_builder.dart';

import '../../utils/app_widgets/app_top_header_image.dart';
import '../../utils/app_widgets/buttons_widgets/custom_app_back_button.dart';
import '../../utils/app_widgets/text_field_widgets/search_bar_text_field.dart';
import '../../utils/decoration_and_assets/images.dart';
import '../../utils/hide_keyboard_on_tap.dart';
import 'search_view_model.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = ref.read(searchViewModelProvider);
      viewModel.context = context;
      // viewModel.getMain();
    });
  }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return HideKeyboardOnTap(
      child: Scaffold(
        body: Consumer(
          builder: (context, ref, _) {
            final searchViewModel = ref.watch(searchViewModelProvider);

            return SingleChildScrollView(
              child: Stack(
                children: [
                  appTopHeaderImage(top: MediaQuery.of(context).viewPadding.top - 55, image: backgroundRadial),
                  Column(
                    children: [
                      customAppBar(
                        title: "search".localized(),
                        actions: [const SizedBox(width: 56)],
                        leading: customAppBackbutton(),
                      ),
                      searchBarTextField(
                        onChangeText: (p0) {},
                      ),
                      //const SizedBox(height: 0),
                      if (searchViewModel.data.isEmpty) ...[
                        showNoDataView(
                          image: searchIcon,
                          text: "no_results_were_found_matching_your_search".localized(),
                          minHeight: MediaQuery.of(context).viewPadding.top.toInt() +
                              MediaQuery.of(context).viewPadding.bottom.toInt() +
                              130,
                        ),
                        const SizedBox(height: 20),
                      ] else ...[
                        listViewContainerBuilder(
                          bgColor: Colors.white,
                          context: context,
                          itemCount: 5,
                          minHeight: MediaQuery.of(context).viewPadding.top.toInt() +
                              MediaQuery.of(context).viewPadding.bottom.toInt() +
                              240,
                          itemBuilder: (context, index) {
                            return postCard();
                          },
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
