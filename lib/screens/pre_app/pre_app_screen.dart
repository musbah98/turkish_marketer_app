import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/app_widgets/app_top_header_image.dart';
import '../../utils/decoration_and_assets/colors.dart';
import '/screens/pre_app/pre_app_view_model.dart';
import '../../utils/decoration_and_assets/images.dart';

class PreAppScreen extends ConsumerStatefulWidget {
  const PreAppScreen({super.key});

  @override
  ConsumerState<PreAppScreen> createState() => _PreAppScreenState();
}

class _PreAppScreenState extends ConsumerState<PreAppScreen> {
  //late AnimationController _animation;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(preAppViewModelProvider).getMain();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Consumer(
          builder: (context, ref, _) {
            return Stack(
              fit: StackFit.expand,
              // clipBehavior: Clip.none,
              children: [
                appTopHeaderImage(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 100),
                          SvgPicture.asset(
                            fullLogo,
                          ),
                          const SizedBox(height: 30),
                          RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              text: 'Bridging Cultures, ',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Building Businesses',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: redColor1,
                                    fontSize: 20,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
