import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:lox_mobile/home_view.dart';
import 'package:lox_mobile/view_appointments.dart';
import 'package:page_transition/page_transition.dart';


class SuccessScreen extends StatefulWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void initState() {
    super.initState();

    // Timer(const Duration(milliseconds: 1250), () {
    //   // Navigator.pop(context);
    //   Navigator.of(context).pushReplacement(
    //     PageTransition(
    //       child: const HomeView(),
    //       type: PageTransitionType.fade,
    //     ),
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: 8),
            curve: Curves.fastOutSlowIn,
            duration: const Duration(milliseconds: 650),
            builder: (BuildContext context, double? value, Widget? child) {
              return Transform.scale(
                scale: value! / 8,
                child: Neumorphic(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  style: NeumorphicStyle(
                    color: Colors.green,
                    depth: value,
                    intensity: value,
                    surfaceIntensity: value,
                    boxShape: const NeumorphicBoxShape.circle(),
                    shape: NeumorphicShape.concave,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check,
                      size: 56,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 30),
          const Text('Done', style: TextStyle(fontSize: 25)),
          const SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: ElevatedButton(
              onPressed: () {
                // Navigator.of(context).pop();

                Timer(const Duration(milliseconds: 1250), () {
                  // Navigator.pop(context);
                  Navigator.of(context).pushReplacement(
                    PageTransition(
                      child: const ViewAppointments(),
                      type: PageTransitionType.fade,
                    ),
                  );
                });
              },
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.blue.shade300,
                shadowColor: Colors.grey,
                elevation: 0,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.black26)
                ),
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.white, Colors.white],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text(
                    'View Appointments',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
