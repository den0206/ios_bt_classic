//
//  Connector.swift
//  ios_bt_classic
//
//  Created by sakai on 2023/02/15.
//

import Foundation
import Flutter
import ExternalAccessory

public protocol Connector {
    var onDidConnectListener: OnDidConnectListener? { get set }
    var onDidDeviceListener: OnDidDeviceListener? { get set }
}

public class ConnectorImpl: NSObject, Connector {
    public var onDidConnectListener: OnDidConnectListener?
    public var onDidDeviceListener: OnDidDeviceListener?
    private override init() {}
    static let instance = ConnectorImpl()
}


public protocol OnDidConnectListener: NSObjectProtocol, FlutterStreamHandler {
  func onDidConnect(_ isConnected: Bool)
}

public class OnDidConnectListenerImpl: NSObject, OnDidConnectListener {
  public static let CHANNEL_NAME: String = "com.example/did_connect"
  public var eventSink: FlutterEventSink?

  public func onDidConnect(_ isConnected: Bool) {
    eventSink?(isConnected)
  }

  public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    eventSink = events
    return nil
  }

  public func onCancel(withArguments arguments: Any?) -> FlutterError? {
    eventSink = nil
    return nil
  }
}



public protocol OnDidDeviceListener: NSObjectProtocol, FlutterStreamHandler {
  func onDidDeviceConnect(_ device: Accesory)
}

public class OnDidDeviceListenerImpl: NSObject, OnDidDeviceListener {
  public static let CHANNEL_NAME: String = "com.example/did_device"
  public var eventSink: FlutterEventSink?

  public func onDidDeviceConnect(_ device: Accesory) {
    eventSink?(device)
  }

  public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    eventSink = events
    return nil
  }

  public func onCancel(withArguments arguments: Any?) -> FlutterError? {
    eventSink = nil
    return nil
  }
}
