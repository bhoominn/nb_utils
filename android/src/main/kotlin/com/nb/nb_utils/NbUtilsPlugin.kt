package com.nb.nb_utils

import android.content.Context
import android.os.Build
import androidx.annotation.NonNull
import androidx.core.content.res.ResourcesCompat

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** NbUtilsPlugin */
class NbUtilsPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel
  private var appContext: Context? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "nb_utils")
    channel.setMethodCallHandler(this)

    appContext = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if (call.method == "isAndroid12Above") {
      result.success(android.os.Build.VERSION.SDK_INT >= 31)
    } else if (call.method == "materialYouColors") {
      result.success(getMaterialYouColours())
    } else {
      result.notImplemented()
    }
  }

  private fun getMaterialYouColours(): Map<String, String>? {
    if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) {
      return null
    }

    return mapOf(
      "system_accent1_50" to android.R.color.system_accent1_50,
      "system_accent1_100" to android.R.color.system_accent1_100,
      "system_accent1_200" to android.R.color.system_accent1_200,
      "system_accent1_300" to android.R.color.system_accent1_300,
      "system_accent1_400" to android.R.color.system_accent1_400,
      "system_accent1_500" to android.R.color.system_accent1_500,
      "system_accent1_600" to android.R.color.system_accent1_600,
    )
      .map { (name, id) ->
        val color = ResourcesCompat.getColor(appContext!!.resources, id, appContext!!.theme)
        val colorHex = Integer.toHexString(color)
        name to colorHex
      }
      .toMap()
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
