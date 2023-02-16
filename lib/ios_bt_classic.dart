import 'package:flutter/services.dart';
import 'package:ios_bt_classic/accesory.dart';

abstract class IosBleClassic {
  Future<String?> getPlatformVersion();

  Future<List<Accesory>> getAccesoryList();

  Future<bool> showClassicPicker();

  Stream<bool> get didConnectStream;

  Stream<Accesory> get didDeviceStream;
}

class IosBleClassicImpl extends IosBleClassic {
  // シングルトン化
  static IosBleClassicImpl? _instance;
  IosBleClassicImpl._internal();

  static IosBleClassicImpl get instance {
    _instance ??= IosBleClassicImpl._internal();
    return _instance!;
  }

  static const _didConnectChannel = EventChannel("com.example/did_connect");
  static const _didDeviceChannel = EventChannel("com.example/did_device");

  final IosBTClassicAPI _api = IosBTClassicAPI();

  @override
  Future<String?> getPlatformVersion() async {
    return await _api.getPlatformVersion();
  }

  Future<bool> registerPlugin() async {
    return await _api.regsterPlugin();
  }

  Future<bool> unRegisterPlugin() async {
    return await _api.unRegsterPlugin();
  }

  @override
  Future<List<Accesory>> getAccesoryList() async {
    final temp = await _api.getBTClassicList();
    return temp.isNotEmpty ? temp.map((e) => e!).toList() : [];
  }

  @override
  Future<bool> showClassicPicker() async {
    return await _api.showClassicPicker();
  }

  @override
  Stream<bool> get didConnectStream {
    return _didConnectChannel
        .receiveBroadcastStream()
        .map((event) => event as bool);
  }

  @override
  Stream<Accesory> get didDeviceStream {
    return _didDeviceChannel.receiveBroadcastStream().map(
          (event) => event as Accesory,
        );
  }
}
