import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turkish_marketer/screens/on_boarding/widgets/page_indicator.dart';
import 'package:turkish_marketer/utils/decoration_and_assets/colors.dart';

import '../../utils/decoration_and_assets/images.dart';
import '../../utils/app_widgets/app_top_header_image.dart';

import 'on_boarding_view_model.dart';
import 'widgets/bottom_buttons_view.dart';
import 'widgets/text_page_view.dart';

class OnBoardingScreen extends ConsumerStatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnBoardingScreen createState() => _OnBoardingScreen();
}

class _OnBoardingScreen extends ConsumerState<OnBoardingScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = ref.read(onBoardingViewModelProvider);
      viewModel.context = context;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     statusBarColor: Colors.transparent,
    //     statusBarIconBrightness: Brightness.light,
    //   ),
    //);
    return Scaffold(
      body: Consumer(
        builder: (context, ref, _) {
          final onBoardingViewModel = ref.watch(onBoardingViewModelProvider);

          return SafeArea(
            top: false,
            bottom: false,
            child: Consumer(
              builder: (context, ref, _) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    appTopHeaderImage(),
                    Column(
                      children: [
                        const SizedBox(height: 54),
                        SvgPicture.asset(
                          fullLogo,
                        ),
                        const SizedBox(height: 40),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Stack(
                            children: [
                              Image.asset(
                                height: screenHeight / 1.5,
                                mockupImage,
                              ),
                              Positioned.fill(
                                top: 4,
                                right: 5,
                                left: 5,
                                bottom: 4,
                                child: PageView.builder(
                                  controller: onBoardingViewModel.imagePageViewController,
                                  itemCount: onBoardingViewModel.data.length,
                                  onPageChanged: (int page) {
                                    onBoardingViewModel.changeCurrentPageIndex(page);
                                  },
                                  itemBuilder: (BuildContext context, int index) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(25.0),
                                      child: Image.network(
                                        fit: BoxFit.fitHeight,
                                        onBoardingViewModel.data[index]["image"],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: screenHeight / 1.7,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          color: redColor1,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(height: 10),
                            indicatorView(viewModel: onBoardingViewModel),
                            textPagerView(viewModel: onBoardingViewModel),
                            const SizedBox(height: 1),
                            bottomButtonsView(viewModel: onBoardingViewModel),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
