import 'package:background_task/src/beacon.dart';

/// `StatusEvent` is a type representing a status event.
typedef StatusEvent = ({StatusEventType status, String? message});

/// `BackgroundHandler` is a type for a function that handles beacon events.
typedef BackgroundHandler = void Function(Beacon, ServiceEvents);

/// `StatusEventType` is an enumeration representing the type of status event.
enum StatusEventType {
  start('start'),
  stop('stop'),
  updated('updated'),
  error('error'),
  permission('permission'),
  ;

  const StatusEventType(this.value);
  final String value;
}

/// `DesiredAccuracy` is an enumeration representing
/// the desired accuracy for beacon detection.
enum DesiredAccuracy {
  reduced('reduced'),
  bestForNavigation('bestForNavigation'),
  best('best'),
  ;

  const DesiredAccuracy(this.value);
  final String value;
}

enum ChannelName {
  methods('com.neverjp.background_task/methods'),
  statusEvent('com.neverjp.background_task/statusEvent'),
  beaconEvent('com.neverjp.background_task/beaconEvent'),
  ;

  const ChannelName(this.value);
  final String value;
}

enum ServiceEvents {
  Monitor('monitor_notifier'),
  Range('range_notifier');

  const ServiceEvents(this.name);
  final String name;
}

typedef Beacon = ({
  String? uuid,
  String? major,
  String? minor,
  String? distance,
  String? rssi,
  String? txpower,
  ProximityState? proximity,
  String? timestamp,
  MonitorState? monitorState
});