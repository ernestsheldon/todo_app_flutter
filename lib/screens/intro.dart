import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'home.dart';

class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      showNextButton: true,
      showDoneButton: true,
      showSkipButton: false,
      done: const Text('Done'),
      onDone: () => Get.to(() => const Home()),
      next: const Icon(Icons.arrow_forward),
      pages: [
        PageViewModel(
          image: SvgPicture.asset('assets/intro1.svg'),
          title: 'Todo App',
          body:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse sed neque pulvinar, dapibus lacus ac, tincidunt nisl. Duis bibendum eleifend iaculis.',
          decoration: const PageDecoration(
            imagePadding: EdgeInsets.only(top: 50.0),
          ),
        ),
        PageViewModel(
          image: SvgPicture.asset('assets/intro2.svg'),
          title: 'Easy to use',
          body:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse sed neque pulvinar, dapibus lacus ac, tincidunt nisl. Duis bibendum eleifend iaculis.',
          decoration: const PageDecoration(
            imagePadding: EdgeInsets.only(top: 50.0),
          ),
        ),
      ],
    );
  }
}
