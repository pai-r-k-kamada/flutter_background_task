/**
Copyright [2024] [Never Inc.]
Copyright [2019] [Ali Almoullim]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

package com.neverjp.background_task

import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.content.pm.PackageManager
import android.os.Build
import android.util.Log
import androidx.core.app.ActivityCompat
import androidx.annotation.RequiresApi
import androidx.lifecycle.Observer
import com.neverjp.background_task.lib.BeaconEventStreamHandler
import com.neverjp.background_task.lib.ChannelName
import com.neverjp.background_task.lib.StatusEventStreamHandler
import io.flutter.plugin.common.PluginRegistry
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.altbeacon.beacon.Beacon

/** BackgroundTaskPlugin */
class BackgroundTaskPlugin: FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.RequestPermissionsResultListener {

  private var context: Context? = null
  private lateinit var channel : MethodChannel
  private var activity: Activity? = null
  private var statusEventChannel: EventChannel? = null
  private var beaconEventChannel: EventChannel? = null
  private var dispatcherRawHandle: Long? = null
  private var handlerRawHandle: Long? = null
  private val isEnabledEvenIfKilled: Boolean
    get() = pref.getBoolean(BeaconService.isEnabledEvenIfKilledKey, false)
  private val pref: SharedPreferences
    get() =  context!!.getSharedPreferences(BeaconService.PREF_FILE_NAME, Context.MODE_PRIVATE)

  companion object {
    private val TAG = BackgroundTaskPlugin::class.java.simpleName
    private const val REQUEST_PERMISSIONS_REQUEST_CODE = 34
  }

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    val messenger = flutterPluginBinding.binaryMessenger
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(messenger, ChannelName.METHODS.value)
    channel.setMethodCallHandler(this)

    statusEventChannel = EventChannel(messenger, ChannelName.STATUS_EVENT.value)
    statusEventChannel?.setStreamHandler(StatusEventStreamHandler())

    beaconEventChannel = EventChannel(messenger, ChannelName.BEACON_EVENT.value)
    beaconEventChannel?.setStreamHandler(BeaconEventStreamHandler())
  }

  @RequiresApi(Build.VERSION_CODES.O)
  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
        "set_android_notification" -> {
          setAndroidNotification(call.argument("title"),call.argument("message"),call.argument("icon"))
          result.success(true)
        }
        "is_running_background_task" -> {
          result.success(BeaconService.isRunning)
        }
        "callback_channel_initialized" -> {
          channel.invokeMethod("notify_callback_dispatcher", null)
        }
        "set_background_handler" -> {
          dispatcherRawHandle = call.argument<Long>(BeaconService.callbackDispatcherRawHandleKey)
          handlerRawHandle = call.argument<Long>(BeaconService.callbackHandlerRawHandleKey)
          Log.d(TAG, "registered ${call.arguments}")
          result.success(true)
        }
        "start_beacon_task" -> {
          val distanceFilter = call.argument<Double>(BeaconService.distanceFilterKey)
          val isEnabledEvenIfKilled = call.argument<Boolean>("isEnabledEvenIfKilled") ?: false
          val uuid = call.argument<String>("uuid") ?: ""

          pref.edit().apply {
            remove(BeaconService.callbackDispatcherRawHandleKey)
            remove(BeaconService.callbackHandlerRawHandleKey)
            if (dispatcherRawHandle != null && handlerRawHandle != null) {
              putLong(BeaconService.callbackDispatcherRawHandleKey, dispatcherRawHandle ?: 0)
              putLong(BeaconService.callbackHandlerRawHandleKey, handlerRawHandle ?: 0)
            }
            putFloat(BeaconService.distanceFilterKey, distanceFilter?.toFloat() ?: 0.0.toFloat())
            putBoolean(BeaconService.isEnabledEvenIfKilledKey, isEnabledEvenIfKilled)
          }.apply()
          startBeaconService(uuid)
          result.success(true)
        }
        "stop_beacon_task" ->{
          stopBeaconService()
          result.success(true)
        }
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
    binding.addRequestPermissionsResultListener(this)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    this.onDetachedFromActivity()
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    this.onAttachedToActivity(binding)
  }

  override fun onDetachedFromActivity() {
    if (isEnabledEvenIfKilled) {
      BeaconService.statusLiveData.removeObserver(statusObserver)
      BeaconService.beaconLiveData.removeObserver(beaconObserver)
    } else {
      stopBeaconService()
    }
  }

  override fun onRequestPermissionsResult(
    requestCode: Int,
    permissions: Array<out String>,
    grantResults: IntArray
  ): Boolean {
    if (requestCode == REQUEST_PERMISSIONS_REQUEST_CODE) {
      when (PackageManager.PERMISSION_GRANTED) {
          grantResults[0] -> {
            StatusEventStreamHandler.eventSink?.success(
              StatusEventStreamHandler.StatusType.Permission("enabled").value
            )
          }
          else ->  {
            StatusEventStreamHandler.eventSink?.success(
              StatusEventStreamHandler.StatusType.Permission("disabled").value
            )
            Log.d(TAG, "permission is denied")
          }
      }
    }
    return true
  }

  private val statusObserver = Observer<String> {
    StatusEventStreamHandler.eventSink?.success(it)
  }

  private val beaconObserver = Observer<HashMap<String, Any?>> {
    BeaconEventStreamHandler.eventSink?.success(it)
  }

  private fun startBeaconService(uuid: String) {
    if (!checkPermissions()) {
      requestPermissions()
    }

    val intent = Intent(context, BeaconService::class.java)
    context!!.stopService(intent)

    BeaconService.beaconLiveData.observeForever(beaconObserver)
    BeaconService.statusLiveData.observeForever(statusObserver)

    intent.putExtra("uuid", uuid)

    context!!.startService(intent)
  }

  private fun stopBeaconService() {
    val intent = Intent(context, BeaconService::class.java)
    context!!.stopService(intent)
    BeaconService.statusLiveData.value = StatusEventStreamHandler.StatusType.Stop.value
    BeaconService.statusLiveData.removeObserver(statusObserver)
    BeaconService.beaconLiveData.removeObserver(beaconObserver)
  }

  private fun checkPermissions(): Boolean {
    return PackageManager.PERMISSION_GRANTED == ActivityCompat.checkSelfPermission(context!!, Manifest.permission.ACCESS_FINE_LOCATION)
  }

  private fun requestPermissions() {
    activity?.also {
      val shouldProvideRationale = ActivityCompat.shouldShowRequestPermissionRationale(it, Manifest.permission.ACCESS_FINE_LOCATION)
      if (!shouldProvideRationale) {
        ActivityCompat.requestPermissions(it,
          arrayOf(Manifest.permission.ACCESS_FINE_LOCATION),
          REQUEST_PERMISSIONS_REQUEST_CODE)
      }
    }
  }

  private fun setAndroidNotification(title: String?, message: String?, icon: String?) {
    if (title != null) BeaconService.NOTIFICATION_TITLE = title
    if (message != null) BeaconService.NOTIFICATION_MESSAGE = message
    if (icon != null) BeaconService.NOTIFICATION_ICON = icon
  }
}


