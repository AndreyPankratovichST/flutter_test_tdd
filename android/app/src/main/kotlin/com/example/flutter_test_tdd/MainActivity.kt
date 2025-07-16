package com.example.flutter_test_tdd

import android.content.BroadcastReceiver
import android.os.Bundle
import android.os.PersistableBundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
//    Example for use custom deep link handler

//    private val DEEP_LINK_CHANNEL = "com.example.flutter_test_tdd/channel"
//    private val DEEP_LINK_EVENT = "com.example.flutter_test_tdd/event"
//    private val METHOD_DEEP_LINK_INIT = "deepLinkInit"
//
//    private var initUrl: String? = null
//    private var urlReceiver: BroadcastReceiver? = null
//
//
//    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//        MethodChannel(
//            flutterEngine.dartExecutor.binaryMessenger,
//            DEEP_LINK_CHANNEL
//        ).setMethodCallHandler { call, result ->
//            if (call.method == METHOD_DEEP_LINK_INIT) {
//                if (initUrl != null) {
//                    result.success(initUrl)
//                }
//            }
//        }
//
//        EventChannel(
//            flutterEngine.dartExecutor.binaryMessenger,
//            DEEP_LINK_EVENT
//        ).setStreamHandler(
//            object : EventChannel.StreamHandler {
//                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
//                    urlReceiver = createChangeReceiver(events)
//                }
//
//                override fun onCancel(arguments: Any?) {
//                    urlReceiver = null
//                }
//            }
//        )
//    }
//
//    fun createChangeReceiver(sink: EventChannel.EventSink?): BroadcastReceiver? =
//        object : BroadcastReceiver() {
//            override fun onReceive(
//                context: android.content.Context?,
//                intent: android.content.Intent
//            ) {
//                val url = intent.dataString
//                if (url != null) {
//                    sink?.success(url)
//                }
//            }
//        }
//
//    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
//        super.onCreate(savedInstanceState, persistentState)
//        val intent = getIntent()
//        initUrl = intent.dataString
//    }
//
//    override fun onNewIntent(intent: android.content.Intent) {
//        super.onNewIntent(intent)
//        if (intent.action == android.content.Intent.ACTION_VIEW) {
//            urlReceiver?.onReceive(applicationContext, intent)
//        }
//    }
}
