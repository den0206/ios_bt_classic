import Flutter
import UIKit
import ExternalAccessory

public class IosBtClassicPlugin: NSObject, FlutterPlugin,IosBTClassicAPI {
    
    
    private var sessionController : SessionController!
    private var accessoryList: [EAAccessory] = []
    
    private var connector : Connector = ConnectorImpl.instance
    private let onDidConnectListener: OnDidConnectListener = OnDidConnectListenerImpl()
    private let onDidDeviceListener: OnDidDeviceListener = OnDidDeviceListenerImpl()
    
    private var onDidConnectChannel: FlutterEventChannel?
    private var onDidDeviceChannel: FlutterEventChannel?
    
    init(with registrar: FlutterPluginRegistrar) {
        connector.onDidConnectListener = onDidConnectListener
        connector.onDidDeviceListener = onDidDeviceListener
        
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        
        let messenger : FlutterBinaryMessenger = registrar.messenger()
        
        // pigeons のセットアップ
        let api : IosBTClassicAPI & NSObjectProtocol = IosBtClassicPlugin.init(with: registrar)
        IosBTClassicAPISetup.setUp(binaryMessenger: messenger, api: api)
        
        // Listner
        // 接続のListen
        let plugin = IosBtClassicPlugin(with: registrar)
        plugin.onDidConnectChannel = FlutterEventChannel(
            name: OnDidConnectListenerImpl.CHANNEL_NAME,
            binaryMessenger: registrar.messenger()
        )
        
        plugin.onDidConnectChannel?.setStreamHandler(plugin.onDidConnectListener)
        
        // 端末のListen
        plugin.onDidDeviceChannel = FlutterEventChannel(
            name: OnDidDeviceListenerImpl.CHANNEL_NAME,
            binaryMessenger: registrar.messenger()
        )
        plugin.onDidDeviceChannel?.setStreamHandler(plugin.onDidDeviceListener)
        
        
        // Notification 登録
        NotificationCenter.default.addObserver(self, selector: #selector(_accessoryDidConnect), name: NSNotification.Name.EAAccessoryDidConnect, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(_accessoryDidDisconnect), name: NSNotification.Name.EAAccessoryDidDisconnect, object: nil)
        EAAccessoryManager.shared().registerForLocalNotifications()
        
        
    }
    
    func getPlatformVersion(completion: @escaping (Result<String?, Error>) -> Void) {
        // バージョン取得
        completion(.success("iOS " + UIDevice.current.systemVersion))
    }
    
    
    func regsterPlugin(completion: @escaping (Result<Bool, Error>) -> Void) {
        //        // Notification 登録
        //        NotificationCenter.default.addObserver(self, selector: #selector(_accessoryDidConnect), name: NSNotification.Name.EAAccessoryDidConnect, object: nil)
        //        NotificationCenter.default.addObserver(self, selector: #selector(_accessoryDidDisconnect), name: NSNotification.Name.EAAccessoryDidDisconnect, object: nil)
        //        EAAccessoryManager.shared().registerForLocalNotifications()
        //
        //        sessionController = SessionController.sharedController
        //        accessoryList = EAAccessoryManager.shared().connectedAccessories
        
        sessionController = SessionController.sharedController
        accessoryList = EAAccessoryManager.shared().connectedAccessories
        completion(.success(true))
    }
    
    
    
    func unRegsterPlugin(completion: @escaping (Result<Bool, Error>) -> Void) {
        // Notification 解除
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.EAAccessoryDidConnect, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.EAAccessoryDidDisconnect, object: nil)
        
        EAAccessoryManager.shared().unregisterForLocalNotifications()
        
        accessoryList.removeAll()
        completion(.success(true))
    }
    
    
    func getBTClassicList(completion: @escaping (Result<[Accesory], Error>) -> Void) {
        accessoryList = EAAccessoryManager.shared().connectedAccessories
        
        print(accessoryList)
        var list: [Accesory] = []
        for accesory  in accessoryList {
            let convert =  convertAccesary(ea: accesory)
            list.append(convert)
        }
        completion(.success(list))
    }
    
    
    func showClassicPicker(completion: @escaping (Result<Bool, Error>) -> Void) {
        EAAccessoryManager.shared().showBluetoothAccessoryPicker(withNameFilter: nil) { [weak self] error in
            
            guard let _ = self else { return }
            
            // エラーがない場合
            if (error != nil) { completion(.success(true))}
            
            // エラーがある場合
            if let error = error as NSError? {
                switch EABluetoothAccessoryPickerError(_nsError: error).code {
                case .alreadyConnected:
                    completion(.success(true))
                default:
                    completion(.failure(error))
                }
            }
        }
    }
    
    public func detachFromEngine(for registrar: FlutterPluginRegistrar) {
        
        onDidConnectChannel?.setStreamHandler(nil)
        onDidDeviceChannel?.setStreamHandler(nil)
    }
    
    @objc func _accessoryDidConnect(_ notification: Notification?) {
        let connectedAccessory = notification?.userInfo?[EAAccessoryKey] as? EAAccessory
        
        guard let connectedAccessory  = connectedAccessory else {return}
        accessoryList.append(connectedAccessory)
        onDidConnectListener.onDidConnect(true)
        onDidDeviceListener.onDidDeviceConnect(convertAccesary(ea: connectedAccessory))
        
    }
    
    @objc func _accessoryDidDisconnect(_ notification: Notification?) {
        let disconnectedAccessory = notification?.userInfo?[EAAccessoryKey] as? EAAccessory
        
        let disconnectedAccessoryIndex : Int? = accessoryList.firstIndex { ea in
            ea.connectionID == disconnectedAccessory?.connectionID
        }
        
        guard let disconnectedAccessoryIndex = disconnectedAccessoryIndex else {return}
        if disconnectedAccessoryIndex < accessoryList.count {
            accessoryList.remove(at: disconnectedAccessoryIndex)
            onDidConnectListener.onDidConnect(false)
            onDidDeviceListener.onDidDeviceConnect(convertAccesary(ea: disconnectedAccessory!))
        } else {
            print("📌 could not find disconnected accessory in accessory list")
        }
    }
    
    
    private func convertAccesary(ea:EAAccessory) -> Accesory {
        return Accesory(isConnected: ea.isConnected, connectionID: Int64(ea.connectionID), name: ea.name, manufacturer: ea.manufacturer, modelNumber: ea.modelNumber, serialNumber: ea.serialNumber, firmwareRevision: ea.firmwareRevision, hardwareRevision: ea.hardwareRevision, protocolStrings: ea.protocolStrings)
    }
    
}
