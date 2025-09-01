//
//  UserDefaultsRepository.swift
//  background_task
//
//  Created by 中川祥平 on 2024/01/18.
//

import Foundation

struct UserDefaultsRepository {
    static let instance = UserDefaultsRepository()
    
    enum Key: String {
        case isEnabledEvenIfKilled = "com.neverjp.background_task.isEnabledEvenIfKilled"
        case callbackDispatcherRawHandle = "com.neverjp.background_task.callbackDispatcherRawHandle"
        case callbackHandlerRawHandle = "com.neverjp.background_task.callbackHandlerRawHandle"
        var value: String {
            rawValue
        }
    }
    
    
    func save(callbackDispatcherRawHandle: Int, callbackHandlerRawHandle: Int) {
        UserDefaults.standard.setValue(callbackDispatcherRawHandle, forKey: Self.Key.callbackDispatcherRawHandle.value)
        UserDefaults.standard.setValue(callbackHandlerRawHandle, forKey: Self.Key.callbackHandlerRawHandle.value)
    }
    
    func saveIsEnabledEvenIfKilled(_ isEnabledEvenIfKilled: Bool) {
        UserDefaults.standard.setValue(isEnabledEvenIfKilled, forKey: Self.Key.isEnabledEvenIfKilled.value)
    }
    
    
    func fetchIsEnabledEvenIfKilled() -> Bool {
        return UserDefaults.standard.bool(forKey: Self.Key.isEnabledEvenIfKilled.value)
    }
    
    func fetchCallbackDispatcherRawHandle() -> Int {
        return UserDefaults.standard.integer(forKey: Self.Key.callbackDispatcherRawHandle.value)
    }
    
    func fetchCallbackHandlerRawHandle() -> Int {
        return UserDefaults.standard.integer(forKey: Self.Key.callbackHandlerRawHandle.value)
    }
    
    func removeRawHandle() {
        UserDefaults.standard.removeObject(forKey: Self.Key.callbackDispatcherRawHandle.value)
        UserDefaults.standard.removeObject(forKey: Self.Key.callbackHandlerRawHandle.value)
    }
}
