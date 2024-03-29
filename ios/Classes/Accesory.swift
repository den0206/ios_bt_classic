// Autogenerated from Pigeon (v9.2.4), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation
#if os(iOS)
import Flutter
#elseif os(macOS)
import FlutterMacOS
#else
#error("Unsupported platform.")
#endif

private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)"
  ]
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return (value as Any) as! T?
}

/// Generated class from Pigeon that represents data sent in messages.
struct Accesory {
  var isConnected: Bool
  var connectionID: Int64
  var name: String
  var manufacturer: String
  var modelNumber: String
  var serialNumber: String
  var firmwareRevision: String
  var hardwareRevision: String
  var protocolStrings: [String?]

  static func fromList(_ list: [Any]) -> Accesory? {
    let isConnected = list[0] as! Bool
    let connectionID = list[1] is Int64 ? list[1] as! Int64 : Int64(list[1] as! Int32)
    let name = list[2] as! String
    let manufacturer = list[3] as! String
    let modelNumber = list[4] as! String
    let serialNumber = list[5] as! String
    let firmwareRevision = list[6] as! String
    let hardwareRevision = list[7] as! String
    let protocolStrings = list[8] as! [String?]

    return Accesory(
      isConnected: isConnected,
      connectionID: connectionID,
      name: name,
      manufacturer: manufacturer,
      modelNumber: modelNumber,
      serialNumber: serialNumber,
      firmwareRevision: firmwareRevision,
      hardwareRevision: hardwareRevision,
      protocolStrings: protocolStrings
    )
  }
  func toList() -> [Any?] {
    return [
      isConnected,
      connectionID,
      name,
      manufacturer,
      modelNumber,
      serialNumber,
      firmwareRevision,
      hardwareRevision,
      protocolStrings,
    ]
  }
}

private class IosBTClassicAPICodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
      case 128:
        return Accesory.fromList(self.readValue() as! [Any])
      default:
        return super.readValue(ofType: type)
    }
  }
}

private class IosBTClassicAPICodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? Accesory {
      super.writeByte(128)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class IosBTClassicAPICodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return IosBTClassicAPICodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return IosBTClassicAPICodecWriter(data: data)
  }
}

class IosBTClassicAPICodec: FlutterStandardMessageCodec {
  static let shared = IosBTClassicAPICodec(readerWriter: IosBTClassicAPICodecReaderWriter())
}

/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol IosBTClassicAPI {
  func getPlatformVersion(completion: @escaping (Result<String?, Error>) -> Void)
  func regsterPlugin(completion: @escaping (Result<Bool, Error>) -> Void)
  func unRegsterPlugin(completion: @escaping (Result<Bool, Error>) -> Void)
  func getBTClassicList(completion: @escaping (Result<[Accesory], Error>) -> Void)
  func showClassicPicker(completion: @escaping (Result<Bool, Error>) -> Void)
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class IosBTClassicAPISetup {
  /// The codec used by IosBTClassicAPI.
  static var codec: FlutterStandardMessageCodec { IosBTClassicAPICodec.shared }
  /// Sets up an instance of `IosBTClassicAPI` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: IosBTClassicAPI?) {
    let getPlatformVersionChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.IosBTClassicAPI.getPlatformVersion", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      getPlatformVersionChannel.setMessageHandler { _, reply in
        api.getPlatformVersion() { result in
          switch result {
            case .success(let res):
              reply(wrapResult(res))
            case .failure(let error):
              reply(wrapError(error))
          }
        }
      }
    } else {
      getPlatformVersionChannel.setMessageHandler(nil)
    }
    let regsterPluginChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.IosBTClassicAPI.regsterPlugin", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      regsterPluginChannel.setMessageHandler { _, reply in
        api.regsterPlugin() { result in
          switch result {
            case .success(let res):
              reply(wrapResult(res))
            case .failure(let error):
              reply(wrapError(error))
          }
        }
      }
    } else {
      regsterPluginChannel.setMessageHandler(nil)
    }
    let unRegsterPluginChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.IosBTClassicAPI.unRegsterPlugin", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      unRegsterPluginChannel.setMessageHandler { _, reply in
        api.unRegsterPlugin() { result in
          switch result {
            case .success(let res):
              reply(wrapResult(res))
            case .failure(let error):
              reply(wrapError(error))
          }
        }
      }
    } else {
      unRegsterPluginChannel.setMessageHandler(nil)
    }
    let getBTClassicListChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.IosBTClassicAPI.getBTClassicList", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      getBTClassicListChannel.setMessageHandler { _, reply in
        api.getBTClassicList() { result in
          switch result {
            case .success(let res):
              reply(wrapResult(res))
            case .failure(let error):
              reply(wrapError(error))
          }
        }
      }
    } else {
      getBTClassicListChannel.setMessageHandler(nil)
    }
    let showClassicPickerChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.IosBTClassicAPI.showClassicPicker", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      showClassicPickerChannel.setMessageHandler { _, reply in
        api.showClassicPicker() { result in
          switch result {
            case .success(let res):
              reply(wrapResult(res))
            case .failure(let error):
              reply(wrapError(error))
          }
        }
      }
    } else {
      showClassicPickerChannel.setMessageHandler(nil)
    }
  }
}
