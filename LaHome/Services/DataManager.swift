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
    
//    func setIntensity(for deviceName: String, with intensity: Int) {
//        userDefaults.set(intensity, forKey: deviceName)
//    }
//
//    func getIntensity(for deviceName: String) -> Int {
//        userDefaults.integer(forKey: deviceName)
//    }
    
//    func setPosition(for deviceName: String, with position: Int) {
//        userDefaults.set(position, forKey: deviceName)
//    }
//
//    func getPosition(for deviceName: String) -> Int {
//        userDefaults.integer(forKey: deviceName)
//    }
    
//    func setTemperature(for deviceName: String, with temperature: Int) {
//        userDefaults.set(temperature, forKey: deviceName)
//    }
//
//    func getTemperature(for deviceName: String) -> Int {
//        userDefaults.integer(forKey: deviceName)
//    }
    
//    func setStatusForControlPage(for deviceName: String, with state: String) {
//        userDefaults.set(state, forKey: deviceName)
//    }
//    
//    func getStatusForControlPage(for deviceName: String) -> String? {
//        userDefaults.string(forKey: deviceName)
//    }
    
    func setSliderValue(for deviceId: String, with value: String) {
        userDefaults.set(value, forKey: deviceId)
    }
    
    func getSliderValue(for deviceId: String) -> String? {
        userDefaults.string(forKey: deviceId)
    }
}
