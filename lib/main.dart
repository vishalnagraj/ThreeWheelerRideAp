import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:user_app/Config/AllTitles.dart';
import 'package:user_app/Config/routes/OnGenerateRoute.dart';
import 'package:user_app/view/Category/ElderlySection.dart';
import 'package:user_app/view/Category/HandicappedSection.dart';
import 'package:user_app/view/Category/WomenSection.dart';
import 'package:user_app/view/SplashScreen.dart';
import 'package:user_app/view/HomeScreen.dart'; // Import your HomeScreen

// Local Notifications Plugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Local Notifications
  const AndroidInitializationSettings androidInitializationSettings =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
  InitializationSettings(android: androidInitializationSettings);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AllTitles.appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        'home': (context) => HomeScreen(), // Route for HomeScreen
        'women': (context) => WomenSection(), // Route for WomenSection
        'elderly': (context) => ElderlySection(), // Route for ElderlySection
        'handicapped': (context) => HandicappedSection(), // Route for HandicappedSection
      },
      onGenerateRoute: OnGenerateRoute.routes,
    );
  }
}
