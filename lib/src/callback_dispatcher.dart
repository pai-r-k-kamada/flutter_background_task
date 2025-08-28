import 'dart:ui';

import 'package:background_task/src/beacon.dart';
import 'package:background_task/src/types.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  WidgetsFlutterBinding.ensureInitialized();
  MethodChannel(ChannelName.methods.value)
    ..setMethodCallHandler((call) async {
      if (call.method == 'notify_callback_dispatcher') {
        // for 2 way handshake
        // debugPrint('notify_callback_dispatcher');
      } else if (call.method == 'background_handler') {
        final json = call.arguments as Map;
        final handle = json['callbackHandlerRawHandle'] as int?;
        if (handle != null) {
          final callback = PluginUtilities.getCallbackFromHandle(
            CallbackHandle.fromRawHandle(handle),
          );
          final data = (
            lat: json['lat'] as double?,
            lng: json['lng'] as double?,
          );
          const beaconInfo = (
            uuid: null as String?,
            major: null as String?,
            minor: null as String?,
            proximity: null as ProximityState?,
            distance: null as String?,
            rssi: null as String?,
            txpower: null as String?,
            timestamp: null as String?,
            monitorState: null as MonitorState?,
          );
          callback?.call(data, beaconInfo, ServiceEvents.Location);
        }
      } else if(call.method == ServiceEvents.Monitor.name){
        final json = call.arguments as Map;
        final handle = json['callbackHandlerRawHandle'] as int?;
        if (handle != null) {
          final callback = PluginUtilities.getCallbackFromHandle(
            CallbackHandle.fromRawHandle(handle),
          );
          final locationInfo = (
            lat: json['lat'] as double?,
            lng: json['lng'] as double?,
          );
          var beaconInfo = (
            uuid: null as String?,
            major: null as String?,
            minor: null as String?,
            proximity: null as ProximityState?,
            distance: null as String?,
            rssi: null as String?,
            txpower: null as String?,
            timestamp: null as String?,
            monitorState: null as MonitorState?,
          );

          final data = json['data'];
          beaconInfo = (
            uuid: null,
            major: null,
            minor: null,
            proximity: null,
            distance: null,
            rssi: null,
            txpower: null,
            timestamp: null,
            monitorState: MonitorState.values.firstWhere((state) => state.id == data['state']) 
          );
          callback?.call(locationInfo, beaconInfo, ServiceEvents.Monitor);
        }
      } else if(call.method == ServiceEvents.Location.name){
        final json = call.arguments as Map;
        final handle = json['callbackHandlerRawHandle'] as int?;
        if (handle != null) {
          final callback = PluginUtilities.getCallbackFromHandle(
            CallbackHandle.fromRawHandle(handle),
          );
          var locationInfo = (
            lat: json['lat'] as double?,
            lng: json['lng'] as double?,
          );
          const beaconInfo = (
            uuid: null as String?,
            major: null as String?,
            minor: null as String?,
            proximity: null as ProximityState?,
            distance: null as String?,
            rssi: null as String?,
            txpower: null as String?,
            timestamp: null as String?,
            monitorState: null as MonitorState?,
          );

          final data = json['data'];
          locationInfo = (
            lat: data['lat'] as double?,
            lng: data['lng'] as double?,
          );
          callback?.call(locationInfo, beaconInfo, ServiceEvents.Location);
        }
      }
    })
    ..invokeMethod('callback_channel_initialized');
}
