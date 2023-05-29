package com.hodoan.custom_keyboard_action

import android.annotation.SuppressLint
import android.graphics.Rect
import android.os.Looper
import android.util.Log
import android.view.View
import android.view.ViewTreeObserver
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


/** KeyboardActionPlugin */
class KeyboardActionPlugin : FlutterPlugin, MethodCallHandler,
    ViewTreeObserver.OnGlobalLayoutListener, ActivityAware {
    private lateinit var channel: MethodChannel
    private val keyEvent = KeyboardEvent()
    private var mainView: View? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "custom_keyboard_action")
        EventChannel(
            flutterPluginBinding.binaryMessenger,
            "custom_keyboard_action_event"
        ).setStreamHandler(
            keyEvent
        )
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "initial") {
            result.success(true)
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    @SuppressLint("MissingInflatedId", "InflateParams")
    override fun onGlobalLayout() {
        val r = Rect()
        mainView?.let {
            it.getWindowVisibleDisplayFrame(r)

//            val size = ViewCompat.getRootWindowInsets(it.rootView)
//            val heightBottom = size?.getInsets(WindowInsetsCompat.Type.ime())?.bottom ?: 0
//            val bottom = r.bottom - r.height()
//            val keyboardHeight = heightBottom - bottom

            val screenHeight = it.rootView.height
            val keyPadHeight = screenHeight - r.bottom
            val newState = keyPadHeight > screenHeight * .15
            keyEvent.success(newState)
        }
    }

    private fun unRegisterListener() {
        mainView?.viewTreeObserver?.removeOnGlobalLayoutListener(this)
        mainView = null
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        try {
            mainView = binding.activity.findViewById(android.R.id.content)
            mainView!!.viewTreeObserver.addOnGlobalLayoutListener(this)
        } catch (e: java.lang.Exception) {
            Log.e(KeyboardActionPlugin::class.simpleName, "onActivityCreated: $e")
        }
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    }

    override fun onDetachedFromActivity() {
        unRegisterListener()
    }
}

class KeyboardEvent : EventChannel.StreamHandler {
    private var sink: EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        sink = events
    }

    override fun onCancel(arguments: Any?) {
        sink = null
    }

    fun success(value: Boolean) {
        android.os.Handler(Looper.getMainLooper()).post { sink?.success(value) }
    }
}