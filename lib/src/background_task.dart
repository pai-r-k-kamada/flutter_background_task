import 'dart:io';
import 'dart:ui';

import 'package:flutter/services.dart';

import 'callback_dispatcher.dart';
import 'types.dart';

/// `BackgroundTask` is a class that manages background tasks.
class BackgroundTask {
  BackgroundTask(
    this._methodChannel,
    this._statusEventChannel,
    this._beaconEventChannel,
  );

  /// Get instance
  static BackgroundTask get instance => _instance;

  static final BackgroundTask _instance = BackgroundTask(
    MethodChannel(ChannelName.methods.value),
    EventChannel(ChannelName.statusEvent.value),
    EventChannel(ChannelName.beaconEvent.value),
  );

  final MethodChannel _methodChannel;
  final EventChannel _statusEventChannel;
  final EventChannel _beaconEventChannel;

  /// `setBackgroundHandler` provides a background handler function.
  Future<void> setBackgroundHandler(BackgroundHandler handler) async {
    final callbackDispatcherHandle =
        PluginUtilities.getCallbackHandle(callbackDispatcher);
    final callbackHandler = PluginUtilities.getCallbackHandle(handler);
    if (callbackDispatcherHandle != null && callbackHandler != null) {
      await _methodChannel.invokeMethod<bool>(
        'set_background_handler',
        {
          'callbackDispatcherRawHandle': callbackDispatcherHandle.toRawHandle(),
          'callbackHandlerRawHandle': callbackHandler.toRawHandle(),
        },
      );
    }
  }

  /// `setAndroidNotification` sets the Android notification.
  Future<void> setAndroidNotification({
    String? title,
    String? message,
    String? icon,
  }) async {
    if (Platform.isAndroid) {
      await _methodChannel.invokeMethod<bool>(
        'set_android_notification',
        {
          'title': title,
          'message': message,
          'icon': icon,
        },
      );
    }
  }


  Future<void> startBeacon(
    String uuid,
  {
    double? distanceFilter,
    bool isEnabledEvenIfKilled = true,
    DesiredAccuracy iOSDesiredAccuracy = DesiredAccuracy.bestForNavigation,
  }) async {
    await _methodChannel.invokeMethod<bool>('start_beacon_task',      {
        'uuid': uuid,
        'distanceFilter': distanceFilter,
        'isEnabledEvenIfKilled': isEnabledEvenIfKilled,
        'iOSDesiredAccuracy': iOSDesiredAccuracy.value,
      },);
  }

  Future<void> stopBeacon() async {
    await _methodChannel.invokeMethod<bool>('stop_beacon_task');
  }

  /// `isRunning` returns whether the background task is running or not.
  Future<bool> get isRunning async {
    final result =
        await _methodChannel.invokeMethod<bool>('is_running_background_task');
    return result ?? false;
  }


  /// `status` provides a stream of status events.
  Stream<StatusEvent> get status =>
      _statusEventChannel.receiveBroadcastStream().map((event) {
        final value = (event as String).split(',');
        return (
          status: StatusEventType.values
              .firstWhere((element) => element.value == value[0]),
          message: value.length > 1 ? value[1] : null,
        );
      }).asBroadcastStream();

  /// `beacon` provides a stream of beacon events.
  Stream<Map<String, dynamic>> get beacon =>
      _beaconEventChannel.receiveBroadcastStream().map((event) {
        final Map<String, dynamic> result = Map();
        (event as Map<Object?, Object?>).forEach((key, value) {
          result.addAll({ key.toString(): value });
        });
        return result;
      }).asBroadcastStream();
}
