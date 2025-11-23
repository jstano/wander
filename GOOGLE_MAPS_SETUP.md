# Google Maps Setup Guide for WanderBooks

## Step 1: Add Dependencies

Add to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  google_maps_flutter: ^2.5.0
  geolocator: ^10.1.0  # For user location
  geocoding: ^2.1.1     # For address search
```

Run: `flutter pub get`

## Step 2: Configure Android

### android/app/src/main/AndroidManifest.xml

Add inside the `<application>` tag:

```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_ANDROID_API_KEY"/>
```

Add permissions before `<application>`:

```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.INTERNET"/>
```

### android/app/build.gradle

Set minimum SDK version to 21:

```gradle
android {
    defaultConfig {
        minSdkVersion 21
    }
}
```

## Step 3: Configure iOS

### ios/Runner/AppDelegate.swift

Add import and setup:

```swift
import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("YOUR_IOS_API_KEY")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

### ios/Runner/Info.plist

Add location permissions:

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs access to location to show nearby books.</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>This app needs access to location to show nearby books.</string>
```

## Step 4: Get Google Maps API Key

1. Go to: https://console.cloud.google.com/
2. Create a new project or select existing one
3. Enable these APIs:
   - Maps SDK for Android
   - Maps SDK for iOS
   - Geocoding API (for search)
4. Go to Credentials → Create Credentials → API Key
5. Restrict your API keys for security

## Step 5: Request Location Permissions

Add this helper class to handle permissions:

```dart
import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition();
  }
}
```

## Features Included

✅ Interactive map with markers
✅ Multiple map types (normal/satellite)
✅ Location search
✅ Add new book locations
✅ Custom marker info windows
✅ My location button
✅ Zoom controls
✅ Marker clustering (ready to implement)

## Next Steps

1. Connect markers to your actual book database
2. Implement real-time location updates
3. Add marker clustering for many books
4. Implement geocoding for address search
5. Add custom marker icons
6. Filter books by category on map
