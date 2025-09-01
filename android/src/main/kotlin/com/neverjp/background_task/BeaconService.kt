package com.neverjp.background_task

import android.annotation.SuppressLint
import android.app.Notification
import android.app.Service
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.os.*
import android.util.Log
import androidx.annotation.RequiresApi
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.neverjp.background_task.lib.ChannelName
import com.neverjp.background_task.lib.MonitorState
import com.neverjp.background_task.lib.ServiceEvents
import com.neverjp.background_task.lib.StatusEventStreamHandler
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.embedding.engine.loader.FlutterLoader
import io.flutter.plugin.common.MethodChannel
import io.flutter.view.FlutterCallbackInformation
import org.altbeacon.beacon.*

private lateinit var broadcastReceiver: BroadcastReceiver

class BeaconService: Service()  {
    private val binder = LocalBinder()
    private lateinit var pref: SharedPreferences
    private var beaconManager: BeaconManager? = null
    private var serviceHandler: Handler? = null
    private var methodChannel: MethodChannel? = null
    private var region: Region? = null
    private var looper: Looper? = null

    //シングルトン
    companion object {
        var isRunning: Boolean = false
            private set

        private val _beaconLiveData = MutableLiveData<HashMap<String, Any?>>()
        val beaconLiveData: LiveData<HashMap<String, Any?>> = _beaconLiveData

        val statusLiveData = MutableLiveData<String>()

        const val UNIQUE_ID = "iBeacon-1"
        const val CHANNEL_ID = "foreground_service"
        const val TAG = "beacon_receiver_nex"
        const val IBEACON_FORMAT = "m:2-3=0215,i:4-19,i:20-21,i:22-23,p:24-24"
        var UUID = "D30A3941-35F9-D31A-215B-1EACF2DADB8B"

        const val distanceFilterKey = "distanceFilter"
        const val callbackDispatcherRawHandleKey = "callbackDispatcherRawHandle"
        const val callbackHandlerRawHandleKey = "callbackHandlerRawHandle"
        const val isEnabledEvenIfKilledKey = "isEnabledEvenIfKilled"

        const val PREF_FILE_NAME = "BACKGROUND_TASK"
        
        var NOTIFICATION_TITLE = "Background task is running"
        var NOTIFICATION_MESSAGE = "Background task is running"
        var NOTIFICATION_ICON = "@mipmap/ic_launcher"
    }

    @RequiresApi(Build.VERSION_CODES.O)
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        super.onStartCommand(intent, flags, startId)

        UUID = intent!!.getStringExtra("uuid")!!
        looper = Looper.myLooper()
        pref = applicationContext.getSharedPreferences(PREF_FILE_NAME, Context.MODE_PRIVATE)
        //ビーコンの取得処理を開始
        startBeaconMonitor()
        
        isRunning = true
        statusLiveData.value = StatusEventStreamHandler.StatusType.Start.value
        return START_STICKY
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun startBeaconMonitor(){
        if(beaconManager == null){
            //ビーコンマネージャーのインスタンス生成
            beaconManager = BeaconManager.getInstanceForApplication(applicationContext)
        }

        //iBeacon用のパーサーをセット
        beaconManager!!.beaconParsers.add(BeaconParser().setBeaconLayout(IBEACON_FORMAT))

        //ハンドラーの初期化(実行しないとFlutter側の処理を呼び出せない)
        initHandler()
        //取得対象となるUUIDを用意
        val uuid: Identifier = Identifier.parse(UUID)
        region = Region(UNIQUE_ID, uuid, null, null)
        //フォアグラウンドサービス通知の設定
        val builder = Notification.Builder(applicationContext, CHANNEL_ID)
        builder.setContentTitle("Scanning for Beacons")
        //フォアグラウンドサービス用の処理を実行
        beaconManager!!.enableForegroundServiceScanning(builder.build(), 456)
        beaconManager!!.setEnableScheduledScanJobs(false)
        beaconManager!!.backgroundBetweenScanPeriod = 0
        beaconManager!!.backgroundScanPeriod = 1100

        //ビーコン取得時の処理をセット
        beaconManager!!.addMonitorNotifier(monitorNotifier)
//        beaconManager!!.addRangeNotifier(rangeNotifier)
        //ビーコン取得処理の開始
        beaconManager!!.startMonitoring(this@BeaconService.region!!)
    }

