//
//  DataManager.swift
//  LaHome
//
//  Created by Vitaly Zubenko on 05.08.2022.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private let userDefaults = UserDefaults()
    
    private init() {}
    
    func setOnOffState(for deviceName: String, with state: Bool) {
        userDefaults.set(state, forKey: deviceName)
    }
    
    func getOnOffState(for deviceName: String) -> Bool? {
        userDefaults.bool(forKey: deviceName)
    }

    func setSliderValue(for deviceId: String, with value: String) {
        userDefaults.set(value, forKey: deviceId)
    }
    
    func getSliderValue(for deviceId: String) -> String? {
        userDefaults.string(forKey: deviceId)
    }
}
