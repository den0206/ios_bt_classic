//
//  Connector.swift
//  ios_bt_classic
//
//  Created by sakai on 2023/02/15.
//

import Foundation
import Flutter
import ExternalAccessory

protocol Connector {
    var onDidConnectListener: OnDidConnectListener? { get set }
    var onDidDeviceListener: OnDidDeviceListener? { get set }
}

class ConnectorImpl: NSObject, Connector {
    var onDidConnectListener: OnDidConnectListener?
    var onDidDeviceListener: OnDidDeviceListener?
    private override init() {}
    static let instance = ConnectorImpl()
}


protocol OnDidConnectListener: NSObjectProtocol, FlutterStreamHandler {
    func onDidConnect(_ isConnected: Bool)
}

class OnDidConnectListenerImpl: NSObject, OnDidConnectListener {
    static let CHANNEL_NAME: String = "com.example/did_connect"
    var eventSink: FlutterEventSink?
    
    func onDidConnect(_ isConnected: Bool) {
        eventSink?(isConnected)
    }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
}



protocol OnDidDeviceListener: NSObjectProtocol, FlutterStreamHandler {
    func onDidDeviceConnect(_ device: Accesory)
}

class OnDidDeviceListenerImpl: NSObject, OnDidDeviceListener {
    static let CHANNEL_NAME: String = "com.example/did_device"
    var eventSink: FlutterEventSink?
    
    func onDidDeviceConnect(_ device: Accesory) {
        eventSink?(device)
    }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
}
