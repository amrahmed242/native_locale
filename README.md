# native locale

A flutter plugin for getting and changing the native platform locale. 

## Getting Started

Add this to your package's `pubspec.yaml` file:
```
...
dependencies:
  native_locale:
```

Now in your Dart code, you can use:
```
import 'package:native_locale/native_locale.dart';
```

## Usage
To get the locale of the platform simply run the following command:

```
await NativeLocale().getNativeLocale()
```

To set the locale of the platform run the following command:
```
await NativeLocale().setNativeLocale(const Locale('en'))
```