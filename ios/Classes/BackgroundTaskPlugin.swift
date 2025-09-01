/**
Copyright [2024] [Never Inc.]
Copyright [2019] [Ali Almoullim]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import Flutter
import UIKit
import CoreLocation

public class BackgroundTaskPlugin: NSObject, FlutterPlugin, CLLocationManagerDelegate {

    public static let dispatchEngine: FlutterEngine = FlutterEngine(
        name: Bundle.main.bundleIdentifier ?? "background_task",
        project: nil,
        allowHeadlessExecution: true
    )
    public static var onRegisterDispatchEngine: (() -> Void)?
    static var isRegisteredDispatchEngine = false
    
    static var locationManager: CLLocationManager?
    static var channel: FlutterMethodChannel?
    static var statusEventChannel: FlutterEventChannel?
    static var beaconEventChannel: FlutterEventChannel?
    static var isRunning = false
    
    static var dispatchChannel: FlutterMethodChannel?
    static var dispatcherRawHandle: Int?
    static var handlerRawHandle: Int?
    
    static var beaconRegion:CLBeaconRegion?
    static var UUIDList = [
        "D30A3941-35F9-D31A-215B-1EACF2DADB8B"//TODO: デフォルトUUID
    ]
    
    var beacons: [Any] = []
    
    private var isEnabledEvenIfKilled: Bool {
        return UserDefaultsRepository.instance.fetchIsEnabledEvenIfKilled()
    }
    
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = BackgroundTaskPlugin()
        registrar.addApplicationDelegate(instance)
        
        let channel = FlutterMethodChannel(name: ChannelName.methods.value, binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(instance, channel: channel)
        channel.setMethodCallHandler(instance.handle)
        BackgroundTaskPlugin.channel = channel
        
        let statusEventChannel = FlutterEventChannel(name: ChannelName.statusEvent.value, binaryMessenger: registrar.messenger())
        statusEventChannel.setStreamHandler(StatusEventStreamHandler())
        BackgroundTaskPlugin.statusEventChannel = statusEventChannel
        
        let beaconEventChannel = FlutterEventChannel(name: ChannelName.beaconEvent.value, binaryMessenger: registrar.messenger())
        beaconEventChannel.setStreamHandler(BeaconEventStreamHandler())
        BackgroundTaskPlugin.beaconEventChannel = beaconEventChannel
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if (call.method == "is_running_background_task") {
            result(Self.isRunning)
        } else if (call.method == "set_background_handler") {
            let args = call.arguments as? Dictionary<String, Any>
            Self.dispatcherRawHandle = args?["callbackDispatcherRawHandle"] as? Int
            Self.handlerRawHandle = args?["callbackHandlerRawHandle"] as? Int
            debugPrint("registered \(String(describing: args))")
            result(true)
        } else if (call.method == "start_beacon_task"){
            let args = call.arguments as? Dictionary<String, Any>
            let setUuid = (args?["uuid"] as? String) ?? ""
            let isEnabledEvenIfKilled = (args?["isEnabledEvenIfKilled"] as? Bool) ?? false
            Self.UUIDList[0] = setUuid
            
            let userDefaultsRepository = UserDefaultsRepository.instance
            userDefaultsRepository.removeRawHandle()
            if let dispatcherRawHandle = Self.dispatcherRawHandle, let handlerRawHandle = Self.handlerRawHandle {
                userDefaultsRepository.save(
                    callbackDispatcherRawHandle: dispatcherRawHandle,
                    callbackHandlerRawHandle: handlerRawHandle
                )
            }
            userDefaultsRepository.saveIsEnabledEvenIfKilled(isEnabledEvenIfKilled)
            
            registerDispatchEngine()
            
            let locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.requestAlwaysAuthorization()
            
            for val in Self.UUIDList{
                let uuid: NSUUID! = NSUUID(uuidString: val.lowercased())
                let identifierStr = "No1"
                Self.beaconRegion = CLBeaconRegion(uuid: uuid as UUID, identifier: identifierStr)
                Self.beaconRegion!.notifyEntryStateOnDisplay = true;
                Self.beaconRegion!.notifyOnEntry = true;
                Self.beaconRegion!.notifyOnExit = true;
                locationManager.startMonitoring(for: Self.beaconRegion!)
                print("見つけます:" + val)
            }
            Self.locationManager = locationManager
            Self.isRunning = true
            StatusEventStreamHandler.eventSink?(
                StatusEventStreamHandler.StatusType.start(message: "beacon").value
            )
            result(true)
        } else if (call.method == "stop_beacon_task"){
            for val in Self.UUIDList{
                Self.locationManager!.stopMonitoring(for: Self.beaconRegion!)
            }
            Self.isRunning = false
            StatusEventStreamHandler.eventSink?(
                StatusEventStreamHandler.StatusType.stop.value
            )
            result(true)
        }
    }
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [AnyHashable : Any] = [:]) -> Bool {
        return true
    }

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        let isEnabled = status == .authorizedAlways || status == .authorizedWhenInUse
        StatusEventStreamHandler.eventSink?(
            StatusEventStreamHandler.StatusType.permission(message: "\(isEnabled ? "enabled" : "disabled")").value
        )
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint("didFailWithError: \(error)")
        StatusEventStreamHandler.eventSink?(
            StatusEventStreamHandler.StatusType.error(message: error.localizedDescription).value
        )
    }
    
    private func registerDispatchEngine() {
        if (Self.isRegisteredDispatchEngine) {
            return
        }
        let handle = UserDefaultsRepository.instance.fetchCallbackDispatcherRawHandle()
        if let info = FlutterCallbackCache.lookupCallbackInformation(Int64(handle)) {
            Self.dispatchEngine.run(withEntrypoint: info.callbackName, libraryURI: info.callbackLibraryPath)
            Self.onRegisterDispatchEngine?()
            let dispatchChannel = FlutterMethodChannel(
                name: ChannelName.methods.value,
                binaryMessenger: Self.dispatchEngine.binaryMessenger
            )
            dispatchChannel.setMethodCallHandler { call, result in
                if (call.method == "callback_channel_initialized") {
                    dispatchChannel.invokeMethod("notify_callback_dispatcher", arguments: nil)
                    result(true)
                }
            }
            Self.dispatchChannel = dispatchChannel
            Self.isRegisteredDispatchEngine = true
        }
    }
    
    private func sendData(event: ServiceEvents, value: [String : Any?]){
        let callbackHandlerRawHandle = UserDefaultsRepository.instance.fetchCallbackHandlerRawHandle()
        let data = [
            "callbackHandlerRawHandle": callbackHandlerRawHandle,
            "data": value
        ] as [String : Any?]
        Self.dispatchChannel?.invokeMethod(event.getName(), arguments: data)
        
        
        if(event == ServiceEvents.Monitor){
            BeaconEventStreamHandler.eventSink?(
                value
            )
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("見つけ:didStartMonitoringFor")
        manager.requestState(for: region);
    }
    
    public func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        switch (state) {
        case .inside:
            print("見つかり:inside")
            self.sendData(event: ServiceEvents.Monitor, value:                 [
                "region" : (region as! CLBeaconRegion).uuid.uuidString,
                "state"  : 1
            ])
            break;
        case .outside:
            print("見つから:outside")
            self.sendData(event: ServiceEvents.Monitor, value:                 [
                "region" : (region as! CLBeaconRegion).uuid.uuidString,
                "state"  : 0
            ])
            break;
        case .unknown:
            print("iBeacon unknown")
            break;
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("見つかり:didEnterRegion")
        self.sendData(event: ServiceEvents.Monitor, value:                 [
            "region" : (region as! CLBeaconRegion).uuid.uuidString,
            "state"  : 1
        ])
    }
    
    public func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("見つから:didExitRegion")
        self.sendData(event: ServiceEvents.Monitor, value:                 [
            "region" : (region as! CLBeaconRegion).uuid.uuidString,
            "state"  : 0
        ])
    }
}
