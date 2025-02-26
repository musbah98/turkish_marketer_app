import 'package:flutter/material.dart';

import '../../../utils/app_widgets/custom_app_text.dart';
import '../on_boarding_view_model.dart';

Widget textPagerView({required OnBoardingViewModel viewModel}) => Expanded(
      child: PageView.builder(
        controller: viewModel.pageViewController,
        itemCount: viewModel.data.length,
        onPageChanged: (int page) {
          viewModel.changeCurrentPageIndex(page);
        },
        itemBuilder: (BuildContext context, int index) {
          return textColumnView(
            title: viewModel.data[index]['title'],
            subTitle: viewModel.data[index]['description'],
          );
        },
      ),
    );

Widget textColumnView({required String title, required String subTitle}) => Column(
      children: [
        Flexible(
          child: FittedBox(
            child: customTextApp(
              text: title,
              color: Colors.white,
              size: 30,
              fontWeight: FontWeight.w600,
              maxLine: 2,
              align: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const SizedBox(height: 22),
        Flexible(
          child: customTextApp(
            text: subTitle,
            color: Colors.white.withOpacity(0.56),
            maxLine: 3,
            align: TextAlign.center,
            overflow: TextOverflow.fade,
          ),
        ),
      ],
    );
