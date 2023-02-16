import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ios_bt_classic/ios_bt_classic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _iosBtClassicPlugin = IosBleClassicImpl.instance;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;

    try {
      platformVersion = await _iosBtClassicPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Running on: $_platformVersion\n'),
                ElevatedButton(
                  child: const Text("Show Picker"),
                  onPressed: () async {
                    await _iosBtClassicPlugin.showClassicPicker();
                  },
                ),
                ElevatedButton(
                  child: const Text("Get List"),
                  onPressed: () async {
                    final temp = await _iosBtClassicPlugin.getAccesoryList();
                    print(temp);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
