import 'dart:async';
import 'dart:math'; // Import for random number generation
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:user_app/Config/AllDimensions.dart';
import 'package:user_app/Config/AllImages.dart';
import 'package:user_app/Config/AllTitles.dart';
import 'package:user_app/Config/Allcolors.dart';
import 'package:user_app/Config/routes/PageConstants.dart';

import '../../Config/Notification/MyCustomNotification.dart';

class OTPPage extends StatefulWidget {
  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final _otpTextEditingController = TextEditingController();
  StreamController<ErrorAnimationType> _errorController =
  StreamController<ErrorAnimationType>();
  late String generatedOTP;

  @override
  void initState() {
    super.initState();

    // Simulate receiving a random OTP
    Future.delayed(Duration(seconds: 3), () {
      generatedOTP = generateRandomOTP(); // Generate random OTP
      showOTPNotification(generatedOTP);

      // Autofill the OTP field (Optional)
      _otpTextEditingController.text = generatedOTP;
    });
  }

  // Function to generate a random 6-digit OTP
  String generateRandomOTP() {
    final random = Random();
    return (100000 + random.nextInt(900000)).toString(); // Ensures a 6-digit OTP
  }

  // Show OTP Notification
  void showOTPNotification(String otp) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'otp_channel',
      'OTP Notifications',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Your OTP Code',
      'Your OTP is: $otp',
      notificationDetails,
    );
  }

  // Validate OTP and navigate to the next page
  void _onSubmit() {
    String enteredOTP = _otpTextEditingController.text.trim();

    if (enteredOTP == generatedOTP) {
      // OTP is correct, navigate to the next page
      Navigator.pushNamedAndRemoveUntil(
          context, PageConstants.homeScreen, (route) => false);
    } else {
      // OTP is incorrect, show an error message
      _errorController.add(ErrorAnimationType.shake); // Trigger shake animation for incorrect OTP
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid OTP, please try again."),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Allcolors.blueColor,
                Allcolors.greenColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  margin: EdgeInsets.all(AllDimensions.thirtyTwo),
                  height: AllDimensions.twoHundred,
                  width: AllDimensions.twoHundred,
                  child: Image.asset(AllImages.logoImage),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(AllDimensions.twenty),
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Enter OTP",
                          style: TextStyle(
                            fontSize: AllDimensions.twentyFour,
                            fontWeight: FontWeight.bold,
                            color: Allcolors.blueColor,
                          ),
                        ),
                        Text(
                          AllTitles.otpSentDesc,
                          style: TextStyle(
                            color: Allcolors.greyColor,
                          ),
                        ),
                        SizedBox(height: AllDimensions.eigth),
                        PinCodeTextField(
                          keyboardType: TextInputType.number,
                          cursorColor: Allcolors.blackColor,
                          length: 6,
                          controller: _otpTextEditingController,
                          appContext: context,
                          onChanged: (value) {},
                          // Bind error controller
                        ),
                        SizedBox(height: AllDimensions.eigth),
                        InkWell(
                          onTap: _onSubmit, // OnSubmit handler
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: AllDimensions.sixteen,
                              vertical: AllDimensions.twelve,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Allcolors.blueColor,
                                  Allcolors.greenColor,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius:
                              BorderRadius.circular(AllDimensions.eigth),
                            ),
                            child: Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  color: Allcolors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
