import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:user_app/view/AuthScreen/AuthPage.dart';
import 'package:user_app/view/AuthScreen/OTPPage.dart';
import 'package:user_app/view/Booking/BookingCompleted.dart';
import 'package:user_app/view/Booking/BookingSection.dart';
import 'package:user_app/view/Booking/BookingSuccessfully.dart';
import 'package:user_app/view/Booking/RentalSection.dart';
import 'package:user_app/view/Category/ElderlySection.dart';
import 'package:user_app/view/Category/HandicappedSection.dart';
import 'package:user_app/view/Category/WomenSection.dart';
import 'package:user_app/view/ChatBot/ChatBotPage.dart'; // Import ChatBotPage
import 'package:user_app/view/ErrorScreen.dart';
import 'package:user_app/view/HomeBar/About.dart';
import 'package:user_app/view/HomeBar/History.dart';
import 'package:user_app/view/HomeBar/Insurance.dart';
import 'package:user_app/view/HomeBar/Payment.dart';
import 'package:user_app/view/HomeBar/Support.dart';
import 'package:user_app/view/HomeScreen.dart';
import 'package:user_app/view/Location/DrawRoutesScreen.dart';
import 'package:user_app/view/Location/SearchDestination.dart';
import 'package:user_app/view/Location/SearchLocation.dart';
import 'package:user_app/view/SplashScreen.dart';
import 'PageConstants.dart';

class OnGenerateRoute {
  static Route<dynamic> routes(RouteSettings settings) {
    var args = settings.arguments;

    switch (settings.name) {
      case PageConstants.splashScreen:
        return materialPageRoute(widget: SplashScreen());

      case PageConstants.homeScreen:
        return materialPageRoute(widget: HomeScreen());

      case PageConstants.history:
        return materialPageRoute(widget: HistoryScreen());

      case PageConstants.payment:
        return materialPageRoute(widget: PaymentScreen());

      case PageConstants.insurance:
        return materialPageRoute(widget: InsuranceScreen());

      case PageConstants.support:
        return materialPageRoute(widget: SupportScreen());

      case PageConstants.about:
        return materialPageRoute(widget: AboutScreen());

      case PageConstants.authScreen:
        return materialPageRoute(widget: AuthPage());

      case PageConstants.otpScreen:
        return materialPageRoute(widget: OTPPage());

      case PageConstants.locationSearchScreen:
        return materialPageRoute(widget: SearchLocation());

      case PageConstants.drawRouteScreen:
        return materialPageRoute(widget: DrawRoutesScreen());

    // Corrected route to return the ChatBotPage widget, not ChatBotData.
      case PageConstants.chatbot:
        return materialPageRoute(widget: ChatBotPage()); // Use the widget for chatbot

      case PageConstants.destinationScreen:
        return materialPageRoute(widget: SearchDestination());

      case PageConstants.search:
        if (args is Map<String, dynamic>) {
          return materialPageRoute(
            widget: BookingSuccessfully(
              pickupLocation: args['pickupLocation'] as String,
              destinationLocation: args['destinationLocation'] as String,
              price: args['price'] as double,
            ),
          );
        } else {
          return materialPageRoute(widget: ErrorScreen());
        }

      case PageConstants.completed:
        return materialPageRoute(widget: BookingCompleted());

      case PageConstants.elderly:
        return materialPageRoute(widget: ElderlySection());

      case PageConstants.women:
        return materialPageRoute(widget: WomenSection());

      case PageConstants.handicapped:
        return materialPageRoute(widget: HandicappedSection());

      case PageConstants.rent:
        return materialPageRoute(widget: RentalSection());

      case PageConstants.book:
        if (args is Map<String, dynamic>) {
          return materialPageRoute(
            widget: BookingSection(
              pickupLocation: args['pickupLocation'],
              destinationLocation: args['destinationLocation'],
              price: args['price'],
              pickupLatLng: args['pickupLatLng'] ?? LatLng(0.0, 0.0),
              destinationLatLng: args['destinationLatLng'] ?? LatLng(0.0, 0.0),
            ),
          );
        } else {
          return materialPageRoute(widget: ErrorScreen());
        }

      default:
        return materialPageRoute(widget: ErrorScreen());
    }
  }
}

// Helper function for creating MaterialPageRoute
MaterialPageRoute materialPageRoute({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}
