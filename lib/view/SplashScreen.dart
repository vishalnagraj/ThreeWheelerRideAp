import 'package:flutter/material.dart';
import 'package:user_app/Config/AllDimensions.dart';
import 'package:user_app/Config/AllImages.dart';
import 'package:user_app/Config/AllTitles.dart';
import 'package:user_app/Config/Allcolors.dart';
import 'package:get/get.dart';
import 'package:user_app/view_model/SplashViewModel.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashViewModel = Get.put(SplashViewModel());

  @override
  void initState() {
    super.initState();
    splashViewModel.checkPermission(context);
    _startSplashScreenTimer();
  }

  void _startSplashScreenTimer() {
    Timer(const Duration(seconds: 4), () {
      // Navigate to the next screen after the splash duration
      Navigator.of(context).pushReplacementNamed('authScreen'); // Replace 'nextScreen' with your actual route
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Allcolors.blueColor, // Start color
                Allcolors.greenColor, // End color
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          height: AllDimensions.infinity,
          width: AllDimensions.infinity,
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned(
                left: 50,
                right: 50,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AllImages.logoImage,
                        height: 150, // Adjust height as needed
                        width: 150,  // Adjust width as needed
                      ),
                      const SizedBox(height: 20),
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Allcolors.whiteColor),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Loading...",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Allcolors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 30,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    AllTitles.poweredTitle,
                    style: TextStyle(
                      fontSize: 16,
                      color: Allcolors.whiteColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
