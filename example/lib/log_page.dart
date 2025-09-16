import 'dart:async';

import 'package:background_task_example/model/beacon_data.dart';
import 'package:background_task_example/model/isar_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

class LogPage extends StatefulWidget {
  const LogPage({super.key});

  static Future<void> show(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push<void>(
      CupertinoPageRoute(
        settings: const RouteSettings(name: 'log_page'),
        builder: (_) => const LogPage(),
      ),
    );
  }

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  List<BeaconData> items = [];
  bool isLoading = false;

  final ScrollController scrollController = ScrollController();
  final int defaultLimit = 20;

  @override
  void initState() {
    onRefresh();
    super.initState();
  }

  Future<void> onRefresh() async {
    final data = await IsarRepository.isar.beaconDatas
        .where()
        .sortByCreatedAtDesc()
        .limit(items.length > defaultLimit ? items.length : defaultLimit)
        .findAll();
    setState(() {
      items = data;
    });
  }

  Future<void> onLoadMore() async {
    final data = await IsarRepository.isar.beaconDatas
        .where()
        .sortByCreatedAtDesc()
        .offset(items.length)
        .limit(defaultLimit)
        .findAll();
    setState(() {
      items = [...items, ...data];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beacon Log'),
        actions: [
          IconButton(
            onPressed: () {
              HapticFeedback.heavyImpact();
              IsarRepository.isar.writeTxnSync(() {
                IsarRepository.isar.beaconDatas.clearSync();
                setState(() {
                  items = [];
                });
              });
            },
            icon: const Icon(Icons.delete),
            iconSize: 32,
          ),
        ],
      ),
      body: NotificationListener<ScrollUpdateNotification>(
        onNotification: (notification) {
          if (items.length >= defaultLimit &&
              notification.metrics.extentAfter == 0) {
            Future(() async {
              if (isLoading) {
                return;
              }
              setState(() {
                isLoading = true;
              });
              try {
                await Future<void>.delayed(const Duration(milliseconds: 1000));
                await onLoadMore();
              } on Exception catch (e) {
                debugPrint(e.toString());
              } finally {
                setState(() {
                  isLoading = false;
                });
              }
            });
          }
          return true;
        },
        child: Scrollbar(
          controller: scrollController,
          child: CustomScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              CupertinoSliverRefreshControl(
                onRefresh: () async {
                  await onRefresh();
                  await Future<void>.delayed(const Duration(milliseconds: 500));
                },
              ),
              SliverMainAxisGroup(
                slivers: [
                  SliverList.separated(
                    itemBuilder: (context, index) {
                      final data = items[index];
                      return ExpansionTile(
                        title: Text(
                          'UUID: ${data.uuid?.substring(0, 8) ?? "N/A"}...',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Major: ${data.major ?? "N/A"}, '
                          'Minor: ${data.minor ?? "N/A"}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        leading: CircleAvatar(
                          child: Text(
                            data.id.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        trailing: Text(
                          DateFormat('M/d H:mm:ss', 'ja_JP')
                              .format(data.createdAt),
                          style: const TextStyle(fontSize: 12),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildDetailRow('UUID', data.uuid ?? 'N/A'),
                                _buildDetailRow('Major', data.major ?? 'N/A'),
                                _buildDetailRow('Minor', data.minor ?? 'N/A'),
                                _buildDetailRow('Distance', data.distance ?? 'N/A'),
                                _buildDetailRow('RSSI', data.rssi ?? 'N/A'),
                                _buildDetailRow('TX Power', data.txpower ?? 'N/A'),
                                _buildDetailRow('Proximity', data.proximity ?? 'N/A'),
                                _buildDetailRow(
                                  'Monitor State',
                                  data.monitorState ?? 'N/A',
                                ),
                                _buildDetailRow(
                                  'Created At',
                                  DateFormat('yyyy/MM/dd HH:mm:ss', 'ja_JP')
                                      .format(data.createdAt),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(height: 1);
                    },
                    itemCount: items.length,
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(top: 16, bottom: 56),
                    sliver: SliverToBoxAdapter(
                      child: Visibility(
                        visible: isLoading,
                        child: const CupertinoActivityIndicator(),
                      ),
                    ),
                  ),
                ],
              ),
              if (items.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16)
                          .copyWith(bottom: 108),
                      child: const Text(
                        'No beacon data',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: SelectableText(
              value,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
