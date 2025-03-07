import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return const FirebaseOptions(
        apiKey: 'AIzaSyAliEQsE7HXExCDUpvryQgSTFZLAgfWhVI', // Your Web API key
        appId: '1:499492018321:web:daee2dd9c8f6ac9bb84730', // Your Web App ID
        messagingSenderId: '499492018321', // Your Messaging Sender ID
        projectId: 'flood-rescue-app', // Your Project ID
        authDomain: 'flood-rescue-app.firebaseapp.com', // Auth Domain for web
        storageBucket: 'flood-rescue-app.appspot.com', // Storage Bucket for web
        measurementId: 'G-RP42T3T43Z', // Measurement ID for analytics (optional)
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return const FirebaseOptions(
        apiKey: 'AIzaSyAliEQsE7HXExCDUpvryQgSTFZLAgfWhVI', // Your iOS API key
        appId: '1:499492018321:ios:3b279dae418cc5f8b84730', // Your iOS App ID
        messagingSenderId: '499492018321', // Your Messaging Sender ID
        projectId: 'flood-rescue-app', // Your Project ID
        iosBundleId: 'com.example.floodRescueApp', // Your iOS Bundle ID
      );
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return const FirebaseOptions(
        apiKey: 'AIzaSyAliEQsE7HXExCDUpvryQgSTFZLAgfWhVI', // Your Android API key
        appId: '1:499492018321:android:99ee8acfc7b0b03db84730', // Your Android App ID
        messagingSenderId: '499492018321', // Your Messaging Sender ID
        projectId: 'flood-rescue-app', // Your Project ID
        androidClientId: 'YOUR_ANDROID_CLIENT_ID', // Your Android Client ID (if applicable)
      );
    }
    throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
  }
}
