package com.hodoan.keyboard_action

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.content.Intent
import android.graphics.PixelFormat
import android.graphics.Rect
import android.net.Uri
import android.os.Build
import android.os.Looper
import android.provider.Settings
import android.util.Log
import android.view.*
import android.widget.ImageButton
import android.widget.TextView
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
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
    private var viewToolBar: View? = null
    private var windowManager: WindowManager? = null
    private lateinit var context: Context
    private lateinit var activity: Activity

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "keyboard_action")
        EventChannel(
            flutterPluginBinding.binaryMessenger,
            "keyboard_action_event"
        ).setStreamHandler(
            keyEvent
        )
        context = flutterPluginBinding.applicationContext
        windowManager =
            flutterPluginBinding.applicationContext.getSystemService(Context.WINDOW_SERVICE) as WindowManager?
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
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (!Settings.canDrawOverlays(context)) {
                val intent = Intent(
                    Settings.ACTION_MANAGE_OVERLAY_PERMISSION,
                    Uri.parse("package:" + activity.packageName)
                )
                activity.startActivityForResult(intent, 0)
            }
        }

        val r = Rect()
        mainView?.let {
            it.getWindowVisibleDisplayFrame(r)

            val size = ViewCompat.getRootWindowInsets(it.rootView)
            val heightBottom = size?.getInsets(WindowInsetsCompat.Type.ime())?.bottom ?: 0
            val bottom = r.bottom - r.height()
            val keyboardHeight = heightBottom - bottom

            val screenHeight = it.rootView.height
            val keyPadHeight = screenHeight - r.bottom
            val newState = keyPadHeight > screenHeight * .15
            if (newState) {
                if (viewToolBar != null) {
                    viewToolBar?.let { view ->
                        windowManager?.removeView(view)
                    }
                    viewToolBar = null
                }
                @Suppress("DEPRECATION")
                val layout = WindowManager.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.WRAP_CONTENT,
                    if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O)
                        WindowManager.LayoutParams.TYPE_SYSTEM_OVERLAY else
                        WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY,
                    WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE,
                    PixelFormat.TRANSLUCENT,
                )
                layout.gravity = Gravity.BOTTOM or Gravity.LEFT
                val linearLayout =
                    LayoutInflater.from(context).inflate(R.layout.keyboard_action, null)
                val doneBtn: TextView = linearLayout.findViewById(R.id.done)
                doneBtn.setOnClickListener {
                    keyEvent.success(ProtobufModel.ActionKeyboard.done)
//                    val imm: InputMethodManager? =
//                        activity.getSystemService(INPUT_METHOD_SERVICE) as InputMethodManager?
//                    imm?.hideSoftInputFromWindow(activity.currentFocus?.windowToken, 0)
                }
                val btnDown: ImageButton = linearLayout.findViewById(R.id.down)
                btnDown.setOnClickListener {
                    keyEvent.success(ProtobufModel.ActionKeyboard.down)
                }
                val btnUp: ImageButton = linearLayout.findViewById(R.id.up)
                btnUp.setOnClickListener {
                    keyEvent.success(ProtobufModel.ActionKeyboard.up)
                }
                viewToolBar = linearLayout
                windowManager?.addView(viewToolBar, layout)
                viewToolBar?.setPadding(0, 0, 0, keyboardHeight)
            } else {
                viewToolBar?.let { view ->
                    windowManager?.removeView(view)
                }
                viewToolBar = null
            }
        }
    }

    private fun unRegisterListener() {
        mainView?.viewTreeObserver?.removeOnGlobalLayoutListener(this)
        mainView = null
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
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

    fun success(value: ProtobufModel.ActionKeyboard) {
        android.os.Handler(Looper.getMainLooper()).post { sink?.success(value.ordinal) }
    }
}