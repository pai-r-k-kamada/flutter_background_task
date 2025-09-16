import 'package:isar/isar.dart';

part 'beacon_data.g.dart';

@collection
@Name('BeaconData')
class BeaconData {
  Id id = Isar.autoIncrement;
  String? uuid;
  String? major;
  String? minor;
  String? distance;
  String? rssi;
  String? txpower;
  String? proximity;
  String? monitorState;
  @Index()
  DateTime createdAt = DateTime.now();
}
