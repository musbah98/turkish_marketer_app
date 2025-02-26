import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turkish_marketer/extentions.dart';

import '../../../../utils/app_widgets/custom_app_bar.dart';
import '../../../../utils/app_widgets/list_views_widgets/list_view_container_builder.dart';
import '../../../../utils/common_widgets/no_data_view.dart';
import '../../../utils/app_widgets/app_card_widgets/index_product_card.dart';
import '../../../utils/app_widgets/buttons_widgets/custom_app_back_button.dart';
import '../../../utils/app_widgets/text_field_widgets/search_bar_text_field.dart';
import '../../../utils/decoration_and_assets/colors.dart';
import 'Index_of_products_view_model.dart';

class IndexProductsScreen extends ConsumerStatefulWidget {
  const IndexProductsScreen({super.key});

  @override
  ConsumerState<IndexProductsScreen> createState() => _IndexProductsScreenState();
}

class _IndexProductsScreenState extends ConsumerState<IndexProductsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = ref.read(indexProductsViewModelProvider);
      viewModel.context = context;
      viewModel.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, _) {
          final viewModel = ref.watch(indexProductsViewModelProvider);

          return RefreshIndicator.adaptive(
            edgeOffset: 50,
            onRefresh: viewModel.refresh,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      customAppBar(
                        title: "index_of_products".localized(),
                        titleColor: subTitleColor,
                        titleSize: 16,
                        fontWeight: FontWeight.w600,
                        actions: [const SizedBox(width: 56)],
                        leading: customAppBackbutton(),
                      ),
                      searchBarTextField(
                        textController: viewModel.textController,
                        hintText: "products".localized(),
                        onChangeText: (value) {
                          viewModel.onChangeText();
                        },
                      ),
                      if (viewModel.searchList.isEmpty) ...[
                        showNoDataView(
                          minHeight: MediaQuery.of(context).viewPadding.top.toInt() +
                              MediaQuery.of(context).viewPadding.bottom.toInt() +
                              140,
                        ),
                        const SizedBox(height: 20),
                      ] else ...[
                        listViewContainerBuilder(
                          verticalPadding: 16,
                          horizontalPadding: 16,
                          context: context,
                          itemCount: viewModel.searchList.length,
                          minHeight: MediaQuery.of(context).viewPadding.top.toInt() +
                              MediaQuery.of(context).viewPadding.bottom.toInt() +
                              140,
                          itemBuilder: (context, index) {
                            return InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                //  sl<NavigationService>().navigateTo(subCategoriesScreen);
                              },
                              child: indexProductCard(
                                isLoading: viewModel.isLoading,
                                title: viewModel.searchList[index].title ?? "",
                                total: viewModel.searchList[index].desc,
                              ),
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// alphabetScrollView(
//   IndexProductsViewModel viewModel,
//   int selectedIndex, {
//   required void Function(int) onChanged,
// }) =>
//     AzListView(
//       data: viewModel.items,
//       itemCount: viewModel.items.length,
//       itemBuilder: (BuildContext context, int index) {
//         return InkWell(
//           splashColor: Colors.transparent,
//           highlightColor: Colors.transparent,
//           onTap: () {
//             //  sl<NavigationService>().navigateTo(subCategoriesScreen);
//           },
//           child: indexProductCard(
//             isLoading: viewModel.isLoading,
//             title: viewModel.items[index].title ?? "",
//             total: viewModel.items[index].desc,
//           ),
//         );
//       },
//       physics: BouncingScrollPhysics(),
//       // susItemBuilder: (BuildContext context, int index) {
//       //   return InkWell(
//       //     splashColor: Colors.transparent,
//       //     highlightColor: Colors.transparent,
//       //     onTap: () {
//       //       //  sl<NavigationService>().navigateTo(subCategoriesScreen);
//       //     },
//       //     child: indexProductCard(
//       //       isLoading: viewModel.isLoading,
//       //       title: viewModel.items[index].title ?? "",
//       //       total: viewModel.items[index].desc,
//       //     ),
//       //   );
//       // },
//       indexBarData: ['↑', '☆', ...kIndexBarData],
//       indexBarOptions: IndexBarOptions(
//         needRebuild: true,
//         ignoreDragCancel: true,
//         downTextStyle: TextStyle(fontSize: 12, color: Colors.white),
//         downItemDecoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
//         indexHintWidth: 120 / 2,
//         indexHintHeight: 100 / 2,
//         indexHintDecoration: BoxDecoration(
//             // image: DecorationImage(
//             //   image: AssetImage(Utils.getImgPath('ic_index_bar_bubble_gray')),
//             //   fit: BoxFit.contain,
//             // ),
//             ),
//         indexHintAlignment: Alignment.centerRight,
//         indexHintChildAlignment: Alignment(-0.25, 0.0),
//         indexHintOffset: Offset(-20, 0),
//       ),
//     );
