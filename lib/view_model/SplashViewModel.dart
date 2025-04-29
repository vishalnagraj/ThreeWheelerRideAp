import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:user_app/Config/AllTitles.dart';
import 'package:user_app/Config/Notification/MyCustomNotification.dart';
import 'package:user_app/Config/Utils.dart';
import 'package:user_app/Config/routes/PageConstants.dart';
import 'dart:async'; // Import for Timer

class SplashViewModel extends GetxController {
  var latitude = "".obs;
  var longitude = "".obs;

  Future<void> checkPermission(BuildContext context) async {
    Map<Permission, PermissionStatus> status = await [
      Permission.notification,
      Permission.camera,
      Permission.phone,
      // Permission.storage,
      Permission.location,
    ].request();

    if (await Permission.notification.request().isGranted &&
        await Permission.camera.request().isGranted &&
        await Permission.phone.request().isGranted &&
        // await Permission.storage.request().isGranted &&
        await Permission.location.request().isGranted) {

      // My custom notifications methods
      MyCustomNotification.getFcmToken();
      MyCustomNotification.getFirebaseMesagingInBackground();
      MyCustomNotification.getFirebaseMesagingInForeground(context);

      // Introduce a 4-second delay before getting the current location
      await Future.delayed(const Duration(seconds: 4));

      // Get current location
      _getCurrentLocation(context);
    } else {
      Utils.myLogs(AllTitles.allowPerimssion);
    }
  }

  Future<Position> _getCurrentLocation(BuildContext context) async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if (position.latitude != 0 && position.longitude != 0) {
      Utils.myLogs("Latitude: ${position.latitude}, Longitude: ${position.longitude}");
      latitude.value = position.latitude.toString();
      longitude.value = position.longitude.toString();
      _launchPage(context);
    }
    return await Geolocator.getCurrentPosition();
  }

  void _launchPage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, PageConstants.authScreen, (route) => false);
  }
}

