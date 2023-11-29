# native locale

A flutter plugin for getting and changing the native platform locale. 

## About

Since the flutter localization is completely separate from the localization of the native app, you can face problems of unmatched locales when opening another native view that should be localized.
This plugin helps you change the native localization of the app programmatically from the dart side.


## Platform Support

| Android | iOS |
| :-----: | :-: |
|   ✅   |  [ ] |

## Getting Started

Add this to your package's `pubspec.yaml` file:
```yaml
dependencies:
  native_locale:
```

Now in your Dart code, you can use:
```dart
import 'package:native_locale/native_locale.dart';
```

## Usage
To get the locale of the platform simply run the following command:

```dart
await NativeLocale().getNativeLocale()
```

To set the locale of the platform run the following command:
```dart
await NativeLocale().setNativeLocale(const Locale('en'))
```
