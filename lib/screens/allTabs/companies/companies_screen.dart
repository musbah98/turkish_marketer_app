import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/screens/allTabs/companies/companies_view_model.dart';
import 'package:turkish_marketer/utils/app_widgets/app_card_widgets/company_card.dart';
import 'package:turkish_marketer/utils/routing/navigation_service.dart';
import 'package:turkish_marketer/utils/routing/routes.dart';

import '../../../di.dart';
import '../../../utils/app_widgets/app_top_header_image.dart';
import '../../../utils/app_widgets/custom_app_bar.dart';
import '../../../utils/app_widgets/list_views_widgets/list_view_container_builder.dart';
import '../../../utils/app_widgets/slider_widgets/custom_slider_button.dart';
import '../../../utils/app_widgets/slider_widgets/custom_slider_container.dart';
import '../../../utils/common_widgets/no_data_view.dart';
import '../../../utils/decoration_and_assets/images.dart';

class CompaniesScreen extends ConsumerStatefulWidget {
  const CompaniesScreen({super.key});

  @override
  ConsumerState<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends ConsumerState<CompaniesScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = ref.read(companiesViewModelProvider);
      viewModel.context = context;
      viewModel.getData();
      print("CompaniesScreen");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, _) {
          final companiesViewModel = ref.watch(companiesViewModelProvider);

          return SingleChildScrollView(
            child: Stack(
              children: [
                appTopHeaderImage(top: MediaQuery.of(context).viewPadding.top - 55, image: backgroundRadial),
                Column(
                  children: [
                    customAppBar(title: "companies".localized()),
                    const SizedBox(height: 16),
                    customSliderContainer(
                      horizontalMargin: 16,
                      isCornerRadius: true,
                      spaceBetween: 8,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return customSliderButton(
                          text: companiesViewModel.mainFilter[index].name ?? "",
                          isSelected: true,
                          totalText: "2",
                          width: MediaQuery.of(context).size.width / 2 - (16 * 2),
                          onPressed: () {},
                        );
                      },
                    ),
                    if (companiesViewModel.mainFilter.isEmpty) ...[
                      showNoDataView(
                        minHeight: MediaQuery.of(context).viewPadding.top.toInt() +
                            MediaQuery.of(context).viewPadding.bottom.toInt() +
                            240,
                      ),
                      const SizedBox(height: 20),
                    ] else ...[
                      const SizedBox(height: 32),
                      listViewContainerBuilder(
                        context: context,
                        itemCount: companiesViewModel.items.length,
                        minHeight: MediaQuery.of(context).viewPadding.top.toInt() +
                            MediaQuery.of(context).viewPadding.bottom.toInt() +
                            240,
                        itemBuilder: (context, index) {
                          return InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              // var companyDetailsViewModel = ref.read(companyDetailsViewModelProvider);
                              // ref.read(companyDetailsViewModel.obj.state).state =
                              //     companiesViewModel.mainFilter[index];
                              sl<NavigationService>().navigateTo(companyDetailsScreen);
                            },
                            child: companyCard(
                              isLoading: companiesViewModel.isLoading,
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
