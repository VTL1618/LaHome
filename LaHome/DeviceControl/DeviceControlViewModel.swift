//
//  DeviceControlViewModel.swift
//  LaHome
//
//  Created by Vitaly Zubenko on 02.08.2022.
//

import Foundation

protocol DeviceControlViewModelProtocol: AnyObject {
    var deviceImageName: String { get }
    var deviceModeForStatusBar: String { get }
    var deviceStateForStatusBar: String { get }
    
    var slider: Float { get }
    var switcherIsHidden: Bool { get }
    var labelOnMode: Bool { get }
    var labelOffMode: Bool { get }
    var isSwitcherOn: Bool { get }
    var productType: String { get }
    var viewModelDidChange: ((DeviceControlViewModelProtocol) -> Void)? { get set }
    init(device: Device)
    func switcherPressed()
    func sliderChanged(to value: Float)
}

class DeviceControlViewModel: DeviceControlViewModelProtocol {
    
    var deviceImageName: String {
        ImageManager.shared.fetchImageName(by: device.productType)
    }
    
    var deviceModeForStatusBar: String {
        
        if let cacheMode = DataManager.shared.getOnOffState(for: device.deviceName) {
            return cacheMode ? "ON • " : "OFF • "
            
        } else if device.mode != nil {
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
            
        } else {
            return ""
        }
    }
    
    var deviceStateForStatusBar: String {
        get {
            if let cacheMode = DataManager.shared.getSliderValue(for: String(device.id)) {
                
                return cacheMode
            } else {
                var status = String()
                
                if let state = device.intensity {
                    status = "\(state)%"
                }
                if let state = device.position {
                    status = "position: \(state)"
                }
                if let state = device.temperature {
                    status = "\(state)°"
                }
                return status
            }
        } set {
            DataManager.shared.setSliderValue(for: String(device.id), with: newValue)
            viewModelDidChange?(self)
        }
    }
    
    var slider: Float {
        if let value = DataManager.shared.getSliderValue(for: String(device.id)) {
            let intString = value.components(separatedBy: NSCharacterSet
                                                .decimalDigits
                                                .inverted)
                .joined(separator: "")
            
            return (Float(intString)! / 100)
        }
        return Float((device.intensity ?? device.position ?? device.temperature)!) / 100
    }
    
    var switcherIsHidden: Bool {
        if device.mode != nil {
            return false
        }
        return true
    }
    
    var labelOnMode: Bool {
        if device.mode != nil {
            return false
        }
        return true
    }
    
    var labelOffMode: Bool {
        if device.mode != nil {
            return false
        }
        return true
    }
    
    var isSwitcherOn: Bool {
        get {
            if let cacheMode = DataManager.shared.getOnOffState(for: device.deviceName) {
                return cacheMode
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
    
    var viewModelDidChange: ((DeviceControlViewModelProtocol) -> Void)?
    
    private let device: Device
    
    required init(device: Device) {
        self.device = device
    }
    
    func switcherPressed() {
        isSwitcherOn.toggle()
    }
    
    func sliderChanged(to value: Float) {
        let valueToInt = Int(value * 100)
        
        if device.intensity != nil {
            deviceStateForStatusBar = "\(valueToInt)%"
        }
        if device.position != nil {
            deviceStateForStatusBar = "position: \(valueToInt)"
        }
        if device.temperature != nil {
            deviceStateForStatusBar = "\(valueToInt)°"
        }
    }
}
