//
//  ImageManager.swift
//  LaHome
//
//  Created by Vitaly Zubenko on 05.08.2022.
//

import Foundation
import UIKit

class ImageManager {
    
    static let shared = ImageManager()
    
    private init() {}
    
    func fetchImageName(by productType: String?) -> String {
        guard let productType = productType else { return "" }
        
        var imageName = String()
        
        switch productType {
        case "Light":
            imageName = "DeviceLightOnIcon"
        case "RollerShutter":
            imageName = "DeviceRollerShutterIcon"
        case "Heater":
            imageName = "DeviceHeaterOnIcon"
        default:
            imageName = ""
        }
        return imageName
    }
    
    func convertToGrayScale(image: UIImage) -> UIImage {
        image.withTintColor(.gray)
    }
}
