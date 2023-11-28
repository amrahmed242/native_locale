import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:native_locale/src/native_locale_platform_interface.dart';

/// An implementation of [NativeLocalePlatform] that uses method channels.
class MethodChannelNativeLocale extends NativeLocalePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('native_locale');

  @override
  Future<bool?> setNativeLocale(Locale locale) async {
    final Map<String, dynamic> args = {
      'languageCode': locale.languageCode,
      'countryCode': locale.countryCode,
    };

    return methodChannel.invokeMethod<bool>('setNativeLocale', args);
  }

  @override
  Future<String?> getNativeLocale() async {
    return methodChannel.invokeMethod<String>('getNativeLocale');
  }
}
