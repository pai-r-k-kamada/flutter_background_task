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
          
          // イベントタイプの取得
          final eventName = json['event'] as String?;
          final event = ServiceEvents.values.firstWhere(
            (e) => e.name == eventName, 
            orElse: () => ServiceEvents.Location
          );
          
          // 位置データの処理
          Location? locationData;
          final locationJson = json['locationData'] as Map<String, dynamic>?;
          if (locationJson != null) {
            locationData = (
              lat: locationJson['lat'] as double?,
              lng: locationJson['lng'] as double?,
            );
          }
          
          // ビーコンデータの処理
          Beacon? beaconData;
          final beaconJson = json['beaconData'] as Map<String, dynamic>?;
          if (beaconJson != null) {
            beaconData = (
              uuid: beaconJson['region']?.toString(),
              major: null,
              minor: null,
              proximity: null,
              distance: null,
              rssi: null,
              txpower: null,
              timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
              monitorState: MonitorState.values.firstWhere(
                (state) => state.id == (beaconJson['state'] as int? ?? 0),
                orElse: () => MonitorState.Exit
              )
            );
          }
          
          callback?.call(locationData, beaconData, event);
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
