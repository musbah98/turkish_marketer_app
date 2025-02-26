import 'package:flutter/material.dart';
import 'package:turkish_marketer/extentions.dart';

import '../../../di.dart';
import '../../../utils/app_widgets/buttons_widgets/custom_app_button.dart';
import '../../../utils/decoration_and_assets/colors.dart';
import '../../../utils/routing/navigation_service.dart';
import '../../../utils/routing/routes.dart';
import '../on_boarding_view_model.dart';

Widget bottomButtonsView({required OnBoardingViewModel viewModel}) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: FittedBox(
            child: customButtonApp(
              text: "skip_to_home_page".localized(),
              backgroundColor: disabledButtonColor,
              textColor: activeButtonColor,
              onPressed: () {
                sl<NavigationService>().navigateToAndRemove(loginScreen);
              },
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: customButtonApp(
            text: "next".localized(),
            onPressed: () {
              viewModel.changeCurrentPageIndex(viewModel.currentPageIndex + 1);
            },
          ),
        )
      ],
    );
