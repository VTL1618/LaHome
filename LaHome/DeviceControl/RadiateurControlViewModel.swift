//
//  RadiateurControlViewModel.swift
//  LaHome
//
//  Created by Vitaly Zubenko on 13.08.2022.
//

import Foundation

protocol RadiateurControlViewModelProtocol: AnyObject {
    var deviceName: String { get }
    var deviceImageName: String { get }
    var deviceModeForStatusBar: String { get }
    var deviceStateForStatusBar: String { get }
    
    var slider: Float { get }
    var isSwitcherOn: Bool { get }
    var productType: String { get }
    var viewModelDidChange: ((RadiateurControlViewModelProtocol) -> Void)? { get set }
    init(device: Radiateur)
    func switcherPressed()
    func sliderChanged(to value: Float)
}

class RadiateurControlViewModel: RadiateurControlViewModelProtocol {
    
    var deviceName: String {
        device.deviceName
    }
    
    var deviceImageName: String {
        ImageManager.shared.fetchImageName(by: device.productType)
    }
    
    var deviceModeForStatusBar: String {
        
        if UserDefaults.standard.object(forKey: device.deviceName) != nil {
            let cacheMode = DataManager.shared.getOnOffState(for: device.deviceName)
            return cacheMode! ? "ON • " : "OFF • "
            
        } else {
            
            var mode = String()
            
            switch device.mode {
            case "ON":
                mode = "ON • "
            case "OFF":
                mode = "OFF • "
            default:
                break
            }
            return mode
        }
    }
    
    var deviceStateForStatusBar: String {
        get {
            
            if UserDefaults.standard.object(forKey: String(device.id)) != nil {
                let cacheMode = DataManager.shared.getSliderValue(for: String(device.id))
                return cacheMode!
                
            } else {
                
                guard let state = device.temperature else { return "0" }
                return "\(state)"
                
            }
        } set {
            DataManager.shared.setSliderValue(for: String(device.id), with: newValue)
            viewModelDidChange?(self)
        }
    }
    
    var slider: Float {
        if let value = DataManager.shared.getSliderValue(for: String(device.id)) {
            return Float(value)!
        }
        return Float(device.temperature ?? 0)
    }
    
    var isSwitcherOn: Bool {
        get {
            if UserDefaults.standard.object(forKey: device.deviceName) != nil {
                let cacheMode = DataManager.shared.getOnOffState(for: device.deviceName)
                return cacheMode!
            } else {
                var mode = Bool()
                
                switch device.mode {
                case "ON":
                    mode = true
                case "OFF":
                    mode = false
                default:
                    break
                }
                return mode
            }
        } set {
            DataManager.shared.setOnOffState(for: device.deviceName, with: newValue)
            viewModelDidChange?(self)
        }
    }
    
    var productType: String {
        device.productType
    }
    
    var viewModelDidChange: ((RadiateurControlViewModelProtocol) -> Void)?
    
    private let device: Radiateur
    
    required init(device: Radiateur) {
        self.device = device
    }
    
    func switcherPressed() {
        isSwitcherOn.toggle()
    }
    
    func sliderChanged(to value: Float) {
        let valueToInt = Int(value)
        deviceStateForStatusBar = "\(valueToInt)"
    }
}
