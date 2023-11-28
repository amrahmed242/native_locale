import 'dart:ui';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'native_locale_method_channel.dart';

abstract class NativeLocalePlatform extends PlatformInterface {
  /// Constructs a NativeLocalePlatform.
  NativeLocalePlatform() : super(token: _token);

  static final Object _token = Object();

  static NativeLocalePlatform _instance = MethodChannelNativeLocale();

  /// The default instance of [NativeLocalePlatform] to use.
  ///
  /// Defaults to [MethodChannelNativeLocale].
  static NativeLocalePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NativeLocalePlatform] when
  /// they register themselves.
  static set instance(NativeLocalePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> setNativeLocale(Locale locale) {
    throw UnimplementedError('setNativeLocale() has not been implemented.');
  }

  Future<String?> getNativeLocale() {
    throw UnimplementedError('getNativeLocale() has not been implemented.');
  }
}