    //リージョン監視イベント
    private val monitorNotifier = object: MonitorNotifier {
        //ビーコンの入を検知
        override fun didEnterRegion(region: Region?) {
            Log.d(TAG, "didEnterRegion region:$region")
            sendData(ServiceEvents.Monitor, hashMapOf(
                "state" to MonitorState.Enter.id,
                "region" to region.toString()
            ))
        }
        //ビーコンの出を検知
        override fun didExitRegion(region: Region?) {
            Log.d(TAG, "didExitRegion region:$region")
            sendData(ServiceEvents.Monitor, hashMapOf(
                "state" to MonitorState.Exit.id,
                "region" to region.toString()
            ))
        }
        //ビーコンの入出状態が変更されたことを検知
        override fun didDetermineStateForRegion(state: Int, region: Region?) {
            Log.d(TAG, "didDetermineStateForRegion state:$state region:$region")
            sendData(ServiceEvents.Monitor, hashMapOf(
                "state" to state,
                "region" to region.toString()
            ))
        }
    }


    //レージングイベント
    private val rangeNotifier = RangeNotifier { collection, region ->
        Log.d(TAG, "rangeNotifier(collection:${collection}, region:${region} )")
        try{
            if (collection.isNotEmpty()) {
                //対象のビーコン情報が存在する場合
                val result = mutableListOf<Map<String, String>>()
                //ビーコン情報を格納
                for (beacon in collection) {
                    val tmpmap = mutableMapOf<String, String>()
                    tmpmap["UUID"] = beacon.id1.toString()
                    tmpmap["major"] = beacon.id2.toString()
                    tmpmap["minor"] = beacon.id3.toString()
                    tmpmap["Distance"] = beacon.distance.toString()
                    tmpmap["RSSI"] = beacon.rssi.toString()
                    tmpmap["TxPower"] = beacon.txPower.toString()
                    result.add(tmpmap)
                    Log.d(TAG, tmpmap.toString())
                }

                sendData(ServiceEvents.Range, hashMapOf(
                    "Beacon" to result[0],
                    "region" to region.toString()
                ))
            }
        }catch (e : Exception){
            Log.d(TAG, e.toString())
        }
    }


    private fun initHandler(){
        //ハンドラーを開始
        val handlerThread = HandlerThread(TAG)
        handlerThread.start()
        serviceHandler = Handler(handlerThread.looper)

        //コールバックを実行できるように準備
        pref.getLong(callbackDispatcherRawHandleKey, 0).also { callbackHandle ->
            Log.d(TAG, "onStartCommand callbackHandle: $callbackHandle")
            if (callbackHandle == 0.toLong()) {
                return@also
            }

            // ネイティブシステムを起動
            val flutterLoader = FlutterLoader().apply {
                startInitialization(applicationContext)
                ensureInitializationComplete(applicationContext, arrayOf())
            }
            // コールバック関数を取得
            val callbackInfo = FlutterCallbackInformation.lookupCallbackInformation(callbackHandle)
            val dartCallback = DartExecutor.DartCallback(
                applicationContext.assets,
                flutterLoader.findAppBundlePath(),
                callbackInfo
            )
            // コールバックを実行
            val engine = FlutterEngine(applicationContext).apply {
                dartExecutor.executeDartCallback(dartCallback)
            }

            // メソッドチャンネル設定
            methodChannel = MethodChannel(engine.dartExecutor, ChannelName.METHODS.value)
        }
    }

    override fun onBind(intent: Intent?): IBinder {
        return binder
    }

    override fun onDestroy() {
        super.onDestroy()
        isRunning = false

        try {
            beaconManager?.stopMonitoring(region!!)
            beaconManager?.removeMonitorNotifier(monitorNotifier)
            statusLiveData.value = StatusEventStreamHandler.StatusType.Stop.value
        } catch (unlikely: SecurityException) {
            Log.e(TAG, "$unlikely")
        }
    }

    inner class LocalBinder : Binder() {
        internal val service: BeaconService
            get() = this@BeaconService
    }

    //データをFlutterのHandlerに送信
    private fun sendData(event: ServiceEvents, value:HashMap<String, Any?>){
        pref.getLong(callbackHandlerRawHandleKey, 0).also {
            if (it != 0.toLong() && looper != null) {
                val args = HashMap<String, Any?>()
                args["callbackHandlerRawHandle"] = it
                args["data"] = value

                Handler(looper!!).post {
                    methodChannel!!.invokeMethod(event.code, args)
                    if(event == ServiceEvents.Monitor){
                        _beaconLiveData.value = value
                    }
                }
            }
        }
    }
}