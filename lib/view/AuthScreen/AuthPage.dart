import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user_app/Config/AllDimensions.dart';
import 'package:user_app/Config/AllImages.dart';
import 'package:user_app/Config/Allcolors.dart';
import 'package:user_app/Config/routes/PageConstants.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Validate phone number
  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a phone number.";
    } else if (value.length != 10 || int.tryParse(value) == null) {
      return "Please enter a valid 10-digit phone number.";
    }
    return null;
  }

  // Navigate to OTP screen if the phone number is valid
  void _onSendOTP() {
    if (_formKey.currentState?.validate() ?? false) {
      // If the phone number is valid, navigate to the OTP screen
      Navigator.pushNamed(context, PageConstants.otpScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // Gradient Background
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
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              // Logo Section
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

              // Login Card Section
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(AllDimensions.twenty),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Login",
                            style: TextStyle(
                              fontSize: AllDimensions.twentyFour,
                              fontWeight: FontWeight.bold,
                              color: Allcolors.blueColor,
                            ),
                          ),
                          Text(
                            "Please enter your phone number to proceed",
                            style: TextStyle(
                              color: Allcolors.greyColor,
                            ),
                          ),
                          SizedBox(height: AllDimensions.eigth),

                          // Phone Number Input Field
                          Container(
                            padding: EdgeInsets.all(AllDimensions.eigth),
                            height: AllDimensions.fifty,
                            decoration: BoxDecoration(
                              color: Allcolors.whiteColor, // Background for the input field
                              border: Border.all(color: Allcolors.greyColor),
                              borderRadius: BorderRadius.circular(AllDimensions.eigth),
                            ),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "+91",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AllDimensions.sixteen,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: AllDimensions.eigth),
                                    child: TextFormField(
                                      controller: _phoneController,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                        fontSize: AllDimensions.sixteen,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      cursorColor: Allcolors.blackColor,
                                      decoration: InputDecoration(
                                        hintText: 'Enter phone number',
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(bottom: AllDimensions.twelve),
                                      ),
                                      validator: _validatePhoneNumber,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: AllDimensions.eigth),

                          // Send OTP Button
                          InkWell(
                            onTap: _onSendOTP, // Only navigate if the phone number is valid
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
                                borderRadius: BorderRadius.circular(AllDimensions.eigth),
                              ),
                              child: Center(
                                child: Text(
                                  "Send OTP",
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
