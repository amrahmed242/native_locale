import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:native_locale/src/native_locale_method_channel.dart';

void main() {
  MethodChannelNativeLocale platform = MethodChannelNativeLocale();
  const MethodChannel channel = MethodChannel('native_locale');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'setNativeLocale') {
        return true;
      } else if (methodCall.method == 'getNativeLocale') {
        return 'en';
      } else {
        throw Exception('not implemented');
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('setNativeLocale', () async {
    expect(await platform.setNativeLocale(const Locale('en')), true);
  });
  test('getNativeLocale', () async {
    expect(await platform.getNativeLocale(), 'en');
  });
}
