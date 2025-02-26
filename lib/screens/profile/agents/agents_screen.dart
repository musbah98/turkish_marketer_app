import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/utils/app_widgets/app_card_widgets/list_card.dart';

import '../../../../utils/app_widgets/app_top_header_image.dart';
import '../../../../utils/app_widgets/custom_app_bar.dart';
import '../../../../utils/app_widgets/list_views_widgets/list_view_container_builder.dart';
import '../../../../utils/common_widgets/no_data_view.dart';
import '../../../../utils/decoration_and_assets/images.dart';
import '../../../utils/app_widgets/buttons_widgets/custom_app_back_button.dart';
import '../../../utils/decoration_and_assets/colors.dart';
import 'agents_view_model.dart';

class AgentsScreen extends ConsumerStatefulWidget {
  const AgentsScreen({super.key});

  @override
  ConsumerState<AgentsScreen> createState() => _AgentsScreenState();
}

class _AgentsScreenState extends ConsumerState<AgentsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = ref.read(agentsViewModelProvider);
      viewModel.context = context;
      viewModel.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, _) {
          final viewModel = ref.watch(agentsViewModelProvider);

          return SingleChildScrollView(
            child: Stack(
              children: [
                appTopHeaderImage(image: backgroundGrid),
                Column(
                  children: [
                    customAppBar(
                      title: "agents".localized(),
                      titleColor: subTitleColor,
                      titleSize: 16,
                      fontWeight: FontWeight.w600,
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
                              //  sl<NavigationService>().navigateTo(subCategoriesScreen);
                            },
                            child: listCard(
                              isLoading: viewModel.isLoading,
                              image: featuredIcon,
                              title: "Here_the proxy addres Here the proxy addres",
                              subTitle: "Australia",
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
