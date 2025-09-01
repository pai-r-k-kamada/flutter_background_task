import 'dart:async';
import 'dart:io';

import 'package:background_task/background_task.dart';
import 'package:background_task_example/log_page.dart';
import 'package:background_task_example/model/isar_repository.dart';
import 'package:background_task_example/model/lat_lng.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

@pragma('vm:entry-point')
void backgroundHandler(Beacon? beacon, ServiceEvents event) {
  debugPrint('backgroundHandler: ${DateTime.now()}, event: ${event.name}');
  debugPrint('  Beacon: $beacon');
  
  Future(() async {
    await IsarRepository.configure();

    if (beacon != null) {
      // ビーコンデータの処理
      debugPrint('Background beacon processing: ${beacon.uuid}');
      // ここでビーコン検出時の処理を実装
      // 例: 通知送信、API呼び出し、データベース保存など
    }
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
  String _beaconUUID = 'D30A3941-35F9-D31A-215B-1EACF2DADB8B';

  late final StreamSubscription<Location> _bgDisposer;
  late final StreamSubscription<StatusEvent> _statusDisposer;
  late final StreamSubscription<Map<String, dynamic>> _beaconDisposer;

  @override
  void initState() {
    super.initState();
    _bgDisposer = BackgroundTask.instance.stream.listen((event) {
      final message = '${DateTime.now()}: ${event.lat}, ${event.lng}';
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
            title: 'バックグラウンド処理',
            message: 'バックグラウンド処理を実行中',
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
      
      // 再起動感知時の処理
      if (event.status == StatusEventType.deviceRebooted) {
        _handleDeviceReboot();
      }
    });

    // ビーコン検出の監視
    _beaconDisposer = BackgroundTask.instance.beacon.listen((beaconData) {
      final message = 'Beacon detected: ${DateTime.now()}\n$beaconData';
      debugPrint(message);
      setState(() {
        _bgText = message;
      });
    });
  }

  // 再起動感知時の処理
  void _handleDeviceReboot() async {
    debugPrint('Device reboot detected! Checking if beacon detection should restart...');
    
    final prefs = await SharedPreferences.getInstance();
    final shouldAutoRestart = prefs.getBool('auto_restart_beacon') ?? false;
    final savedUUID = prefs.getString('beacon_uuid') ?? '';
    
    if (shouldAutoRestart && savedUUID.isNotEmpty) {
      debugPrint('Auto-restarting beacon detection with UUID: $savedUUID');
      
      // ビーコン検出を自動再開
      await BackgroundTask.instance.startBeacon(savedUUID);
      
      setState(() {
        _statusText = '再起動後にビーコン検出を自動復元しました';
        _beaconUUID = savedUUID;
      });
    } else {
      setState(() {
        _statusText = '端末が再起動されました。ビーコン検出の再開が必要です';
      });
    }
  }

  // ビーコン検出設定を保存
  Future<void> _saveBeaconSettings(String uuid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('beacon_uuid', uuid);
    await prefs.setBool('auto_restart_beacon', true);
  }

  // 自動再開設定を削除
  Future<void> _clearBeaconSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('beacon_uuid');
    await prefs.setBool('auto_restart_beacon', false);
  }

  @override
  void dispose() {
    _bgDisposer.cancel();
    _statusDisposer.cancel();
    _beaconDisposer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
        actions: [
          IconButton(
            onPressed: () {
              LogPage.show(context);
            },
            icon: const Icon(Icons.edit_location_alt),
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
                        )
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
                        await BackgroundTask.instance.start(
                          isEnabledEvenIfKilled: _isEnabledEvenIfKilled,
                        );
                        setState(() {
                          _bgText = 'start';
                        });
                      } else {
                        setState(() {
                          _bgText = 'Permission is not isGranted.\n'
                              'location: $status\n'
                              'locationAlways: $status';
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
                      await BackgroundTask.instance.stop();
                      setState(() {
                        _bgText = 'stop';
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
            const SizedBox(height: 8),
            // ビーコン関連のボタン
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: FilledButton(
                    onPressed: () async {
                      final status = await Permission.location.request();
                      final statusAlways =
                          await Permission.locationAlways.request();

                      if (status.isGranted && statusAlways.isGranted) {
                        // ビーコン開始時に設定を保存
                        await _saveBeaconSettings(_beaconUUID);
                        await BackgroundTask.instance.startBeacon(_beaconUUID);
                        setState(() {
                          _bgText = 'Beacon detection started';
                        });
                      } else {
                        setState(() {
                          _bgText = 'Permission is not granted.\n'
                              'location: $status\n'
                              'locationAlways: $statusAlways';
                        });
                      }
                    },
                    child: const Text('Start Beacon'),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: FilledButton(
                    onPressed: () async {
                      await _clearBeaconSettings();
                      await BackgroundTask.instance.stopBeacon();
                      setState(() {
                        _bgText = 'Beacon detection stopped';
                      });
                    },
                    child: const Text('Stop Beacon'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Beacon UUID: $_beaconUUID',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 4),
            Text(
              '端末再起動後の自動復元が有効です',
              style: TextStyle(fontSize: 10, color: Colors.blue[600]),
            ),
          ],
        ),
      ],
    );
  }
}
