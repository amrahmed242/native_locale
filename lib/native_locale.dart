import 'dart:ui';

import 'native_locale_platform_interface.dart';

class NativeLocale {
  Future<bool?> setNativeLocale(Locale locale) {
    return NativeLocalePlatform.instance.setNativeLocale(locale);
  }

  Future<String?> getNativeLocale() {
    return NativeLocalePlatform.instance.getNativeLocale();
  }
}
