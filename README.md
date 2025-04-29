# Three-Wheeler Ride Booking App

## Overview
The Three-Wheeler Ride Booking App is a mobile application designed for booking rides in three-wheelers, specifically tailored for elderly, handicapped, and women passengers. The app offers an intuitive user interface and a seamless experience for booking rides, tracking vehicles in real-time, and ensuring safe travel for vulnerable users. The app provides both rider and driver functionalities, allowing passengers to book rides, track the status, and make payments, while drivers can receive ride requests, track their earnings, and manage their trips.

## Features
- **User Authentication**: Secure login and registration system for passengers and drivers.
- **Ride Booking**: Easy ride booking process with options to select pickup and drop-off locations.
- **Real-Time Ride Tracking**: Passengers can track their ride in real-time.
- **Driver Profile Management**: Drivers can manage their profiles and see ride requests.
- **Rating and Feedback**: Passengers can rate drivers and leave feedback for improved service.
- **Admin Panel**: Admin can manage users, rides, and view detailed reports.
- **Special Features**: Focus on elderly, handicapped, and women’s safety with features like emergency contact, location-based alerts, and ride preferences.

## Technologies Used
- **Frontend**: 
  - Flutter (for a cross-platform experience on both Android and iOS)
  - Dart
  
- **Backend**: 
  - Firebase (for user authentication, real-time database, and cloud messaging)
  - Firestore (for managing ride bookings and user data)

- **Additional Tools**: 
  - Google Maps API (for real-time ride tracking and location-based services)
  - Dialogflow (for chat support and ride queries)

## Getting Started

### Prerequisites
To get this project up and running locally, make sure you have the following installed on your machine:
- Flutter (https://flutter.dev/docs/get-started/install)
- Android Studio (or any preferred IDE)
- Firebase account (https://console.firebase.google.com/)
- Google Maps API key (https://developers.google.com/maps/gmp-get-started)

### Setup Instructions

1. **Clone the Repository**:
    ```bash
    git clone https://github.com/your-username/three-wheeler-ride-booking-app.git
    cd three-wheeler-ride-booking-app
    ```

2. **Install Dependencies**:
    In your project directory, run the following command to install the required dependencies:
    ```bash
    flutter pub get
    ```

3. **Set Up Firebase**:
    - Go to the Firebase console and create a new project.
    - Enable Firebase Authentication, Firestore Database, and Firebase Cloud Messaging for your project.
    - Download the `google-services.json` for Android and place it in the `android/app` directory of the project.

4. **Configure Google Maps API**:
    - Obtain a Google Maps API key from the Google Cloud Console.
    - Add the key to your Android project in the `android/app/src/main/AndroidManifest.xml` file:
      ```xml
      <meta-data
          android:name="com.google.android.geo.API_KEY"
          android:value="YOUR_GOOGLE_MAPS_API_KEY"/>
      ```

5. **Run the App**:
    After completing the setup, you can run the app on an emulator or physical device:
    ```bash
    flutter run
    ```

## Folder Structure
The project is organized as follows:

