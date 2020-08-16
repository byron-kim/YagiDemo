package com.example.yagi_phonecall

import android.os.Bundle
import android.telephony.SmsManager
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine


class MainActivity : FlutterActivity() {
    private val callResult: MethodChannel.Result? = null
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        val permissions = arrayOf<String>("android.permission.SEND_SMS")
        requestPermissions(permissions, 1);

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
                    if (call.method.equals("send")) {
                        val num: String? = call.argument("phone")
                        val msg: String? = call.argument("msg")

                        if (num != null && msg != null) {
                            sendSMS(num, msg, result)
                        }
                    } else {
                        result.notImplemented()
                    }

        }
    }

    private fun sendSMS(phoneNo: String, msg: String, result: MethodChannel.Result) {
        println("phoneNo: " + phoneNo)
        println("msg: " + msg)
        try {
            val smsManager: SmsManager = SmsManager.getDefault()
            smsManager.sendTextMessage(phoneNo, null, msg, null, null)
            result.success("SMS Sent")
        } catch (ex: Exception) {
            ex.printStackTrace()
            result.error("Err", "Sms Not Sent", "")
        }
    }

    companion object {
        private const val CHANNEL = "sendSms"
    }
}
