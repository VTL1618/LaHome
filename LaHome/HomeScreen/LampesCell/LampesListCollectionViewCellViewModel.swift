//
//  LampesListCollectionViewCellViewModel.swift
//  LaHome
//
//  Created by Vitaly Zubenko on 14.08.2022.
//

import Foundation

protocol LampesListCollectionViewCellViewModelProtocol {
    var deviceName: String { get }
    var deviceImageName: String { get }
    var productType: String { get }
    var deviceState: String { get }
    var isSwitcherOn: Bool { get }
    init(device: Lampe)
}

class LampesListCollectionViewCellViewModel: LampesListCollectionViewCellViewModelProtocol {
        
    var deviceName: String {
        device.deviceName
    }
    
    var deviceImageName: String {
        ImageManager.shared.fetchImageName(by: device.productType)
    }
    
    var productType: String {
        device.productType
    }
    
    var deviceState: String {
        if let cachedState = DataManager.shared.getSliderValue(for: String(device.id)) {
            return cachedState
        }
        
        if let state = device.intensity {
            return String(state)
        }
//            if let state = device.position {
//                return "position: \(state)"
//            }
//            if let state = device.temperature {
//                return "\(state)°"
//            }
        return "0"
    }
    
    var isSwitcherOn: Bool {
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
    }
    
    private let device: Lampe
    
    required init(device: Lampe) {
        self.device = device
    }
}
