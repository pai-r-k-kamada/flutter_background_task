import 'dart:async';
import 'dart:io';

import 'package:background_task/background_task.dart';
import 'package:background_task_example/log_page.dart';
import 'package:background_task_example/model/beacon_data.dart';
import 'package:background_task_example/model/isar_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart';

@pragma('vm:entry-point')
void backgroundHandler(Beacon beacon, ServiceEvents event) {
  debugPrint('backgroundHandler: ${DateTime.now()}, $beacon, $event');
  Future(() async {
    await IsarRepository.configure();
    IsarRepository.isar.writeTxnSync(() {
      final beaconData = BeaconData()
        ..uuid = beacon.uuid
        ..major = beacon.major
        ..minor = beacon.minor
        ..distance = beacon.distance
        ..rssi = beacon.rssi
        ..txpower = beacon.txpower
        ..proximity = beacon.proximity?.name
        ..monitorState = beacon.monitorState?.name;
      IsarRepository.isar.beaconDatas.putSync(beaconData);
    });
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BackgroundTask.instance.setBackgroundHandler(backgroundHandler);
  await IsarRepository.configure();
  await initializeDateFormatting('ja_JP');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String _bgText = 'no start';
  String _statusText = 'status';
  bool _isEnabledEvenIfKilled = true;
  String _beaconUuid = 'D30A3941-35F9-D31A-215B-1EACF2DADB8B';

  late final StreamSubscription<Map<String, dynamic>> _bgDisposer;
  late final StreamSubscription<StatusEvent> _statusDisposer;

  @override
  void initState() {
    super.initState();

    _bgDisposer = BackgroundTask.instance.beacon.listen((event) {
      final message = '${DateTime.now()}: '
          'Region:${event['region']}, State:${event['state']}';
      debugPrint(message);
      setState(() {
        _bgText = message;
      });
    });

    Future(() async {
      final result = await Permission.notification.request();
      debugPrint('notification: $result');
      if (Platform.isAndroid) {
        if (result.isGranted) {
          await BackgroundTask.instance.setAndroidNotification(
            title: 'Beacon監視中',
            message: 'バックグラウンドでBeaconを監視しています',
          );
        }
      }
    });

    _statusDisposer = BackgroundTask.instance.status.listen((event) {
      final message =
          'status: ${event.status.value}, message: ${event.message}';
      setState(() {
        _statusText = message;
      });
    });
  }

  @override
  void dispose() {
    _bgDisposer.cancel();
    _statusDisposer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beacon Monitor Example'),
        actions: [
          IconButton(
            onPressed: () {
              LogPage.show(context);
            },
            icon: const Icon(Icons.bluetooth_searching),
            iconSize: 32,
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _bgText,
                  textAlign: TextAlign.center,
                ),
                Text(
                  _statusText,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Beacon UUID',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _beaconUuid = value;
                    });
                  },
                  controller: TextEditingController(text: _beaconUuid),
                ),
              ],
            ),
          ),
        ),
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Monitor even if killed',
                        ),
                        WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: CupertinoSwitch(
                              value: _isEnabledEvenIfKilled,
                              onChanged: (value) {
                                setState(() {
                                  _isEnabledEvenIfKilled = value;
                                });
                              },
                            ),
                          ),
                          alignment: PlaceholderAlignment.middle,
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: FilledButton(
                    onPressed: () async {
                      final status = await Permission.location.request();
                      final statusAlways =
                          await Permission.locationAlways.request();

                      if (status.isGranted && statusAlways.isGranted) {
                        await BackgroundTask.instance.startBeacon(
                          _beaconUuid,
                          isEnabledEvenIfKilled: _isEnabledEvenIfKilled,
                        );
                        setState(() {
                          _bgText = 'Beacon monitoring started';
                        });
                      } else {
                        setState(() {
                          _bgText = 'Permission is not granted.\n'
                              'location: $status\n'
                              'locationAlways: $statusAlways';
                        });
                      }
                    },
                    child: const Text('Start'),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: FilledButton(
                    onPressed: () async {
                      await BackgroundTask.instance.stopBeacon();
                      setState(() {
                        _bgText = 'Beacon monitoring stopped';
                      });
                    },
                    child: const Text('Stop'),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Builder(
                    builder: (context) {
                      return FilledButton(
                        onPressed: () async {
                          final isRunning =
                              await BackgroundTask.instance.isRunning;
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('isRunning: $isRunning'),
                                action: SnackBarAction(
                                  label: 'close',
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                  },
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text('isRunning'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
