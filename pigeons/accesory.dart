import 'package:pigeon/pigeon.dart';

class Accesory {
  final bool isConnected;
  final int connectionID;
  final String name;
  final String manufacturer;
  final String modelNumber;
  final String serialNumber;
  final String firmwareRevision;
  final String hardwareRevision;
  final List<String?> protocolStrings;

  Accesory(
    this.isConnected,
    this.connectionID,
    this.name,
    this.manufacturer,
    this.modelNumber,
    this.serialNumber,
    this.firmwareRevision,
    this.hardwareRevision,
    this.protocolStrings,
  );
}

@HostApi()
abstract class IosBTClassicAPI {
  @async
  String? getPlatformVersion();

  @async
  bool regsterPlugin();

  @async
  bool unRegsterPlugin();

  @async
  List<Accesory> getBTClassicList();

  @async
  bool showClassicPicker();
}
