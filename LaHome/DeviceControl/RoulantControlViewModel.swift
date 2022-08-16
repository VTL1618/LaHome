//
//  RoulantControlViewModel.swift
//  LaHome
//
//  Created by Vitaly Zubenko on 13.08.2022.
//

import Foundation

protocol RoulantControlViewModelProtocol: AnyObject {
    var deviceName: String { get }
    var deviceImageName: String { get }
    var deviceStateForStatusBar: String { get }
    var slider: Float { get }
    var productType: String { get }
    var viewModelDidChange: ((RoulantControlViewModelProtocol) -> Void)? { get set }
    init(device: Roulant)
    func sliderChanged(to value: Float)
}

class RoulantControlViewModel: RoulantControlViewModelProtocol {
    
    var deviceName: String {
        device.deviceName
    }
    
    var deviceImageName: String {
        ImageManager.shared.fetchImageName(by: device.productType)
    }
    
    var deviceStateForStatusBar: String {
        get {
            if UserDefaults.standard.object(forKey: String(device.id)) != nil {
                let cacheMode = DataManager.shared.getSliderValue(for: String(device.id))
                return cacheMode!
                
            } else {
                guard let state = device.position else { return "0" }
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
        return Float(device.position ?? 0)
    }
  
    var productType: String {
        device.productType
    }
    
    var viewModelDidChange: ((RoulantControlViewModelProtocol) -> Void)?
    
    private let device: Roulant
    
    required init(device: Roulant) {
        self.device = device
    }
    
    func sliderChanged(to value: Float) {
        let valueToInt = Int(value)
        deviceStateForStatusBar = "\(valueToInt)"
    }
}
