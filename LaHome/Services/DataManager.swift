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
    
    func setOnOffState(for device: String, with state: Bool) {
        userDefaults.set(state, forKey: device)
    }
    
    func getOnOffState(for device: String) -> Bool {
        userDefaults.bool(forKey: device)
    }
    
    func setIntensity(for device: String, with intensity: Int) {
        userDefaults.set(intensity, forKey: device)
    }
    
    func getIntensity(for device: String) -> Int {
        userDefaults.integer(forKey: device)
    }
    
    func setTemperature(for device: String, with temperature: Int) {
        userDefaults.set(temperature, forKey: device)
    }
    
    func getTemperature(for device: String) -> Int {
        userDefaults.integer(forKey: device)
    }
}
