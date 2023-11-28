import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:native_locale/native_locale.dart';
import 'package:native_locale/native_locale_method_channel.dart';
import 'package:native_locale/native_locale_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNativeLocalePlatform
    with MockPlatformInterfaceMixin
    implements NativeLocalePlatform {
  @override
  Future<bool?> setNativeLocale(Locale locale) => Future.value(true);

  @override
  Future<String?> getNativeLocale() => Future.value('en');
}

void main() {
  final NativeLocalePlatform initialPlatform = NativeLocalePlatform.instance;

  test('$MethodChannelNativeLocale is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNativeLocale>());
  });

  test('setNativeLocale', () async {
    NativeLocale nativeLocalePlugin = NativeLocale();
    MockNativeLocalePlatform fakePlatform = MockNativeLocalePlatform();
    NativeLocalePlatform.instance = fakePlatform;
    expect(await nativeLocalePlugin.setNativeLocale(const Locale('en')), true);
  });
  test('getNativeLocale', () async {
    NativeLocale nativeLocalePlugin = NativeLocale();
    MockNativeLocalePlatform fakePlatform = MockNativeLocalePlatform();
    NativeLocalePlatform.instance = fakePlatform;
    expect(await nativeLocalePlugin.getNativeLocale(), 'en');
  });
}
