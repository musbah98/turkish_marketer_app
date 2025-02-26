import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/utils/app_widgets/buttons_widgets/custom_app_back_button.dart';
import 'package:turkish_marketer/utils/routing/routes.dart';

import '../../../../di.dart';
import '../../../../utils/app_widgets/app_card_widgets/sub_category_widget.dart';
import '../../../../utils/app_widgets/app_top_header_image.dart';
import '../../../../utils/app_widgets/custom_app_bar.dart';
import '../../../../utils/app_widgets/list_views_widgets/list_view_container_builder.dart';
import '../../../../utils/common_widgets/no_data_view.dart';
import '../../../../utils/decoration_and_assets/images.dart';
import '../../../../utils/routing/navigation_service.dart';
import 'sub_categories_view_model.dart';

class SubCategoriesScreen extends ConsumerStatefulWidget {
  const SubCategoriesScreen({super.key});

  @override
  ConsumerState<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends ConsumerState<SubCategoriesScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = ref.read(subCategoriesViewModelProvider);
      viewModel.context = context;
      viewModel.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, _) {
          final viewModel = ref.watch(subCategoriesViewModelProvider);

          return SingleChildScrollView(
            child: Stack(
              children: [
                appTopHeaderImage(image: backgroundGrid),
                Column(
                  children: [
                    customAppBar(
                      title: "sub-categories".localized(),
                      actions: [const SizedBox(width: 56)],
                      leading: customAppBackbutton(),
                    ),
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
                              sl<NavigationService>().navigateTo(categoryFilterScreen);
                            },
                            child: subCategoryCard(
                              isLoading: viewModel.isLoading,
                              title: "CUniforms - Aprons - Work Wears",
                            ),
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
