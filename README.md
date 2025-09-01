# background_task

[![never-light-log](./img/logo_blk.png)](https://neverjp.com)

Developed with 💙 by [Never inc](https://neverjp.com/).

---

## Motivation

A Flutter plugin for beacon detection that works in background. This plugin enables developers to monitor iBeacon/BLE beacons even when the application transitions to the background.

Can be used when you want to:

- Detect proximity to beacons in retail stores or museums
- Trigger notifications when entering/exiting beacon regions  
- Track beacon encounters for contact tracing
- Implement location-based services using beacons

## Usage

```dart
// Monitor beacon events in the background.
BackgroundTask.instance.beacon.listen((event) {
  // Handle beacon events
  print('Beacon detected: ${event}');
});

// Start beacon monitoring with specified UUID.
await BackgroundTask.instance.startBeacon('D30A3941-35F9-D31A-215B-1EACF2DADB8B');

// Stop beacon monitoring.
await BackgroundTask.instance.stopBeacon();
```

This implementation works even when the task is killed. The plugin uses foreground services on Android and beacon monitoring on iOS.

```dart
// Define callback handler at the top level.
@pragma('vm:entry-point')
void backgroundHandler(Beacon beacon, ServiceEvents event) {
  // Implement the process you want to run in the background.
  // Handle beacon enter/exit events
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BackgroundTask.instance.setBackgroundHandler(backgroundHandler); // 👈 Set callback handler.
  runApp(const MyApp());
}
```

To monitor beacons in a task-killed status, set location permissions to Always on both iOS and Android.

![ios](./img/ios_location_permission_for_task_kill.png)
![android](./img/android_location_permission_for_task_kill.png)

This is an implementation for when you want to stop beacon monitoring when the application is killed.

```dart
await BackgroundTask.instance.startBeacon(
  'D30A3941-35F9-D31A-215B-1EACF2DADB8B',
  isEnabledEvenIfKilled: false,
);
```

Recommended to use with [permission_handler](https://pub.dev/packages/permission_handler).

```dart
final status = await Permission.location.request();
final statusAlways = await Permission.locationAlways.request();

if (status.isGranted && statusAlways.isGranted) {
  await BackgroundTask.instance.startBeacon('D30A3941-35F9-D31A-215B-1EACF2DADB8B');
}
```

### Setup

pubspec.yaml

```yaml
dependencies:
  background_task:
```

iOS: Info.plist

```xml
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>Used to monitor beacons in the background.</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>Used to monitor beacons in the background.</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>Used to monitor beacons in the background.</string>
<key>UIBackgroundModes</key>
<array>
    <string>fetch</string>
    <string>location</string>
</array>
```

To use an external package (shared_preference etc..) in callback handler, register DispatchEngine in AppDelegate.

iOS: AppDelegate.swift

```swift
import UIKit
import Flutter
import background_task // 👈 Add

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        // 👇 Add
        BackgroundTaskPlugin.onRegisterDispatchEngine = {
            GeneratedPluginRegistrant.register(with: BackgroundTaskPlugin.dispatchEngine)
        }
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

```

Android: AndroidManifest.xml

```xml
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION"/>
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_LOCATION"/>
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
```

## References

- [Executing Dart in the Background with Flutter Plugins and Geofencing](https://medium.com/flutter/executing-dart-in-the-background-with-flutter-plugins-and-geofencing-2b3e40a1a124#56b7)
