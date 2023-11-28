import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_locale/native_locale.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _nativeLocale = 'Unknown';
  final _nativeLocalePlugin = NativeLocale();

  @override
  void initState() {
    super.initState();
    initLocaleState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initLocaleState() async {
    String nativeLocale;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      nativeLocale = await NativeLocale().getNativeLocale() ?? 'Unknown locale';
      await NativeLocale().setNativeLocale(const Locale('en')) ??
          'Unknown locale';
    } on PlatformException {
      nativeLocale = 'Failed to get native locale.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _nativeLocale = nativeLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('current native locale is: $_nativeLocale\n'),
        ),
      ),
    );
  }
}
