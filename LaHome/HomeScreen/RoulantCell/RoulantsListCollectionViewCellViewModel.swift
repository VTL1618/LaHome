//
//  RoulantsListCollectionViewCellViewModel.swift
//  LaHome
//
//  Created by Vitaly Zubenko on 15.08.2022.
//

import Foundation

protocol RoulantsListCollectionViewCellViewModelProtocol {
    var deviceName: String { get }
    var deviceImageName: String { get }
    var productType: String { get }
    var deviceState: String { get }
    init(device: Roulant)
}

class RoulantsListCollectionViewCellViewModel: RoulantsListCollectionViewCellViewModelProtocol {
        
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
        
        if let state = device.position {
            return String(state)
        }
        return "0"
    }
   
    private let device: Roulant
    
    required init(device: Roulant) {
        self.device = device
    }
}
