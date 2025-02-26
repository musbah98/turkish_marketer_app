import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/utils/app_widgets/app_card_widgets/company_card.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/colors.dart';
import 'package:turkish_marketer/utils/routing/routes.dart';

import '../../../../di.dart';
import '../../../../utils/app_widgets/app_top_header_image.dart';
import '../../../../utils/app_widgets/buttons_widgets/custom_app_back_button.dart';
import '../../../../utils/app_widgets/buttons_widgets/custom_app_button.dart';
import '../../../../utils/app_widgets/custom_app_bar.dart';
import '../../../../utils/app_widgets/list_views_widgets/contact_info_container_view.dart';
import '../../../../utils/app_widgets/list_views_widgets/products_list_view.dart';
import '../../../../utils/app_widgets/list_views_widgets/tags_container_list_view.dart';
import '../../../../utils/decoration_and_assets/images.dart';
import '../../../../utils/routing/navigation_service.dart';
import 'company_details_view_model.dart';

class CompanyDetailsScreen extends ConsumerStatefulWidget {
  const CompanyDetailsScreen({super.key});

  @override
  ConsumerState<CompanyDetailsScreen> createState() => _CompanyDetailsScreenState();
}

class _CompanyDetailsScreenState extends ConsumerState<CompanyDetailsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = ref.read(companyDetailsViewModelProvider);
      viewModel.context = context;
      viewModel.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, _) {
          final viewModel = ref.watch(companyDetailsViewModelProvider);

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      appTopHeaderImage(top: MediaQuery.of(context).viewPadding.top - 55, image: backgroundRadial),
                      Column(
                        children: [
                          customAppBar(
                            title: "Curtain Pole import Egypt".localized(),
                            titleColor: subTitleColor,
                            titleSize: 16,
                            fontWeight: FontWeight.w600,
                            actions: [
                              IconButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: () {},
                                icon: Image.asset(phoneCallicon),
                              ),
                            ],
                            leading: customAppBackbutton(),
                          ),
                          const SizedBox(height: 16),
                          companyCard(
                            isLoading: viewModel.isLoading,
                            isDescrption: true,
                          ),
                          const SizedBox(height: 32),
                          tagsContainerListView(isLoading: viewModel.isLoading, tags: viewModel.tags),
                          const SizedBox(height: 16),
                          contactInfoContainerView(
                            isLoading: viewModel.isLoading,
                            name: "Enver ASLAN Enver ASLAN Enver",
                            country: "Egypt",
                          ),
                          const SizedBox(height: 16),
                          productsListView(
                            isLoading: viewModel.isLoading,
                            products: [
                              "Welding electrodes Flexible Welding electrodes Flexible",
                              "Aluminium window",
                              "Welding electrodes",
                              "Aluminium window",
                              "Welding electrodes",
                              "Aluminium window",
                              "Welding electrodes",
                              "Aluminium window",
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: customButtonApp(
                  width: double.infinity,
                  text: 'contact_now'.localized(),
                  onPressed: () {
                    sl<NavigationService>().navigateTo(rfqScreen);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
