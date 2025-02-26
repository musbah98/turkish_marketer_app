import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/colors.dart';
import 'package:turkish_marketer/utils/routing/routes.dart';

import '../../../../di.dart';
import '../../../../utils/app_widgets/app_card_widgets/post_details_card.dart';
import '../../../../utils/app_widgets/app_top_header_image.dart';
import '../../../../utils/app_widgets/buttons_widgets/custom_app_back_button.dart';
import '../../../../utils/app_widgets/buttons_widgets/custom_app_button.dart';
import '../../../../utils/app_widgets/custom_app_bar.dart';
import '../../../../utils/app_widgets/list_views_widgets/contact_info_container_view.dart';
import '../../../../utils/app_widgets/list_views_widgets/attachments_container_list_view.dart';
import '../../../../utils/decoration_and_assets/images.dart';
import '../../../../utils/routing/navigation_service.dart';
import 'post_details_view_model.dart';

class PostDetailsScreen extends ConsumerStatefulWidget {
  const PostDetailsScreen({super.key});

  @override
  ConsumerState<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends ConsumerState<PostDetailsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = ref.read(postDetailsViewModelProvider);
      viewModel.context = context;
      viewModel.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, _) {
          final viewModel = ref.watch(postDetailsViewModelProvider);

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
                            actions: [const SizedBox(width: 56)],
                            leading: customAppBackbutton(),
                          ),
                          postDetailsCard(
                            isLoading: viewModel.isLoading,
                          ),
                          attachmentsContainerListView(
                            isLoading: viewModel.isLoading,
                            attachments: viewModel.attchments,
                            containerborderColor: Colors.transparent,
                          ),
                          contactInfoContainerView(
                            isLoading: viewModel.isLoading,
                            name: "Enver ASLAN",
                            country: "Egypt",
                            containerborderColor: Colors.transparent,
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
