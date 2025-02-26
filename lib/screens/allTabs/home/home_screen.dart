import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/utils/app_widgets/custom_app_bar.dart';
import 'package:turkish_marketer/utils/app_widgets/app_card_widgets/post_card.dart';
import 'package:turkish_marketer/utils/common_widgets/no_data_view.dart';
import 'package:turkish_marketer/utils/routing/navigation_service.dart';

import '../../../di.dart';
import '../../../utils/app_widgets/list_views_widgets/list_view_container_builder.dart';
import '../../../utils/app_widgets/slider_widgets/custom_slider_button.dart';
import '../../../utils/app_widgets/slider_widgets/custom_slider_container.dart';
import '../../../utils/routing/routes.dart';
import 'home_view_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = ref.read(homeViewModelProvider);
      viewModel.context = context;
      viewModel.getData();
      print("HomeScreen");
    });
  }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, _) {
          final homeViewModel = ref.watch(homeViewModelProvider);

          return SingleChildScrollView(
            child: Stack(
              children: [
                // appTopHeaderImage(top: MediaQuery.of(context).viewPadding.top - 50, image: backgroundRadial),
                Column(
                  children: [
                    customAppBar(title: "imports".localized()),
                    //const SizedBox(height: 22),
                    customSliderContainer(
                      itemCount: homeViewModel.mainFilter.length,
                      spaceBetween: 8,
                      itemBuilder: (context, index) {
                        return customSliderButton(
                          text: homeViewModel.mainFilter[index].name ?? "",
                          isSelected: homeViewModel.mainFilter[index].isSelected ?? false,
                          width: (MediaQuery.of(context).size.width / homeViewModel.mainFilter.length) - 12,
                          onPressed: () {
                            homeViewModel.didSelectFilter(index);
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    customSliderContainer(
                      horizontalMargin: 16,
                      isCornerRadius: true,
                      spaceBetween: 8,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return customSliderButton(
                          text: homeViewModel.mainFilter[index].name ?? "",
                          isSelected: true,
                          totalText: "2",
                          width: MediaQuery.of(context).size.width / 2 - 32,
                          onPressed: () {},
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    if (homeViewModel.mainFilter.isEmpty) ...[
                      showNoDataView(
                        minHeight: MediaQuery.of(context).viewPadding.top.toInt() +
                            MediaQuery.of(context).viewPadding.bottom.toInt() +
                            240,
                      ),
                      const SizedBox(height: 20),
                    ] else ...[
                      Container(
                        child: listViewContainerBuilder(
                          context: context,
                          itemCount: 4,
                          minHeight: MediaQuery.of(context).viewPadding.top.toInt() +
                              MediaQuery.of(context).viewPadding.bottom.toInt() +
                              240,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                sl<NavigationService>().navigateTo(postDetailsScreen);
                              },
                              child: postCard(
                                isLoading: homeViewModel.isLoading,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
