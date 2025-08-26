package com.neverjp.background_task

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import com.neverjp.background_task.lib.StatusEventStreamHandler

class BootCompletedReceiver : BroadcastReceiver() {
    
    companion object {
        private val TAG = BootCompletedReceiver::class.java.simpleName
    }
    
    override fun onReceive(context: Context, intent: Intent) {
        Log.d(TAG, "Boot completed detected: ${intent.action}")
        
        if (intent.action == Intent.ACTION_BOOT_COMPLETED) {
            // 再起動完了を status チャンネルで通知
            StatusEventStreamHandler.eventSink?.success(
                StatusEventStreamHandler.StatusType.DeviceRebooted("Boot completed detected").value
            )
            Log.d(TAG, "Device reboot notification sent")
        }
    }
}