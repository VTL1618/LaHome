//
//  RadiateurListCollectionViewCellViewModel.swift
//  LaHome
//
//  Created by Vitaly Zubenko on 15.08.2022.
//

import Foundation

protocol RadiateursListCollectionViewCellViewModelProtocol {
    var deviceName: String { get }
    var deviceImageName: String { get }
    var productType: String { get }
    var deviceState: String { get }
    var isSwitcherOn: Bool { get }
    init(device: Radiateur)
}

class RadiateurListCollectionViewCellViewModel: RadiateursListCollectionViewCellViewModelProtocol {
        
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
        if let state = device.temperature {
            return String(state)
        }
        return "0"
    }
    
    var isSwitcherOn: Bool {
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
    }
    
    private let device: Radiateur
    
    required init(device: Radiateur) {
        self.device = device
    }
}
