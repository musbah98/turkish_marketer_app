import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/screens/allTabs/categories/categories_view_model.dart';
import 'package:turkish_marketer/utils/app_widgets/app_card_widgets/list_card.dart';
import '../../../di.dart';
import '../../../utils/app_widgets/app_top_header_image.dart';
import '../../../utils/app_widgets/custom_app_bar.dart';
import '../../../utils/app_widgets/list_views_widgets/list_view_container_builder.dart';
import '../../../utils/common_widgets/no_data_view.dart';
import '../../../utils/decoration_and_assets/images.dart';
import '../../../utils/routing/navigation_service.dart';
import '../../../utils/routing/routes.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key});

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = ref.read(categoriesViewModelProvider);
      viewModel.context = context;
      viewModel.getData();
      print("Categories Screen");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, _) {
          final viewModel = ref.watch(categoriesViewModelProvider);

          return SingleChildScrollView(
            child: Stack(
              children: [
                appTopHeaderImage(top: MediaQuery.of(context).viewPadding.top - 55, image: backgroundRadial),
                Column(
                  children: [
                    customAppBar(title: "categories".localized()),
                    if (viewModel.items.isEmpty) ...[
                      showNoDataView(
                        minHeight: MediaQuery.of(context).viewPadding.top.toInt() +
                            MediaQuery.of(context).viewPadding.bottom.toInt() +
                            240,
                      ),
                      const SizedBox(height: 20),
                    ] else ...[
                      listViewContainerBuilder(
                        verticalPadding: 16,
                        horizontalPadding: 16,
                        context: context,
                        itemCount: viewModel.items.length,
                        minHeight: MediaQuery.of(context).viewPadding.top.toInt() +
                            MediaQuery.of(context).viewPadding.bottom.toInt() +
                            240,
                        itemBuilder: (context, index) {
                          return InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              sl<NavigationService>().navigateTo(subCategoriesScreen);
                            },
                            child: listCard(
                                isLoading: viewModel.isLoading,
                                image: featuredIcon,
                                title: "Agricultural Machinery ",
                                subTitle: "Find the best solution for you."),
                          );
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
    );
  }
}
