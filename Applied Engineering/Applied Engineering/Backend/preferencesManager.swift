//
//  preferencesManager.swift
//  Applied Engineering
//
//  Created by Richard Wei on 3/14/21.
//

import Foundation

class preferencesManager{
    static public let obj : preferencesManager = preferencesManager();
    
    // List of defaults
    private let d_connectionIPAddress : String = "224.0.0.1";
    private let d_connectionPort : String = "28650";
    private let d_connectionGroup : String = "telemetry";
    private let d_zeromqReceiveReconnectTimeout : Int = 3000; // in ms
    private let d_receiveTimeout : Int = 100; // in ms
    private let d_reconnectTimeout : Int = 3; // seconds
    private let d_graphBufferSize : Int = 60; // number of points
    //
    
    // List of accessible variables
    public let numberOfSettings = 7;
    public let settingsNameArray : [String] = ["Connection IP", "Connection Port", "Connection Group", "ZMQ RCNT (ms)", "RCV Timeout (ms)", "RCNT Timeout (s)", "Graph Point Buffer"];
    
    public var connectionIPAddress : String = "";
    public var connectionPort : String = "";
    public var connectionGroup : String = "";
    public var zeromqReceiveReconnectTimeout : Int = -1;
    public var receiveTimeout : Int = -1;
    public var reconnectTimeout : Int = -1;
    public var graphBufferSize : Int = -1;
    //
    
    private init(){ // load what was saved
        connectionIPAddress = UserDefaults.standard.string(forKey: "connectionIPAddress") ?? d_connectionIPAddress;
        connectionPort = UserDefaults.standard.string(forKey: "connectionPort") ?? d_connectionPort;
        connectionGroup = UserDefaults.standard.string(forKey: "connectionGroup") ?? d_connectionGroup;
        zeromqReceiveReconnectTimeout = UserDefaults.standard.integer(forKey: "zeromqReceiveReconnectTimeout") == 0 ? d_zeromqReceiveReconnectTimeout : UserDefaults.standard.integer(forKey: "zeromqReceiveReconnectTimeout");
        receiveTimeout = UserDefaults.standard.integer(forKey: "receiveTimeout") == 0 ? d_receiveTimeout : UserDefaults.standard.integer(forKey: "receiveTimeout");
        reconnectTimeout = UserDefaults.standard.integer(forKey: "reconnectTimeout") == 0 ? d_reconnectTimeout : UserDefaults.standard.integer(forKey: "reconnectTimeout");
        graphBufferSize = UserDefaults.standard.integer(forKey: "graphBufferSize") == 0 ? d_graphBufferSize : UserDefaults.standard.integer(forKey: "graphBufferSize");
    }
    
    public func resetDefaults(){
        connectionIPAddress = d_connectionIPAddress;
        connectionPort = d_connectionPort;
        connectionGroup = d_connectionGroup;
        zeromqReceiveReconnectTimeout = d_zeromqReceiveReconnectTimeout;
        receiveTimeout = d_receiveTimeout;
        reconnectTimeout = d_reconnectTimeout;
        graphBufferSize = d_graphBufferSize;
        save();
    }
    
    public func save(){
        UserDefaults.standard.setValue(connectionIPAddress, forKey: "connectionIPAddress");
        UserDefaults.standard.setValue(connectionPort, forKey: "connectionPort");
        UserDefaults.standard.setValue(connectionGroup, forKey: "connectionGroup");
        UserDefaults.standard.setValue(zeromqReceiveReconnectTimeout, forKey: "zeromqReceiveReconnectTimeout");
        UserDefaults.standard.setValue(receiveTimeout, forKey: "receiveTimeout");
        UserDefaults.standard.setValue(reconnectTimeout, forKey: "reconnectTimeout");
        UserDefaults.standard.setValue(graphBufferSize, forKey: "graphBufferSize");
    }
    
    public func getStringValueForIndex(_ index: Int) -> String{
        switch index {
        case 0:
            return connectionIPAddress;
        case 1:
            return connectionPort;
        case 2:
            return connectionGroup;
        case 3:
            return String(zeromqReceiveReconnectTimeout);
        case 4:
            return String(receiveTimeout);
        case 5:
            return String(reconnectTimeout);
        case 6:
            return String(graphBufferSize);
        default:
            return "";
        }
    }
    
    public func saveStringValueForIndex(_ index: Int, _ val: String){
        switch index {
        case 0:
            connectionIPAddress = val;
        case 1:
            connectionPort = val;
        case 2:
            connectionGroup = val;
        case 3:
            zeromqReceiveReconnectTimeout = Int(val) ?? d_zeromqReceiveReconnectTimeout;
        case 4:
            receiveTimeout = Int(val) ?? d_receiveTimeout;
        case 5:
            reconnectTimeout = Int(val) ?? d_reconnectTimeout;
        case 6:
            graphBufferSize = Int(val) ?? d_graphBufferSize;
        default:
            print("saveStringValueForIndex recv invalid index");
        }
        save();
    }
    
}