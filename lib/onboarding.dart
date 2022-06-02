import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'login.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 0,
          left: 0,
          bottom: 0,
          right: 0,
          child: SafeArea(
            child: IntroductionScreen(
              pages: [
                PageViewModel(
                  title: 'Hi there',
                  body: 'This is Lox Service App development test!',
                  image: null,
                  decoration: gePageDecoration(),
                ),
                // PageViewModel(
                //   title: 'Hi there',
                //   body: 'This is Lox Service App development test!',
                //   image: buildBackgroundImage('assets/onboarding_image.png'),
                //   decoration: gePageDecoration(),
                //   footer: ButtonWidget(
                //     text: getStartedButtonText,
                //     color: Constant.darkGrey,
                //     borderRadius: 10,
                //     onClicked: () => _login(context),
                //   ),
                // ),
              ],
              done: const Text(
                'Next',
                style: TextStyle(fontSize: 20),
              ),
              onDone: () => _login(context),
              doneColor: Colors.black,
              showSkipButton: true,
              skip: const Text(
                'Skip',
                style: TextStyle(fontSize: 20),
              ),
              skipColor: Colors.black,
              skipFlex: 0,
              nextFlex: 0,
              nextColor: Colors.black,
              next: const Icon(Icons.arrow_forward),
              dotsDecorator: getDotDecorator(),
              // onChange: (index) => print('Page $index selected'),
              globalBackgroundColor: Colors.white,
            ),
          ),
        ),
        // Positioned(
        //   top: 0,
        //   left: 0,
        //   child: Image.asset('assets/squarecle.png', width: size.width * 0.7),
        // ),
        // Positioned(
        //   top: 80,
        //   left: 40,
        //   child: Text(
        //     welcomeText,
        //     style: const TextStyle(
        //         color: Constant.accent,
        //         fontSize: 25.0,
        //         decoration: TextDecoration.none),
        //   ),
        // )
      ],
    );
  }

  Widget buildBackgroundImage(String path) {
    return Center(
      child: Image.asset(path, width: 550, height: 500),
    );
  }

  PageDecoration gePageDecoration() => PageDecoration(
    boxDecoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/onboarding.png"),
        fit: BoxFit.cover,
      ),
    ),
    titleTextStyle: TextStyle(
        color: Colors.black.withOpacity(0.0),
        fontSize: 30,
        fontWeight: FontWeight.bold),
    bodyTextStyle: TextStyle(
        color: Colors.black.withOpacity(0.0), fontSize: 25),
    descriptionPadding: const EdgeInsets.all(16),
    imagePadding: const EdgeInsets.only(top: 280.0),
    contentMargin: const EdgeInsets.only(top: 50.0),
    // pageColor: Constant.white,
  );

  DotsDecorator getDotDecorator() => DotsDecorator(
      color: Colors.grey,
      size: const Size(10, 10),
      activeColor: Colors.blue.shade200,
      activeSize: const Size(21, 10),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ));
}

void _login(context) {

  Navigator.of(context).pushReplacement(
    PageTransition(
      type: PageTransitionType.bottomToTop,
      child: const Login(),
    ),
  );
}
