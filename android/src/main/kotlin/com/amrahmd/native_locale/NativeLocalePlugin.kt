package com.amrahmd.native_locale

import android.app.Activity
import android.content.Context
import android.content.res.Configuration
import android.content.res.Resources
import android.os.Build
import android.os.LocaleList
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.Locale


/** NativeLocalePlugin */
class NativeLocalePlugin: FlutterPlugin, MethodCallHandler,ActivityAware {
  private lateinit var activity: Activity
  private lateinit var context: Context
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "native_locale")
    channel.setMethodCallHandler(this)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
    context = binding.activity.applicationContext
  }

  override fun onDetachedFromActivityForConfigChanges() {

  }

  override fun onReattachedToActivityForConfigChanges(p0: ActivityPluginBinding) {
  }

  override fun onDetachedFromActivity() {
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "setNativeLocale") {
      val args = call.arguments as Map<*, *>
      result.success(setLocale(args["languageCode"] as String, args["countryCode"] as String))
    } else if (call.method=="getNativeLocale"){
      result.success(getLocale())
    }else {
      result.notImplemented()
    }
  }


  private fun getLocale():String{
    return if (Build.VERSION.SDK_INT>Build.VERSION_CODES.O){
      context.resources.configuration.locales.toString()
    }else{
      context.resources.configuration.locale.toString()
    }
  }

  private fun setLocale(languageCode:String, countryCode:String?):Boolean{
    return try{
      val locale = if (countryCode != null) {
        Locale(languageCode, countryCode)
      } else {
        Locale(languageCode)
      }

      Locale.setDefault(locale)

      val config = Configuration()
      config.apply {
        config.setLayoutDirection(locale)
        if (Build.VERSION.SDK_INT>Build.VERSION_CODES.O){
          config.setLocale(locale)
          val localeList = LocaleList(locale)
          LocaleList.setDefault(localeList)
          config.setLocales(localeList)
        }else{
          config.setLocale(locale)
        }
      }
      activity.resources.configuration.setLocale(locale)
      true
    } catch (e: Exception){
      false
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
