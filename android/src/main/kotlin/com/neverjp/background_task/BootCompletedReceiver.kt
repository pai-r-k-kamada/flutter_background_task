package com.neverjp.background_task

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log

class BootCompletedReceiver : BroadcastReceiver() {
    
    companion object {
        private val TAG = BootCompletedReceiver::class.java.simpleName
    }
    
    override fun onReceive(context: Context, intent: Intent) {
        Log.d(TAG, "Boot completed detected: ${intent.action}")
        
        if (intent.action == Intent.ACTION_BOOT_COMPLETED) {
            // 保存されたビーコン設定があるかチェック
            val pref = context.getSharedPreferences("BACKGROUND_TASK", Context.MODE_PRIVATE)
            val hasBeaconSettings = pref.getBoolean("beacon_auto_start", false)
            val savedUUID = pref.getString("beacon_uuid", "")
            
            Log.d(TAG, "Checking beacon settings: hasSettings=$hasBeaconSettings, uuid=$savedUUID")
            
            if (hasBeaconSettings && !savedUUID.isNullOrEmpty()) {
                // BeaconServiceを起動してビーコン監視を自動開始
                val serviceIntent = Intent(context, BeaconService::class.java)
                serviceIntent.putExtra("uuid", savedUUID)
                serviceIntent.putExtra("auto_start_from_boot", true)
                
                // Android 8.0+ (API 26+) では startForegroundService を使用
                if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
                    context.startForegroundService(serviceIntent)
                } else {
                    context.startService(serviceIntent)
                }
                Log.d(TAG, "BeaconService started automatically after boot with UUID: $savedUUID")
            } else {
                Log.d(TAG, "No beacon auto-start settings found")
            }
        }
    }
}