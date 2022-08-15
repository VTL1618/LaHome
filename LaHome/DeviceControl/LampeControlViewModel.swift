//
//  LampeControlViewModel.swift
//  LaHome
//
//  Created by Vitaly Zubenko on 13.08.2022.
//

import Foundation

protocol LampeControlViewModelProtocol: AnyObject {
    var deviceName: String { get }
    var deviceImageName: String { get }
    var deviceModeForStatusBar: String { get }
    var deviceStateForStatusBar: String { get }
    
    var slider: Float { get }
//    var switcherIsHidden: Bool { get }
//    var labelOnMode: Bool { get }
//    var labelOffMode: Bool { get }
    var isSwitcherOn: Bool { get }
    var productType: String { get }
    var viewModelDidChange: ((LampeControlViewModelProtocol) -> Void)? { get set }
    init(device: Lampe)
    func switcherPressed()
    func sliderChanged(to value: Float)
}

class LampeControlViewModel: LampeControlViewModelProtocol {
    
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
//                var status = String()
                
                guard let state = device.intensity else { return "0" }
                
//                if let state = device.position {
//                    status = "position: \(state)"
//                }
//                if let state = device.temperature {
//                    status = "\(state)°"
//                }
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
        return Float(device.intensity ?? 0)
    }
    
//    var switcherIsHidden: Bool {
//        if device.mode != nil {
//            return false
//        }
//        return true
//    }
    
//    var labelOnMode: Bool {
//        if device.mode != nil {
//            return false
//        }
//        return true
//    }
    
//    var labelOffMode: Bool {
//        if device.mode != nil {
//            return false
//        }
//        return true
//    }
    
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
    
    var viewModelDidChange: ((LampeControlViewModelProtocol) -> Void)?
    
    private let device: Lampe
    
    required init(device: Lampe) {
        self.device = device
    }
    
    func switcherPressed() {
        isSwitcherOn.toggle()
    }
    
    func sliderChanged(to value: Float) {
        
        let valueToInt = Int(value)
//        deviceStateForStatusBar = "\(valueToInt)%"
        deviceStateForStatusBar = "\(valueToInt)"
        
//        if device.position != nil {
//            deviceStateForStatusBar = "position: \(valueToInt)"
//        }
//        if device.temperature != nil {
//            deviceStateForStatusBar = "\(valueToInt)°"
//        }
    }
}
